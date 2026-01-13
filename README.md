# Omarchy Emergency JP Input

A lightweight helper for emergency Japanese input in Hyprland environments.
Implemented in **Ruby** (GTK3) to ensure a clean, reliable, and modifiable script without Python dependencies.

## Requirement

- `ruby`
- `ruby-gtk3` (Arch: `ruby-gtk3`, Debian/Ubuntu: `ruby-gtk3`)
- `wl-clipboard`
- `fcitx5`

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
2. Type text in the window.
3. **Press `Ctrl + Enter`**: Copies text to clipboard and closes the window.
