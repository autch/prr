
require 'gtk2'

module PlayRiteRuntime
  def errorbreakmode(*params)
    
  end

  def message(caption, timeout = 0)
    msg = Gtk::MessageDialog.new(nil, Gtk::Dialog::MODAL, Gtk::MessageDialog::INFO,
				      Gtk::MessageDialog::BUTTONS_OK, caption)
    msg.run
    msg.destroy
  end

  def existfile(filename)
    File.exist?(filename)
  end

  def getoptionfile()
    { 'マクロ' => Dir.pwd + File::SEPARATOR }
  end

  def breakdownpath(pathname)
    { 'drive' => '', 'directory' => pathname }
  end

  def exact(lefthand, righthand, length = 0)
    if length != 0 then
      lefthand[0, length] == righthand[0, length]
    else
      lefthand == righthand
    end
  end

  def guidance(message)
    puts message
  end

  def stop()
    exit
  end

end
