---
title: Tmux
date: 2023-11-17 14:14:12
tags:
    - tools
---
# Terminal Multiplexer

## custom config
```
# set the base index for windows to 1 instead of 0
set -g base-index 1

# set the base index for panes to 1 instead of 0
setw -g pane-base-index 1

# reload the file with prefix r
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# splitting panes with | and -
bind | split-window -h
bind - split-window -v


set -g mouse off

# set the status line's color
set -g status-style fg=white,bg=black

# set the color of the window list
setw -g window-status-style fg=cyan,bg=black

# set colors for the active window
setw -g window-status-current-style fg=white,bold,bg=green

# colors for pane borders
setw -g pane-border-style fg=green,bg=black
setw -g pane-active-border-style fg=while,bg=yellow

# active pane normal, other shaded out
setw -g window-style fg-colour240,bg=colour235
setw -g window-active-style fg=white,bg=black

# command/message line
set -g message-style fg=while,bold,bg=black

# status line right side 21-Otc 13:37
set -g status-right "#[fg=cyan]%d %b %R"

# status line left side to show session:window:pane
set -g status-left-length 40
set -g status-left "#[fg=green]Session:#S:#[fg=yellow]#I #[fg=cyan]#P  "

# update the status line every sixty seconds
set -g status-interval 60

# center the window list in the status line
set -g status-justify centre

# enbale vi keys
setw -g mode-keys vi

# log output to a text file on demand
bind P pipe-pane -o "cat >>~/#W.log" \; display "Toggled logging to ~/#W.log"
```







## Reference:
tmux 2: Productive Mouse-Free development
