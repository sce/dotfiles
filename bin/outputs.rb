#!/usr/bin/env ruby

require 'forwardable'

class OutputQuery
  def outputs
    %x(xrandr -q).split("\n").grep(/ connected/).map do |line|
      line.split(" ").first
    end
  end
end

# By given an array of output names and an array of integers, this class will
# return outputs arranged in a matrix according to those integers. Any holes
# are correctly squeezed out to create a compact matrix.
#
# Outputs assigned "-" or nil are returned via `disable_outputs` methods.
class Matrix
  def initialize(outputs, assignments)
    self.outputs = outputs
    self.assignments = assignments
  end

  attr_reader :outputs, :assignments

  # Returns array of rows of outputs correctly laid out.
  def output_rows
    matrix.keys.sort.inject([]) do |a, row|
      # Ignore negative rows.
      next a if row < 0
      a << matrix[row].compact
      a
    end
  end

  # Returns array of outputs to disable.
  def disable_outputs
    matrix.keys.sort.inject([]) do |a, row|
      # Ignore positive rows.
      next a if row > -1
      a.concat matrix[row].compact
    end
  end

  private

  attr_writer :matrix, :outputs, :assignments

  def matrix
    @matrix ||= begin
      matrix = {}
      zipped.each do |op, yx|
        y, x = (split = yx.to_s.split("")).map(&:to_i)
        #p [op, yx, y, x]

        if ["-", nil].include? split.first
          matrix[-1] ||= []
          matrix[-1] << op

        else
          x, y = y, 0 unless x

          matrix[y] ||= []
          matrix[y][x] = op
        end
      end

      matrix
    end
  end

  alias :to_h :matrix
  public :to_h

  def zipped
    Hash[outputs.zip(assignments)]
  end

end

class OutputCommands
  extend Forwardable

  def initialize(outputs=OutputQuery.new.outputs, assignments=ARGV)
    self.outputs = outputs
    self.assignments = assignments
  end

  attr_reader :outputs, :assignments

  def run
    list.each do |cmd|
      puts cmd
      sleep 3
      %x(#{cmd})
    end
  end

  def list
    list_disable + list_enable
  end

  def list_enable
    @list_enable ||= begin
      cmds = []

      mode = "--auto"
      rows = output_rows

      # Place each output next to the previous one.
      # When start of new row, place beneath the output that's above it.
      #
      # (It's important to start at the topleft or else the behaviour of xrandr
      # is unpredictable/buggy.)
      rows.each_with_index do |row, i|
        row.each_with_index do |out, ii|
          if ii == 0 and i != 0
            above = rows[i-1][ii]
            cmds << %(xrandr --output %s %s --below %s) % [out, mode, above]

          elsif ii == 0
            cmds << %(xrandr --output %s %s)% [out, mode]

          else
            left = row[ii-1]
            cmds << %(xrandr --output %s %s --right-of %s) % [out, mode, left]
          end
        end
      end

      cmds
    end
  end

  def list_disable
    @list_disable ||= disable_outputs.map do |out|
      %(xrandr --output %s --off) % out
    end
  end

  private

  attr_writer :outputs, :assignments

  delegate [:output_rows, :disable_outputs] => :matrix

  def matrix
    @matrix ||= Matrix.new(outputs, assignments)
  end
end

if ARGV.empty?
  puts (<<-EOS).gsub(/^ {4}/, "") % [$0, OutputQuery.new.outputs.join(", ")]
    Place outputs in a matrix by assigning "yx" coordinates, or use "-" to
    disable a display.

    E.g. for outputs: VGA-1 VGA-2 DVI-1 DVI-2,
    $ %s 21 22 2 1 would produce the following matrix:
      DVI-2 DVI-1
      VGA-1 VGA-2

    Currently connected outputs: %s.
  EOS

else
  cmds = OutputCommands.new
  puts cmds.list, nil
  cmds.run
end
