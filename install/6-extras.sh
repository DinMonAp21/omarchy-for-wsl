#!/bin/bash

# Use delta as git's pager and diff renderer
if command -v delta &>/dev/null; then
  git config --global core.pager delta
  git config --global interactive.diffFilter "delta --color-only"
  git config --global delta.navigate true
  git config --global delta.side-by-side true
  git config --global delta.line-numbers true
  git config --global delta.syntax-theme "Monokai Extended"
  git config --global merge.conflictStyle zdiff3
fi

# Television: link our channels into ~/.config/television/cable/
mkdir -p ~/.config/television/cable
for f in ~/.local/share/omarchy/default/television/cable/*.toml; do
  ln -sfn "$f" ~/.config/television/cable/"$(basename "$f")"
done

# Set `tv` (no args) to show the channel picker
if [[ -f ~/.config/television/config.toml ]]; then
  sed -i 's/^default_channel = .*/default_channel = "channels"/' ~/.config/television/config.toml
fi

# Seed ~/.config/run/ with the bundled scripts on first install (no overwrite)
mkdir -p ~/.config/run
for f in ~/.local/share/omarchy/default/run/*; do
  name=$(basename "$f")
  if [[ ! -e ~/.config/run/"$name" ]]; then
    cp "$f" ~/.config/run/"$name"
    chmod +x ~/.config/run/"$name"
  fi
done

# tmux-resurrect: clone for manual save/restore (prefix Ctrl-s / Ctrl-r)
if [[ ! -d ~/.tmux/plugins/tmux-resurrect ]]; then
  git clone --depth 1 https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/tmux-resurrect
fi

# fzf-tab: fzf-powered tab completion for zsh
if [[ ! -d ~/.local/share/zsh-plugins/fzf-tab ]]; then
  mkdir -p ~/.local/share/zsh-plugins
  git clone --depth 1 https://github.com/Aloxaf/fzf-tab ~/.local/share/zsh-plugins/fzf-tab
fi
