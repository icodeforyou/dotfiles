set PATH /var/lib/snapd/snap/bin $PATH
set XDG_DATA_DIRS /var/lib/snapd/desktop/:$XDG_DATA_DIRS

set -g theme_display_git_default_branch yes
set -g theme_color_scheme nord

set -gx EDITOR nvim

zoxide init fish | source
