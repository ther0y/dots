#!/usr/bin/env bash
#
# Wallpaper picker using rofi
#
# Usage: wallpaper.sh [custom_dir1] [custom_dir2] ...
# Or set WALLPAPER_DIRS in your environment
# Debug: logs to ~/.cache/rofi-wallpaper-debug.log
# Set WALLPAPER_DEBUG=0 to disable

: "${WALLPAPER_DEBUG:=1}"
DEBUG_LOG="$HOME/.cache/rofi-wallpaper-debug.log"
mkdir -p "$(dirname "$DEBUG_LOG")"
dbg() { [[ "$WALLPAPER_DEBUG" != 0 ]] && echo "[$(date '+%H:%M:%S')] $*" >> "$DEBUG_LOG"; }

dir="$HOME/.config/rofi/wallpaper"
theme="${dir}/style.rasi"

# Default wallpaper directories (override with WALLPAPER_DIRS env or script args)
if [[ -n "$WALLPAPER_DIRS" ]]; then
	# Space-separated list from env
	read -ra WALLPAPER_DIRS <<< "$WALLPAPER_DIRS"
else
	WALLPAPER_DIRS=(
		"$HOME/Pictures/Wallpapers"
		"$HOME/Pictures/wallpapers"
		"$HOME/Pictures"
		"$HOME/.local/share/wallpapers"
		"$HOME/Downloads"
		"/usr/share/backgrounds"
	)
fi

# Add custom dirs from args
for custom_dir in "$@"; do
	WALLPAPER_DIRS+=("$custom_dir")
done

# Image extensions to scan
extensions=(-name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp")

# Collect wallpapers from all directories
wallpapers=()
for wp_dir in "${WALLPAPER_DIRS[@]}"; do
	if [[ -d "$wp_dir" ]]; then
		while IFS= read -r -d '' path; do
			wallpapers+=("$path")
		done < <(find "$wp_dir" -type f \( "${extensions[@]}" \) -print0 2>/dev/null)
	fi
done

dbg "=== wallpaper picker start ==="
dbg "Found ${#wallpapers[@]} wallpapers"

if [[ ${#wallpapers[@]} -eq 0 ]]; then
	notify-send "Wallpaper Picker" "No wallpapers found in configured directories"
	exit 1
fi

# Preview for left panel: current wallpaper from swww, or first in list
preview_path="${wallpapers[0]}"
if command -v swww &>/dev/null; then
	current=$(swww query 2>/dev/null | sed -n 's/.*image: //p' | head -1)
	[[ -f "$current" ]] && preview_path="$current"
fi

# Build rofi input: path as display (so rofi returns it on select) + \0icon\x1fpath for thumbnail
# Theme shows only element-icon, so path text is hidden but selection still returns the path
build_rofi_input() {
	printf '%s\n' "${wallpapers[@]}" | sort -f | while IFS= read -r p; do
		printf '%s\0icon\x1f%s\n' "$p" "$p"
	done
}

# Escape path for -theme-str (replace " with \")
preview_escaped="${preview_path//\"/\\\"}"
theme_str="imagebox { background-image: url(\"$preview_escaped\", both); }"

chosen=$(build_rofi_input | rofi -dmenu \
	-p "" \
	-mesg "Select a wallpaper" \
	-theme "$theme" \
	-theme-str "$theme_str" \
	-i)

dbg "Rofi raw output: '${chosen:0:100}...' (len=${#chosen})"

# Rofi with icons returns: path\0icon\x1fpath or \0icon\x1fpath
# Extract path: part before \0, or if empty (null-first) part after \x1f
raw="$chosen"
chosen="${chosen%%$'\0'*}"
[[ -z "$chosen" ]] && chosen="${raw#*$'\x1f'}"

dbg "Path after strip: '$chosen'"
[[ -z "$chosen" ]] && { dbg "Empty selection, exit"; exit 0; }

[[ ! -f "$chosen" ]] && { dbg "File not found: $chosen"; exit 1; }

# Apply wallpaper (same logic as fish setwall)
# Capture stderr to log when debugging
run_cmd() {
	local ret
	if [[ "$WALLPAPER_DEBUG" != 0 ]]; then
		"$@" 2>>"$DEBUG_LOG"
		ret=$?
		dbg "$1 exit: $ret"
		return $ret
	else
		"$@"
	fi
}

dbg "Running: swww img $chosen"
run_cmd swww img "$chosen" --transition-type outer

dbg "Running: wallust run -s $chosen"
run_cmd wallust run -s "$chosen"

dbg "Reloading waybar..."
killall -SIGUSR2 waybar 2>/dev/null
dbg "Reloading ghostty..."
killall -SIGUSR2 ghostty 2>/dev/null

if pgrep tmux >/dev/null 2>&1; then
	dbg "Reloading tmux..."
	tmux source-file ~/.config/tmux/tmux.conf 2>/dev/null
	tmux set-option -g status-style "bg=default,fg=default" 2>/dev/null
	tmux refresh-client -S 2>/dev/null
fi

dbg "=== done ==="
