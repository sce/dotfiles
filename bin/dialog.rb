#!/usr/bin/env ruby

# This requires Xdialog utility to be installed (e.g. via "xdialog" package).

module DialogBase
  def sane?
    system "which Xdialog"
  end

  def run
    raise %(Can't continue without Xdialog) unless sane?
  end

  private

  def exec cmd
    # prevent "no implicit conversion from (e.g.) Integer into String":
    args = cmd.map {|s| s.to_s }
    p args
    pipe = IO.popen(args)
    choice = pipe.read.strip
    Process.wait pipe.pid
    choice
  end
end

class Dialog
  include DialogBase

  def initialize title: nil, backtitle: nil, text: nil, options: [], width: 60, height: 40, listheight: 0
    @title = title
    @backtitle = backtitle
    @text = text
    @options = options
    @width = width
    @height = height
    @listheight = listheight
  end

  def run
    super

    cmd = %W(
      Xdialog
        --stdout
        --left
        --title #@title
        --backtitle #@backtitle
        --radiolist #@text
          #@height #@width #@listheight
    )
    cmd.concat @options.flatten
    exec cmd
  end
end

if __FILE__ == $0
  options = [
    ["Tiger", "A dangerous animal", "off"],
    ["Dog", "No that's not my dog", "ON"],
  ]
  dialog = Dialog.new title: "Test", backtitle: "This is a test", text: "Choose resolution", options: options
  ret = dialog.run

  puts "chosen:", ret.inspect
end
