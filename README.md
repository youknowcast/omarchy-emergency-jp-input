# Omarchy Emergency JP Input

A lightweight helper for emergency Japanese input in Hyprland environments.
Uses a minimal Python GTK4 script to ensure **Ctrl+Enter** works reliably for copying text, while maintaining full IME compatibility.

## Requirement

- `python3-gobject` (Standard on most Linux desktops)
- `wl-clipboard` (for `wl-copy`)
- `fcitx5` (running in the background)

## Installation

Run the install script:

```bash
chmod +x install.sh
./install.sh
```

This installs:
- Script: `~/.config/hypr/scripts/omarchy-emergency-input.sh`
- Config: `~/.config/hypr/omarchy-emergency-input.conf`

## Configuration

Add the following to your `~/.config/hypr/hyprland.conf`:

```ini
source = ~/.config/hypr/omarchy-emergency-input.conf
```

Reload Hyprland (`hyprctl reload`) to apply.

## Usage

1. Press `Super + J` (Default).
2. Type text in the window (IME works normally).
   - `Enter`: Confirm conversion or New line.
3. **Press `Ctrl + Enter`**: Copies text to clipboard and closes the window.
   - Or click "Copy" button.
