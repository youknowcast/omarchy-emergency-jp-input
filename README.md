# Omarchy Emergency JP Input

A lightweight helper for emergency Japanese input in Hyprland environments.

It provides a standalone GTK3 window that reliably accepts Japanese input (via `fcitx5` etc.) and copies the result to the clipboard. This is designed as a fallback for when the IME detaches from Electron apps, games, or after suspend/resume cycles.

Implemented in **Ruby** (GTK3) for simplicity and reliability, ensuring proper handling of `Ctrl+Enter` which standard dialog tools often miss.

## Features

- **Reliable Keybindings**: 
  - `Ctrl + Enter`: Copy text to clipboard and close window.
  - `Enter`: Confirm IME conversion or insert newline.
  - `Esc`: Cancel and close.
- **Clipboard Integration**: Uses `wl-copy` to seamlessly integrate with Wayland clipboard managers (like `cliphist`).
- **Hyprland Ready**: Comes with window rules to float, center, and stay focused.

## Requirements

- **Ruby**: `ruby`
- **Ruby GTK3 Bindings**: 
  - Arch Linux: `pacman -S ruby-gtk3`
  - Debian/Ubuntu: `apt install ruby-gtk3`
- **Wayland Clipboard**: `wl-clipboard`
- **IME**: `fcitx5` (must be running)

## Installation

1. Clone or download this repository.
2. Run the install script:

```bash
chmod +x install.sh
./install.sh
```

This installs:
- Script: `~/.config/hypr/scripts/omarchy-emergency-input.sh`
- Config: `~/.config/hypr/omarchy-emergency-input.conf`

## Configuration

Add the following line to your `~/.config/hypr/hyprland.conf`:

```ini
source = ~/.config/hypr/omarchy-emergency-input.conf
```

Reload Hyprland (`hyprctl reload`) to apply changes.

## Usage

1. Press **`Super + U`** (Default keybinding).
2. The window appears in the center of the screen.
3. Type your text. IME functions (Henkan) work normally.
4. When finished, press **`Ctrl + Enter`** (or click the Copy button).
5. The text is copied to your clipboard and the window closes.
6. Paste (`Ctrl + V`) into your target application.

## Troubleshooting

### "Error: cannot load such file -- gtk3"
Ensure you have the ruby bindings installed via your package manager (`ruby-gtk3`), not just the gem. Compiling the gem manually can be slow and error-prone.

### Window not floating?
Ensure you have sourced the config file in your `hyprland.conf` and reloaded.
