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

    options = @options.map do |opt|
      %(#{opt[0].inspect} #{opt[1].inspect} #{opt[2]})
    end

    cmd = %W(
      Xdialog
        --stdout
        --title "#@title"
        --backtitle "#@backtitle"
        --radiolist "#@text"
          0 0 0
          #{options.join(" ")}
    ).join(" ")
    puts cmd
    p %x(#{cmd}).strip
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
