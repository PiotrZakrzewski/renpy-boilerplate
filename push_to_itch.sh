#!/bin/bash
# Push builds to itch.io using butler.
# Usage: ./push_to_itch.sh
#
# Prerequisites: Install butler (https://itch.io/docs/butler/)
# Configure these two variables for your project:

set -e

USERNAME="YOUR_ITCH_USERNAME"
PROJECT="your-game-name"

# Find the latest build directory (adjust the glob to match your build output)
BUILD_DIR=$(ls -d *-dists 2>/dev/null | sort | tail -n 1)

if [ -z "$BUILD_DIR" ]; then
  echo "No build directory found matching '*-dists'"
  echo "Build your game in Ren'Py first, then run this script from the directory containing the build output."
  exit 1
fi

echo "Using build directory: $BUILD_DIR"

VERSION=$(echo "$BUILD_DIR" | sed -E 's/^[^-]+-(.+)-dists/\1/')
echo "Version: $VERSION"

PC_BUILD=$(ls "$BUILD_DIR"/*-pc.zip 2>/dev/null | sort | tail -n 1)
MAC_BUILD=$(ls "$BUILD_DIR"/*-mac.zip 2>/dev/null | sort | tail -n 1)
LINUX_BUILD=$(ls "$BUILD_DIR"/*-linux.* 2>/dev/null | sort | tail -n 1)

[ -f "$PC_BUILD" ] && echo "Uploading PC: $PC_BUILD" && butler push "$PC_BUILD" "$USERNAME/$PROJECT:pc" --userversion "$VERSION"
[ -f "$MAC_BUILD" ] && echo "Uploading macOS: $MAC_BUILD" && butler push "$MAC_BUILD" "$USERNAME/$PROJECT:mac" --userversion "$VERSION"
[ -f "$LINUX_BUILD" ] && echo "Uploading Linux: $LINUX_BUILD" && butler push "$LINUX_BUILD" "$USERNAME/$PROJECT:linux" --userversion "$VERSION"

echo "Done."
