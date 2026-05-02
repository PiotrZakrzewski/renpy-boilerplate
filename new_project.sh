#!/bin/bash
# Create a new Ren'Py project from this boilerplate.
# Usage: ./new_project.sh "My Cool Game" [target_dir]
#
# This copies the boilerplate, renames config values, and generates
# a unique save directory so your saves don't collide with other projects.

set -e

if [ -z "$1" ]; then
  echo "Usage: ./new_project.sh \"My Game Name\" [target_directory]"
  echo ""
  echo "Examples:"
  echo "  ./new_project.sh \"My First VN\""
  echo "  ./new_project.sh \"My VN\" ../my-vn/game"
  exit 1
fi

GAME_NAME="$1"
# Generate a short name: lowercase, spaces to hyphens, strip non-alphanumeric
SHORT_NAME=$(echo "$GAME_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')
# Unique save directory
SAVE_DIR="${SHORT_NAME}-$(date +%s)"

TARGET="${2:-./${SHORT_NAME}}"

if [ -d "$TARGET" ]; then
  echo "Error: Target directory '$TARGET' already exists."
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Creating project: $GAME_NAME"
echo "  Short name: $SHORT_NAME"
echo "  Directory:  $TARGET"
echo ""

cp -r "$SCRIPT_DIR/boilerplate" "$TARGET"

# Replace placeholders in options.rpy
sed -i '' "s/MY_GAME_NAME/$GAME_NAME/g" "$TARGET/game/options.rpy" 2>/dev/null || \
sed -i "s/MY_GAME_NAME/$GAME_NAME/g" "$TARGET/game/options.rpy"

sed -i '' "s/MY_GAME_NAME-CHANGE_ME/$SAVE_DIR/g" "$TARGET/game/options.rpy" 2>/dev/null || \
sed -i "s/MY_GAME_NAME-CHANGE_ME/$SAVE_DIR/g" "$TARGET/game/options.rpy"

echo "Done! Your project is at: $TARGET"
echo ""
echo "Next steps:"
echo "  1. Open the Ren'Py launcher and add '$TARGET' as a project"
echo "     OR run: renpy '$TARGET'"
echo "  2. Edit $TARGET/game/script.rpy to write your story"
echo "  3. Drop images into $TARGET/game/images/"
echo "  4. Drop audio into $TARGET/game/audio/"
