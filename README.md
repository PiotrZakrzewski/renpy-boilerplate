# renpy-boilerplate

Quick-start template for Ren'Py 8.x visual novels. Strips out the default placeholder cruft so you can start writing immediately.

## Usage

```bash
./new_project.sh "My Game Name"
```

This creates a ready-to-go project directory with config values already set.

Then either:
- Open the Ren'Py launcher and add the new directory as a project
- Or run directly: `renpy ./my-game-name`

## What's included

- Clean `script.rpy` skeleton (no Eileen placeholder)
- Sensible `options.rpy` with obvious `MY_GAME_NAME` placeholders
- Full default GUI assets (desktop + phone)
- `push_to_itch.sh` — upload builds to itch.io via butler
- `.gitignore` that properly handles Ren'Py artifacts

## What's NOT included

- Telemetry
- Identity translation files
- Compiled bytecode / cache

## Project structure

```
boilerplate/
  game/
    script.rpy    ← your story goes here
    options.rpy   ← game name, version, build config
    gui.rpy       ← colors, fonts, layout
    screens.rpy   ← UI screens (menus, save/load, prefs)
    gui/          ← GUI image assets
    images/       ← put character sprites & backgrounds here
    audio/        ← put music & sound effects here
```
