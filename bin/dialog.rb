#!/usr/bin/env ruby

# This requires Xdialog utility to be installed (e.g. via "xdialog" package).

class Dialog
  def initialize title: nil, backtitle: nil, text: nil, options: []
    @title = title
    @backtitle = backtitle
    @text = text
    @options = options
  end

  def sane?
    system "which Xdialog"
  end

  def run
    raise %(Can't continue without Xdialog) unless sane?

    cmd = %W(
      Xdialog
        --stdout
        --left
        --title #@title
        --backtitle #@backtitle
        --radiolist #@text
          0 0 0
    )
    cmd.concat @options.flatten
    exec cmd
  end

  private

  def exec cmd
    p cmd
    pipe = IO.popen(cmd)
    choice = pipe.read.strip
    Process.wait pipe.pid
    choice
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
