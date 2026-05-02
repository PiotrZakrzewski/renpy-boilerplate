# Ren'Py Boilerplate

This is a template repo for quickly starting new Ren'Py visual novel projects.

## Key files

- `boilerplate/game/script.rpy` — main game script (story goes here)
- `boilerplate/game/options.rpy` — game config (name, version, build settings)
- `boilerplate/game/gui.rpy` — GUI configuration (colors, fonts, sizes)
- `boilerplate/game/screens.rpy` — UI screen definitions
- `new_project.sh` — scaffolding script to create a new project from this template
- `push_to_itch.sh` — upload builds to itch.io

## Ren'Py conventions

- `.rpy` files are Ren'Py script (Python-like DSL)
- `.rpyc` files are compiled bytecode (gitignored, auto-generated)
- `game/images/` — auto-detected image directory
- `game/audio/` — auto-detected audio directory
- Characters are defined with `define name = Character("Display Name")`
- Story flow uses `label` and `jump`/`call` statements
- Player choices use `menu:` blocks

## When helping with this repo

- Changes to the template go in `boilerplate/`
- The `new_project.sh` replaces `MY_GAME_NAME` placeholders in options.rpy
- Don't commit `.rpyc`, `cache/`, `saves/`, or `log.txt`
