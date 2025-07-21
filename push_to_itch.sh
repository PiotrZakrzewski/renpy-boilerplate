#!/bin/bash

set -e  # Exit on error

USERNAME="gieku"
PROJECT="the-royal-gambit"

# Find the latest build directory
BUILD_DIR=$(ls -d RoyalGambit-*-dists 2>/dev/null | sort | tail -n 1)

if [ -z "$BUILD_DIR" ]; then
  echo "❌ No build directory found matching 'RoyalGambit-*-dists'"
  exit 1
fi

echo "📁 Using build directory: $BUILD_DIR"

# Extract version from the directory name (e.g., "Chapter1version01alpha")
VERSION=$(echo "$BUILD_DIR" | sed -E 's/^RoyalGambit-(.+)-dists/\1/')

echo "🔖 Extracted version: $VERSION"

# Find platform-specific builds
PC_BUILD=$(ls "$BUILD_DIR"/*-pc.zip 2>/dev/null | sort | tail -n 1)
MAC_BUILD=$(ls "$BUILD_DIR"/*-mac.zip 2>/dev/null | sort | tail -n 1)
LINUX_BUILD=$(ls "$BUILD_DIR"/*-linux.* 2>/dev/null | sort | tail -n 1)

# Upload builds if they exist
[ -f "$PC_BUILD" ] && echo "🚀 Uploading PC build: $PC_BUILD" && butler push "$PC_BUILD" "$USERNAME/$PROJECT:pc" --userversion "$VERSION"
[ -f "$MAC_BUILD" ] && echo "🚀 Uploading macOS build: $MAC_BUILD" && butler push "$MAC_BUILD" "$USERNAME/$PROJECT:mac" --userversion "$VERSION"
[ -f "$LINUX_BUILD" ] && echo "🚀 Uploading Linux build: $LINUX_BUILD" && butler push "$LINUX_BUILD" "$USERNAME/$PROJECT:linux" --userversion "$VERSION"

# Prompt to remove build directory
echo
read -p "🗑️  All uploads completed. Do you want to delete the build directory '$BUILD_DIR'? [y/N]: " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  rm -rf "$BUILD_DIR"
  echo "✅ Deleted build directory: $BUILD_DIR"
else
  echo "ℹ️  Build directory preserved."
fi
