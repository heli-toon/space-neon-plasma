#!/usr/bin/env bash
# Space Neon Minimal - Automated KDE Plasma Installer

set -e

# Color definitions for output
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${ORANGE}========================================${NC}"
echo -e "${ORANGE} Installing Space Neon Minimal Theme... ${NC}"
echo -e "${ORANGE}========================================${NC}"

# Define target directories
COLOR_DIR="$HOME/.local/share/color-schemes"
GTK3_DIR="$HOME/.config/gtk-3.0"
GTK4_DIR="$HOME/.config/gtk-4.0"
KONSOLE_DIR="$HOME/.local/share/konsole"
PLASMA_THEME_DIR="$HOME/.local/share/plasma/desktoptheme"
PLASMA_LOOKANDFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
WALLPAPER_DIR="$HOME/.local/share/wallpapers/SpaceNeonPlasmaMinimal/contents/images"
SDDM_THEME_DIR="$HOME/.local/share/sddm/themes"
ICON_DIR="$HOME/.local/share/icons"
ROFI_DIR="$HOME/.config/rofi"
BIN_DIR="$HOME/.local/bin"
APPLICATIONS_DIR="$HOME/.local/share/applications"
FONT_VALUE="JetBrainsMono Nerd Font Mono,10,-1,5,50,0,0,0,0,0"
FONT_TOOLBAR="JetBrainsMono Nerd Font Mono,9,-1,5,50,0,0,0,0,0"
FONT_SMALL="JetBrainsMono Nerd Font Mono,8,-1,5,50,0,0,0,0,0"
SCALABLE_ICON_DIR="$HOME/.local/share/icons/hicolor/scalable/apps"

# Create directories if they don't exist
mkdir -p "$COLOR_DIR" "$GTK3_DIR" "$GTK4_DIR" "$KONSOLE_DIR" "$PLASMA_THEME_DIR" "$PLASMA_LOOKANDFEEL_DIR" "$WALLPAPER_DIR" "$SDDM_THEME_DIR" "$ICON_DIR" "$SCALABLE_ICON_DIR" "$ROFI_DIR" "$BIN_DIR" "$APPLICATIONS_DIR"

# Get current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Copy configurations
echo -e "${GREEN}[+] Copying color schemes, Plasma themes, icons...${NC}"
cp -f "$SCRIPT_DIR/color-schemes/SpaceNeonPlasmaMinimal.colors" "$COLOR_DIR/"

# GTK CSS files are session-global — they are read by every GTK app regardless
# of which desktop environment is active. Only deploy them inside a KDE Plasma
# session to avoid bleeding Space Neon colours into Xfce, Cinnamon, etc.
# Pass --force-gtk to override this guard explicitly.
_CURRENT_DE="${XDG_CURRENT_DESKTOP:-${DESKTOP_SESSION:-unknown}}"
_IS_KDE=false
case "${_CURRENT_DE,,}" in
    *kde*|*plasma*) _IS_KDE=true ;;
esac
[[ " $* " == *" --force-gtk "* ]] && _IS_KDE=true

if $_IS_KDE; then
    echo -e "${GREEN}[+] Applying GTK overrides (KDE Plasma session detected)...${NC}"
    cp -f "$SCRIPT_DIR/gtk/gtk-3.0/gtk.css" "$GTK3_DIR/"
    cp -f "$SCRIPT_DIR/gtk/gtk-4.0/gtk.css" "$GTK4_DIR/"
else
    echo -e "${ORANGE}[~] Skipping GTK CSS — not running inside KDE Plasma.${NC}"
    echo -e "${ORANGE}    Your Xfce/Cinnamon GTK theme is untouched.${NC}"
    echo -e "${ORANGE}    Re-run with --force-gtk to override this guard.${NC}"
fi
[ -f "$SCRIPT_DIR/konsole/SpaceNeonPlasmaMinimal.colorscheme" ] && cp -f "$SCRIPT_DIR/konsole/SpaceNeonPlasmaMinimal.colorscheme" "$KONSOLE_DIR/"
[ -d "$SCRIPT_DIR/plasma/desktoptheme/SpaceNeonPlasmaMinimal" ] && cp -rf "$SCRIPT_DIR/plasma/desktoptheme/SpaceNeonPlasmaMinimal" "$PLASMA_THEME_DIR/"
[ -d "$SCRIPT_DIR/plasma/look-and-feel/SpaceNeonPlasmaMinimal" ] && cp -rf "$SCRIPT_DIR/plasma/look-and-feel/SpaceNeonPlasmaMinimal" "$PLASMA_LOOKANDFEEL_DIR/"
[ -d "$SCRIPT_DIR/plasma/look-and-feel/SpaceNeonSplash" ] && cp -rf "$SCRIPT_DIR/plasma/look-and-feel/SpaceNeonSplash" "$PLASMA_LOOKANDFEEL_DIR/"
[ -f "$SCRIPT_DIR/wallpapers/space-neon-orange-nebula.jpg" ] && cp -f "$SCRIPT_DIR/wallpapers/space-neon-orange-nebula.jpg" "$WALLPAPER_DIR/"
[ -d "$SCRIPT_DIR/sddm/SpaceNeonSDDM/themes/SpaceNeonPlasmaMinimal" ] && cp -rf "$SCRIPT_DIR/sddm/SpaceNeonSDDM/themes/SpaceNeonPlasmaMinimal" "$SDDM_THEME_DIR/"
[ -d "$SCRIPT_DIR/aurorae/themes/SpaceNeonPlasmaMinimal" ] && mkdir -p "$HOME/.local/share/aurorae/themes" && cp -rf "$SCRIPT_DIR/aurorae/themes/SpaceNeonPlasmaMinimal" "$HOME/.local/share/aurorae/themes/"
[ -f "$SCRIPT_DIR/rofi/config.rasi" ] && cp -f "$SCRIPT_DIR/rofi/config.rasi" "$ROFI_DIR/config.rasi"
[ -f "$SCRIPT_DIR/rofi/space-neon-launcher" ] && install -m 755 "$SCRIPT_DIR/rofi/space-neon-launcher" "$BIN_DIR/space-neon-launcher"
[ -f "$SCRIPT_DIR/rofi/space-neon-launcher.desktop" ] && cp -f "$SCRIPT_DIR/rofi/space-neon-launcher.desktop" "$APPLICATIONS_DIR/"

# Antigravity & Start Menu icon installation
if [ -f "$SCRIPT_DIR/icons/antigravity.svg" ]; then
    cp -f "$SCRIPT_DIR/icons/antigravity.svg" "$SCALABLE_ICON_DIR/antigravity.svg"
    cp -f "$SCRIPT_DIR/icons/antigravity.svg" "$SCALABLE_ICON_DIR/antigravity-ide.svg"
    cp -f "$SCRIPT_DIR/icons/antigravity.svg" "$SCALABLE_ICON_DIR/com.antigravity.svg"
    cp -f "$SCRIPT_DIR/icons/antigravity.svg" "$ICON_DIR/antigravity.svg"
    cp -f "$SCRIPT_DIR/icons/antigravity.svg" "$ICON_DIR/antigravity-ide.svg"
    cp -f "$SCRIPT_DIR/icons/antigravity.svg" "$ICON_DIR/com.antigravity.svg"
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

# Update desktop shortcuts for Antigravity if they exist
for desktop_file in "$APPLICATIONS_DIR"/antigravity*.desktop /usr/share/applications/antigravity*.desktop; do
    if [ -f "$desktop_file" ] && [ -w "$desktop_file" ]; then
        sed -i 's|^Icon=.*|Icon=antigravity|' "$desktop_file" 2>/dev/null || true
    fi
done

# Update GTK & KDE icon caches
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
kbuildsycoca6 --noincremental 2>/dev/null || kbuildsycoca5 --noincremental 2>/dev/null || true

# Apply KDE Color Scheme, Accent Color & Fonts programmatically (supports Plasma 5 & Plasma 6)
echo -e "${GREEN}[+] Applying Space Neon Plasma Minimal Color Scheme, Orange Accent Color (255,107,0), and Fonts...${NC}"
if command -v kwriteconfig6 &> /dev/null; then
    kwriteconfig6 --file kdeglobals --group General --key ColorScheme "SpaceNeonPlasmaMinimal"
    kwriteconfig6 --file kdeglobals --group General --key AccentColor "255,107,0"
    kwriteconfig6 --file kdeglobals --group General --key accentColorFromWallpaper "false"
    kwriteconfig6 --file kdeglobals --group General --key font "$FONT_VALUE"
    kwriteconfig6 --file kdeglobals --group General --key fixed "$FONT_VALUE"
    kwriteconfig6 --file kdeglobals --group General --key menuFont "$FONT_VALUE"
    kwriteconfig6 --file kdeglobals --group General --key toolbarFont "$FONT_TOOLBAR"
    kwriteconfig6 --file kdeglobals --group General --key activeFont "$FONT_VALUE"
    kwriteconfig6 --file kdeglobals --group General --key smallestReadableFont "$FONT_SMALL"
    kwriteconfig6 --file kdeglobals --group WM --key activeFont "$FONT_VALUE"
    kwriteconfig6 --file ksplashrc --group KSplash --key Theme "SpaceNeonSplash"
    kwriteconfig6 --file ksplashrc --group KSplash --key Engine "KSplashQML"
elif command -v kwriteconfig5 &> /dev/null; then
    kwriteconfig5 --file kdeglobals --group General --key ColorScheme "SpaceNeonPlasmaMinimal"
    kwriteconfig5 --file kdeglobals --group General --key AccentColor "255,107,0"
    kwriteconfig5 --file kdeglobals --group General --key accentColorFromWallpaper "false"
    kwriteconfig5 --file kdeglobals --group General --key font "$FONT_VALUE"
    kwriteconfig5 --file kdeglobals --group General --key fixed "$FONT_VALUE"
    kwriteconfig5 --file kdeglobals --group General --key menuFont "$FONT_VALUE"
    kwriteconfig5 --file kdeglobals --group General --key toolbarFont "$FONT_TOOLBAR"
    kwriteconfig5 --file kdeglobals --group General --key activeFont "$FONT_VALUE"
    kwriteconfig5 --file kdeglobals --group General --key smallestReadableFont "$FONT_SMALL"
    kwriteconfig5 --file kdeglobals --group WM --key activeFont "$FONT_VALUE"
    kwriteconfig5 --file ksplashrc --group KSplash --key Theme "SpaceNeonSplash"
    kwriteconfig5 --file ksplashrc --group KSplash --key Engine "KSplashQML"
else
    echo "[!] kwriteconfig5/6 not found — color scheme file was copied but not auto-applied."
fi

# YAMIS icon theme selection
if [ -f "$ICON_DIR/YAMIS/index.theme" ]; then
    if command -v kwriteconfig6 &> /dev/null; then
        kwriteconfig6 --file kdeglobals --group Icons --key Theme "YAMIS"
    elif command -v kwriteconfig5 &> /dev/null; then
        kwriteconfig5 --file kdeglobals --group Icons --key Theme "YAMIS"
    fi
else
    echo "[!] YAMIS is not installed. Install it from System Settings → Icons → Get New…, then re-run this script."
fi

# Apply SpaceNeonPlasmaMinimal Plasma theme, Global theme & Aurorae window decoration
if command -v kwriteconfig6 &> /dev/null; then
    kwriteconfig6 --file plasmarc --group Theme --key name "SpaceNeonPlasmaMinimal"
    kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library "org.kde.kwin.aurorae"
    kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme "__aurorae__svg__SpaceNeonPlasmaMinimal"
elif command -v kwriteconfig5 &> /dev/null; then
    kwriteconfig5 --file plasmarc --group Theme --key name "SpaceNeonPlasmaMinimal"
    kwriteconfig5 --file kwinrc --group org.kde.kdecoration2 --key library "org.kde.kwin.aurorae"
    kwriteconfig5 --file kwinrc --group org.kde.kdecoration2 --key theme "__aurorae__svg__SpaceNeonPlasmaMinimal"
fi

if command -v lookandfeeltool &> /dev/null; then
    lookandfeeltool -a SpaceNeonPlasmaMinimal 2>/dev/null || true
fi

# Reload KWin to apply instantly
echo -e "${GREEN}[+] Reloading window manager...${NC}"
if command -v qdbus6 &> /dev/null; then
    qdbus6 org.kde.KWin /KWin org.kde.KWin.reconfigure 2>/dev/null || true
elif command -v qdbus &> /dev/null; then
    qdbus org.kde.KWin /KWin org.kde.KWin.reconfigure 2>/dev/null || true
fi

echo -e "${ORANGE}========================================${NC}"
echo -e "${GREEN} Success! SpaceNeonPlasmaMinimal installed and applied. ${NC}"
echo -e "${ORANGE}========================================${NC}"
echo "Note: some apps (GTK, Konsole profile selection) may need a restart to pick up the new theme.
To use the SDDM theme, go to System Settings > Startup and Shutdown > Login Screen (SDDM) and select 'Space Neutron SDDM'. If the theme does not appear, you may need to copy it to /usr/share/sddm/themes (requires root)."
