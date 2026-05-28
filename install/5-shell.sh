#!/bin/bash

# Entry-point for the new shell (mirrors 4-config.sh's bashrc pattern)
echo "source ~/.local/share/omarchy/default/zsh/rc" >~/.zshrc

# Tool configs via symlink so future edits to the repo flow through
ln -sfn ~/.local/share/omarchy/default/tmux/tmux.conf ~/.tmux.conf

mkdir -p ~/.config/yazi
for f in ~/.local/share/omarchy/default/yazi/*.toml; do
  ln -sfn "$f" ~/.config/yazi/"$(basename "$f")"
done

mkdir -p ~/.config
ln -sfn ~/.local/share/omarchy/default/starship/starship.toml ~/.config/starship.toml

# Make zsh the login shell for the current user
if [[ "$(getent passwd "$USER" | cut -d: -f7)" != "/bin/zsh" ]]; then
  sudo chsh -s /bin/zsh "$USER"
fi
