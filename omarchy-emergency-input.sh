#!/usr/bin/env python3
import sys
import subprocess
import gi

gi.require_version('Gtk', '4.0')
from gi.repository import Gtk, Gdk, GLib

class EmergencyInputApp(Gtk.Application):
    def __init__(self):
        super().__init__(application_id="com.omarchy.emergency.input")

    def do_activate(self):
        window = Gtk.ApplicationWindow(application=self)
        window.set_title("Emergency JP Input")
        window.set_default_size(600, 400)
        
        # Main Layout
        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        vbox.set_margin_top(10)
        vbox.set_margin_bottom(10)
        vbox.set_margin_start(10)
        vbox.set_margin_end(10)
        window.set_child(vbox)

        # Instructions
        label = Gtk.Label(label="Type text. Press Ctrl+Enter to Copy & Close.")
        label.set_halign(Gtk.Align.START)
        vbox.append(label)

        # Text Area
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_vexpand(True)
        
        self.text_view = Gtk.TextView()
        self.text_view.set_wrap_mode(Gtk.WrapMode.WORD_CHAR)
        self.text_view.set_left_margin(10)
        self.text_view.set_right_margin(10)
        self.text_view.set_top_margin(10)
        self.text_view.set_bottom_margin(10)
        
        # Increase font size via CSS
        css_provider = Gtk.CssProvider()
        css_provider.load_from_data(b"textview { font-size: 16pt; font-family: Sans; }")
        self.text_view.get_style_context().add_provider(css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)
        
        self.text_buffer = self.text_view.get_buffer()
        scrolled_window.set_child(self.text_view)
        vbox.append(scrolled_window)

        # Buttons
        bbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        bbox.set_halign(Gtk.Align.END)
        vbox.append(bbox)

        btn_cancel = Gtk.Button(label="Cancel")
        btn_cancel.connect("clicked", lambda x: window.close())
        bbox.append(btn_cancel)

        btn_copy = Gtk.Button(label="Copy (Ctrl+Enter)")
        btn_copy.get_style_context().add_class("suggested-action")
        btn_copy.connect("clicked", self.on_copy_clicked)
        bbox.append(btn_copy)

        # Key Controller for Ctrl+Enter
        key_controller = Gtk.EventControllerKey()
        key_controller.set_propagation_phase(Gtk.PropagationPhase.CAPTURE) # Capture event before TextView consumes it
        key_controller.connect("key-pressed", self.on_key_pressed)
        window.add_controller(key_controller)

        window.present()

    def on_key_pressed(self, controller, keyval, keycode, state):
        # Escape to close
        if keyval == Gdk.KEY_Escape:
            self.get_active_window().close()
            return True
        
        # Ctrl+Enter (or Ctrl+Return) to Copy & Close
        if (state & Gdk.ModifierType.CONTROL_MASK):
            if keyval == Gdk.KEY_Return or keyval == Gdk.KEY_KP_Enter:
                self.on_copy_clicked(None)
                return True
        
        return False

    def on_copy_clicked(self, button):
        start_iter = self.text_buffer.get_start_iter()
        end_iter = self.text_buffer.get_end_iter()
        text = self.text_buffer.get_text(start_iter, end_iter, True)
        
        if text:
            try:
                # Use wl-copy specifically as requested for Omarchy integration
                p = subprocess.Popen(['wl-copy'], stdin=subprocess.PIPE)
                p.communicate(input=text.encode('utf-8'))
                
                # Notify
                subprocess.run(['notify-send', 'Copied!', 'Text saved to clipboard.'])
            except Exception as e:
                print(f"Error: {e}")
        
        self.get_active_window().close()

if __name__ == "__main__":
    app = EmergencyInputApp()
    app.run(sys.argv)
