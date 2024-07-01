# main.rb

require 'bundler/setup'
require 'gtk3'
require_relative 'lib/functions'

class UtilityTool < Gtk::Window
  def initialize
    super

    set_title "burnX"
    set_default_size 600, 600
    set_window_position :center
    set_icon_from_file(File.expand_path('assets/icon.png', __dir__))

    init_ui

    signal_connect "destroy" do
      Gtk.main_quit
    end

    show_all
  end

  def init_ui
    style_provider = Gtk::CssProvider.new
    style_provider.load(data: <<-CSS)
      entry, combobox, textview {
        background-color: #FFFFFF;
        color: #000000;
      }
      .title {
        font-family: 'Neuropol', sans-serif;
        font-size: 24px;
        font-weight: bold;
      }
    CSS

    Gtk::StyleContext.add_provider_for_screen(
      Gdk::Screen.default,
      style_provider,
      Gtk::StyleProvider::PRIORITY_USER
    )

    vbox = Gtk::Box.new(:vertical, 10)
    vbox.set_margin_top(20)
    vbox.set_margin_bottom(20)
    vbox.set_margin_left(20)
    vbox.set_margin_right(20)
    add(vbox)

    # Title and Logo
    title_hbox = Gtk::Box.new(:horizontal, 10)
    title_hbox.halign = Gtk::Align::CENTER
    vbox.pack_start(title_hbox, :expand => false, :fill => false, :padding => 5)

    # Add image
    image = Gtk::Image.new(file: File.expand_path('assets/image.png', __dir__))
    title_hbox.pack_start(image, :expand => false, :fill => false, :padding => 5)

    # Add title
    title = Gtk::Label.new("burnX")
    title.style_context.add_class("title")
    title_hbox.pack_start(title, :expand => true, :fill => true, :padding => 5)

    # Input descriptions and fields
    desc_copy = Gtk::Label.new("Copies a file from the input location to the output location.")
    desc_copy.set_margin_top(10)
    desc_copy.halign = Gtk::Align::CENTER
    vbox.pack_start(desc_copy, :expand => false, :fill => false, :padding => 5)

    input1_hbox = Gtk::Box.new(:horizontal, 5)
    input1 = Gtk::Entry.new
    input1.set_placeholder_text("Input File/Directory")
    input1_hbox.pack_start(input1, :expand => true, :fill => true, :padding => 5)
    input1_button = Gtk::Button.new(label: "Browse")
    input1_button.signal_connect "clicked" do
      dialog = Gtk::FileChooserDialog.new(
        title: "Select Input File/Directory",
        parent: self,
        action: Gtk::FileChooser::Action::OPEN,
        buttons: [[Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL], [Gtk::Stock::OPEN, Gtk::ResponseType::ACCEPT]]
      )
      if dialog.run == Gtk::ResponseType::ACCEPT
        input1.text = dialog.filename
      end
      dialog.destroy
    end
    input1_hbox.pack_start(input1_button, :expand => false, :fill => false, :padding => 5)
    vbox.pack_start(input1_hbox, :expand => false, :fill => false, :padding => 5)

    desc_output = Gtk::Label.new("Output File/Device.")
    desc_output.set_margin_top(10)
    desc_output.halign = Gtk::Align::CENTER
    vbox.pack_start(desc_output, :expand => false, :fill => false, :padding => 5)

    input2_hbox = Gtk::Box.new(:horizontal, 5)
    input2 = Gtk::Entry.new
    input2.set_placeholder_text("Output File/Device")
    input2_hbox.pack_start(input2, :expand => true, :fill => true, :padding => 5)
    input2_button = Gtk::Button.new(label: "Browse")
    input2_button.signal_connect "clicked" do
      dialog = Gtk::FileChooserDialog.new(
        title: "Select Output File/Device",
        parent: self,
        action: Gtk::FileChooser::Action::SAVE,
        buttons: [[Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL], [Gtk::Stock::SAVE, Gtk::ResponseType::ACCEPT]]
      )
      if dialog.run == Gtk::ResponseType::ACCEPT
        input2.text = dialog.filename
      end
      dialog.destroy
    end
    input2_hbox.pack_start(input2_button, :expand => false, :fill => false, :padding => 5)
    vbox.pack_start(input2_hbox, :expand => false, :fill => false, :padding => 5)

    button_hbox = Gtk::Box.new(:horizontal, 10)
    button_hbox.halign = Gtk::Align::CENTER
    vbox.pack_start(button_hbox, :expand => false, :fill => false, :padding => 10)

    execute_button = Gtk::Button.new(label: "Execute")
    execute_button.signal_connect "clicked" do
      command = combo.active_text
      input1_text = input1.text
      input2_text = input2.text

      begin
        case command
        when 'copy'
          copy_file(input1_text, input2_text)
          message_dialog("Success", "File copied successfully!")
        when 'iso'
          create_iso(input1_text, input2_text)
          message_dialog("Success", "ISO created successfully!")
        when 'burn'
          burn_cd_dvd(input1_text, input2_text)
          message_dialog("Success", "CD/DVD burned successfully!")
        when 'dmg'
          burn_dmg(input1_text, input2_text)
          message_dialog("Success", "DMG burned successfully!")
        when 'installmedia'
          create_install_media(input1_text, input2_text)
          message_dialog("Success", "Install media created successfully!")
        else
          message_dialog("Error", "Unknown command: #{command}")
        end
      rescue => e
        message_dialog("Error", e.message)
      end
    end
    button_hbox.pack_start(execute_button, :expand => false, :fill => false, :padding => 5)

    clear_button = Gtk::Button.new(label: "Clear")
    clear_button.signal_connect "clicked" do
      input1.text = ""
      input2.text = ""
    end
    button_hbox.pack_start(clear_button, :expand => false, :fill => false, :padding => 5)

    # Create combo box for command selection
    combo = Gtk::ComboBoxText.new
    combo.append_text('copy')
    combo.append_text('iso')
    combo.append_text('burn')
    combo.append_text('dmg')
    combo.append_text('installmedia')
    combo.active = 0
    combo.set_margin_top(10)
    vbox.pack_start(combo, :expand => false, :fill => false, :padding => 5)

    # Update description based on selected command
    combo.signal_connect "changed" do
      case combo.active_text
      when 'copy'
        desc_copy.set_text("Copies a file from the input location to the output location.")
        desc_output.set_text("Output File/Device.")
      when 'iso'
        desc_copy.set_text("Creates an ISO image from the specified source directory.")
        desc_output.set_text("Output ISO file.")
      when 'burn'
        desc_copy.set_text("Burns a CD/DVD from the specified image file.")
        desc_output.set_text("CD/DVD Device.")
      when 'dmg'
        desc_copy.set_text("Burns a DMG file to the specified device.")
        desc_output.set_text("USB/CD Device.")
      when 'installmedia'
        desc_copy.set_text("Creates install media for MacOS from the specified .app file to the volume.")
        desc_output.set_text("Target Volume.")
      end
    end
  end

  def message_dialog(title, message)
    dialog = Gtk::MessageDialog.new(
      :parent => self,
      :flags => :destroy_with_parent,
      :type => :info,
      :buttons_type => :close,
      :message => message
    )
    dialog.title = title
    dialog.run
    dialog.destroy
  end
end

window = UtilityTool.new
Gtk.main
