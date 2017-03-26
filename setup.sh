#!/bin/bash

if [[ $SHELL != "/bin/zsh" ]]; then
    chsh -u $1 -s /bin/zsh
fi
