#!/bin/bash

# Path to wallpaper index and directory
index_file="${HOME}/.config/waybar/.wallpaper-index"
wallpaper_dir="${HOME}/.config/backgrounds"

# Fallback if no index exists
if [ ! -f "$index_file" ]; then
    echo "1" > "$index_file"
fi

index=$(cat "$index_file")
formatted_index=$(printf "%03d" "$index")
wallpaper="${wallpaper_dir}/${formatted_index}.jpg"

# Kill existing swaybg instances (if any)
pkill swaybg

# Set the wallpaper
swaybg -i "$wallpaper" -m fill &

