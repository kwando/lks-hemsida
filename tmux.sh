#!/bin/bash
SESH="lks_www"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESH -n "build" -d
    tmux send-keys -t $SESH:build "just dev" C-m

    tmux new-window -t $SESH -n "serve"
    tmux send-keys -t $SESH:serve "just serve" C-m

    tmux select-window -t $SESH:build
fi

tmux attach -t $SESH
