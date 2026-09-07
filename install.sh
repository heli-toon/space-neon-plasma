#!/usr/bin/env bash
# Space Neon Orange - Automated KDE Plasma Installer

set -e

# Color definitions for output
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${ORANGE}========================================${NC}"
echo -e "${ORANGE} Installing Space Neon Orange Theme... ${NC}"
echo -e "${ORANGE}========================================${NC}"

# Define target directories
COLOR_DIR="$HOME/.local/share/color-schemes"
GTK3_DIR="$HOME/.config/gtk-3.0"
GTK4_DIR="$HOME/.config/gtk-4.0"
KONSOLE_DIR="$HOME/.local/share/konsole"
PLASMA_THEME_DIR="$HOME/.local/share/plasma/desktoptheme"
WALLPAPER_DIR="$HOME/.local/share/wallpapers/SpaceNeonOrange/contents/images"
ICON_DIR="$HOME/.local/share/icons"
ROFI_DIR="$HOME/.config/rofi"
BIN_DIR="$HOME/.local/bin"
APPLICATIONS_DIR="$HOME/.local/share/applications"
FONT_VALUE="JetBrainsMono Nerd Font Mono,10,-1,5,50,0,0,0,0,0"
FONT_TOOLBAR="JetBrainsMono Nerd Font Mono,9,-1,5,50,0,0,0,0,0"
FONT_SMALL="JetBrainsMono Nerd Font Mono,8,-1,5,50,0,0,0,0,0"
SCALABLE_ICON_DIR="$HOME/.local/share/icons/hicolor/scalable/apps"

# Create directories if they don't exist
mkdir -p "$COLOR_DIR" "$GTK3_DIR" "$GTK4_DIR" "$KONSOLE_DIR" "$PLASMA_THEME_DIR" "$WALLPAPER_DIR" "$ICON_DIR" "$SCALABLE_ICON_DIR" "$ROFI_DIR" "$BIN_DIR" "$APPLICATIONS_DIR"

# Get current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Copy configurations
echo -e "${GREEN}[+] Copying color schemes, GTK overrides, icons...${NC}"
cp -f "$SCRIPT_DIR/color-schemes/SpaceNeonOrange.colors" "$COLOR_DIR/"
cp -f "$SCRIPT_DIR/gtk/gtk-3.0/gtk.css" "$GTK3_DIR/"
cp -f "$SCRIPT_DIR/gtk/gtk-4.0/gtk.css" "$GTK4_DIR/"
[ -f "$SCRIPT_DIR/konsole/SpaceNeonOrange.colorscheme" ] && cp -f "$SCRIPT_DIR/konsole/SpaceNeonOrange.colorscheme" "$KONSOLE_DIR/"
[ -d "$SCRIPT_DIR/plasma/desktoptheme/SpaceNeonMinimal" ] && cp -rf "$SCRIPT_DIR/plasma/desktoptheme/SpaceNeonMinimal" "$PLASMA_THEME_DIR/"
[ -f "$SCRIPT_DIR/wallpapers/space-neon-orange-nebula.jpg" ] && cp -f "$SCRIPT_DIR/wallpapers/space-neon-orange-nebula.jpg" "$WALLPAPER_DIR/"
[ -f "$SCRIPT_DIR/rofi/config.rasi" ] && cp -f "$SCRIPT_DIR/rofi/config.rasi" "$ROFI_DIR/config.rasi"
[ -f "$SCRIPT_DIR/rofi/space-neon-launcher" ] && install -m 755 "$SCRIPT_DIR/rofi/space-neon-launcher" "$BIN_DIR/space-neon-launcher"
[ -f "$SCRIPT_DIR/rofi/space-neon-launcher.desktop" ] && cp -f "$SCRIPT_DIR/rofi/space-neon-launcher.desktop" "$APPLICATIONS_DIR/"

# Antigravity & Start Menu icon installation
if [ -f "$SCRIPT_DIR/icons/antigravity.svg" ]; then
    cp -f "$SCRIPT_DIR/icons/antigravity.svg" "$SCALABLE_ICON_DIR/antigravity.svg"
    cp -f "$SCRIPT_DIR/icons/antigravity.svg" "$ICON_DIR/antigravity.svg"
fi
if [ -f "$SCRIPT_DIR/icons/start-here-kde.svg" ]; then
    cp -f "$SCRIPT_DIR/icons/start-here-kde.svg" "$SCALABLE_ICON_DIR/start-here-kde.svg"
    cp -f "$SCRIPT_DIR/icons/start-here-kde.svg" "$SCALABLE_ICON_DIR/start-here.svg"
    cp -f "$SCRIPT_DIR/icons/start-here-kde.svg" "$SCALABLE_ICON_DIR/kde.svg"
    cp -f "$SCRIPT_DIR/icons/start-here-kde.svg" "$ICON_DIR/start-here-kde.svg"
    cp -f "$SCRIPT_DIR/icons/start-here-kde.svg" "$ICON_DIR/start-here.svg"
    cp -f "$SCRIPT_DIR/icons/start-here-kde.svg" "$ICON_DIR/kde.svg"
    [ -d "$ICON_DIR/YAMIS/places/scalable" ] && cp -f "$SCRIPT_DIR/icons/start-here-kde.svg" "$ICON_DIR/YAMIS/places/scalable/start-here-kde.svg"
    [ -d "$ICON_DIR/YAMIS/places/scalable" ] && cp -f "$SCRIPT_DIR/icons/start-here-kde.svg" "$ICON_DIR/YAMIS/places/scalable/start-here.svg"
    [ -d "$ICON_DIR/YAMIS/places/scalable" ] && cp -f "$SCRIPT_DIR/icons/start-here-kde.svg" "$ICON_DIR/YAMIS/places/scalable/kde.svg"
fi
if [ -f "$APPLICATIONS_DIR/antigravity.desktop" ]; then
    sed -i 's|^Icon=.*|Icon=antigravity|' "$APPLICATIONS_DIR/antigravity.desktop"
fi

# Apply KDE Color Scheme & Fonts programmatically (supports Plasma 5 & Plasma 6)
echo -e "${GREEN}[+] Applying Plasma Color Scheme and Fonts...${NC}"
if command -v kwriteconfig6 &> /dev/null; then
    kwriteconfig6 --file kdeglobals --group General --key ColorScheme "SpaceNeonOrange"
    kwriteconfig6 --file kdeglobals --group General --key AccentColor "255,107,0"
    kwriteconfig6 --file kdeglobals --group General --key font "$FONT_VALUE"
    kwriteconfig6 --file kdeglobals --group General --key fixed "$FONT_VALUE"
    kwriteconfig6 --file kdeglobals --group General --key menuFont "$FONT_VALUE"
    kwriteconfig6 --file kdeglobals --group General --key toolbarFont "$FONT_TOOLBAR"
    kwriteconfig6 --file kdeglobals --group General --key activeFont "$FONT_VALUE"
    kwriteconfig6 --file kdeglobals --group General --key smallestReadableFont "$FONT_SMALL"
    kwriteconfig6 --file kdeglobals --group WM --key activeFont "$FONT_VALUE"
elif command -v kwriteconfig5 &> /dev/null; then
    kwriteconfig5 --file kdeglobals --group General --key ColorScheme "SpaceNeonOrange"
    kwriteconfig5 --file kdeglobals --group General --key AccentColor "255,107,0"
    kwriteconfig5 --file kdeglobals --group General --key font "$FONT_VALUE"
    kwriteconfig5 --file kdeglobals --group General --key fixed "$FONT_VALUE"
    kwriteconfig5 --file kdeglobals --group General --key menuFont "$FONT_VALUE"
    kwriteconfig5 --file kdeglobals --group General --key toolbarFont "$FONT_TOOLBAR"
    kwriteconfig5 --file kdeglobals --group General --key activeFont "$FONT_VALUE"
    kwriteconfig5 --file kdeglobals --group General --key smallestReadableFont "$FONT_SMALL"
    kwriteconfig5 --file kdeglobals --group WM --key activeFont "$FONT_VALUE"
else
    echo "[!] kwriteconfig5/6 not found — color scheme file was copied but not auto-applied."
fi

# YAMIS is adaptive: it follows the Plasma foreground colour, so the icons
# stay monochrome while the orange accent remains reserved for interaction.
if [ -f "$ICON_DIR/YAMIS/index.theme" ]; then
    if command -v kwriteconfig6 &> /dev/null; then
        kwriteconfig6 --file kdeglobals --group Icons --key Theme "YAMIS"
    elif command -v kwriteconfig5 &> /dev/null; then
        kwriteconfig5 --file kdeglobals --group Icons --key Theme "YAMIS"
    fi
else
    echo "[!] YAMIS is not installed. Install it from System Settings → Icons → Get New…, then re-run this script."
fi

if command -v plasma-apply-wallpaperimage &> /dev/null && [ -f "$WALLPAPER_DIR/space-neon-orange-nebula.jpg" ]; then
    plasma-apply-wallpaperimage "$WALLPAPER_DIR/space-neon-orange-nebula.jpg" || true
fi

# Reload KWin to apply instantly
echo -e "${GREEN}[+] Reloading window manager...${NC}"
if command -v qdbus6 &> /dev/null; then
    qdbus6 org.kde.KWin /KWin org.kde.KWin.reconfigure 2>/dev/null || true
elif command -v qdbus &> /dev/null; then
    qdbus org.kde.KWin /KWin org.kde.KWin.reconfigure 2>/dev/null || true
fi

echo -e "${ORANGE}========================================${NC}"
echo -e "${GREEN} Success! Theme installed and applied. ${NC}"
echo -e "${ORANGE}========================================${NC}"
echo "Note: some apps (GTK, Konsole profile selection) may need a restart to pick up the new theme."
