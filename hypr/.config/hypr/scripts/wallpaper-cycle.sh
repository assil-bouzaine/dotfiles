#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Array of available transitions
TRANSITIONS=(
    "fade"
    "wipe"
    "wave"
    "grow"
    "center"
    "any"
    "outer"
    "random"
)

# Start swww daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5  # wait for daemon to initialize
fi

# Get list of images (limit to 10 or however many you have)
mapfile -t IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | shuf | head -n 15)

if [ ${#IMAGES[@]} -eq 0 ]; then
    echo "No images found in $WALLPAPER_DIR"
    exit 1
fi

# Cycle through wallpapers indefinitely
while true; do
    for img in "${IMAGES[@]}"; do
        # Pick a random transition
        TRANSITION="${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}"

        # Random transition duration (1-3 seconds)
        DURATION=$((RANDOM % 3 + 1))

        # Random FPS between 30-60
        FPS=$((RANDOM % 31 + 30))

        swww img "$img" \
            --transition-type "$TRANSITION" \
            --transition-duration "$DURATION" \
            --transition-fps "$FPS" \
            --transition-angle "$((RANDOM % 360))"

        # Wait before switching (e.g., every 5 minutes = 300 seconds)
        sleep 60
    done

    # Reshuffle after cycling through all images
    mapfile -t IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | shuf | head -n 15)
done
