#!/bin/bash
set -e

# Define paths
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="omarchy-emergency-input.sh"
CONFIG_NAME="omarchy-emergency-input.conf"

DEST_SCRIPT_DIR="$HOME/.config/hypr/scripts"
DEST_CONFIG_DIR="$HOME/.config/hypr"

DEST_SCRIPT="$DEST_SCRIPT_DIR/$SCRIPT_NAME"
DEST_CONFIG="$DEST_CONFIG_DIR/$CONFIG_NAME"

# Colors
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

echo "Installing omarchy-emergency-input..."

# 1. Install the script
if [ ! -d "$DEST_SCRIPT_DIR" ]; then
    mkdir -p "$DEST_SCRIPT_DIR"
    echo "Created directory: $DEST_SCRIPT_DIR"
fi

cp "$SOURCE_DIR/$SCRIPT_NAME" "$DEST_SCRIPT"
chmod +x "$DEST_SCRIPT"
echo -e "${GREEN}Installed script to: $DEST_SCRIPT${RESET}"

# 2. Install the config file
if [ ! -d "$DEST_CONFIG_DIR" ]; then
    mkdir -p "$DEST_CONFIG_DIR"
fi

cp "$SOURCE_DIR/$CONFIG_NAME" "$DEST_CONFIG"
echo -e "${GREEN}Installed config to: $DEST_CONFIG${RESET}"

# 3. Print instructions for the user
echo ""
echo "------------------------------------------------------------------"
echo -e "${GREEN}Installation successful!${RESET}"
echo ""
echo -e "To enable, please add the following line to your"
echo -e "${YELLOW}~/.config/hypr/hyprland.conf${RESET}:"
echo ""
echo -e "    ${YELLOW}source = $DEST_CONFIG${RESET}"
echo ""
echo "After adding the line, run 'hyprctl reload' to apply changes."
echo "------------------------------------------------------------------"
