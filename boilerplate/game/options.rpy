## This file contains options that can be changed to customize your game.


## Basics ######################################################################

## A human-readable name of the game.
define config.name = _("MY_GAME_NAME")

## Determines if the title given above is shown on the main menu screen.
define gui.show_name = True

## The version of the game.
define config.version = "0.1"

## Text that is placed on the game's about screen.
define gui.about = _p("""
""")

## A short name for the game used for executables and directories in the built
## distribution. This must be ASCII-only, and must not contain spaces, colons,
## or semicolons.
define build.name = "MY_GAME_NAME"


## Sounds and music ############################################################

define config.has_sound = True
define config.has_music = True
define config.has_voice = False

# define config.sample_sound = "sample-sound.ogg"
# define config.sample_voice = "sample-voice.ogg"
# define config.main_menu_music = "main-menu-theme.ogg"


## Transitions #################################################################

define config.enter_transition = dissolve
define config.exit_transition = dissolve
define config.intra_transition = dissolve
define config.after_load_transition = None
define config.end_game_transition = None


## Window management ###########################################################

define config.window = "auto"
define config.window_show_transition = Dissolve(.2)
define config.window_hide_transition = Dissolve(.2)


## Preference defaults #########################################################

## Text speed. 0 = infinite, otherwise characters per second.
default preferences.text_cps = 0

## Auto-forward delay (0 to 30).
default preferences.afm_time = 15


## Save directory ##############################################################
##
## This MUST be unique per game, or saves will collide.
## Change MY_GAME_NAME to your game's short name.

define config.save_directory = "MY_GAME_NAME-CHANGE_ME"


## Icon ########################################################################

define config.window_icon = "gui/window_icon.png"


## Build configuration #########################################################

init python:

    build.classify('**~', None)
    build.classify('**.bak', None)
    build.classify('**/.**', None)
    build.classify('**/#**', None)
    build.classify('**/thumbs.db', None)

    ## To archive files, classify them as 'archive'.
    # build.classify('game/**.png', 'archive')
    # build.classify('game/**.jpg', 'archive')

    build.documentation('*.html')
    build.documentation('*.txt')


## Itch.io #####################################################################

# define build.itch_project = "username/my-game"
