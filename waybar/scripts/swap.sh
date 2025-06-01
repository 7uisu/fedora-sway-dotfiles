#!/bin/bash

# Waybar config/style paths
config_file="${HOME}/.config/waybar/config"
config_background_file="${HOME}/.config/waybar/config-background"
style_file="${HOME}/.config/waybar/style.css"
style_background_file="${HOME}/.config/waybar/style-background.css"

# Wallpaper folder and index tracking
wallpaper_dir="${HOME}/.config/backgrounds"
index_file="${HOME}/.config/waybar/.wallpaper-index"
max_index=31

# Initialize index if not present
if [ ! -f "$index_file" ]; then
    echo "1" > "$index_file"
fi

# Read current index and calculate next
current_index=$(cat "$index_file")
next_index=$(( (current_index % max_index) + 1 ))

# Format with leading zeros (e.g., 001.jpg)
formatted_next=$(printf "%03d" "$next_index")
wallpaper_path="${wallpaper_dir}/${formatted_next}.jpg"

# Swap Waybar config files
mv "$config_file" "$config_file.temp"
mv "$config_background_file" "$config_file"
mv "$config_file.temp" "$config_background_file"

# Swap Waybar style files
mv "$style_file" "$style_file.temp"
mv "$style_background_file" "$style_file"
mv "$style_file.temp" "$style_background_file"

echo "Waybar config and style swapped."

# Kill any running swaybg instance (to prevent overlap)
pkill swaybg

# Set new background
swaybg -i "$wallpaper_path" -m fill &

# Save new index
echo "$next_index" > "$index_file"
echo "Wallpaper set to ${formatted_next}.jpg"

# Reload sway and Waybar
pkill -x waybar
swaymsg reload

