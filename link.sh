#!/usr/bin/env bash
# Symlink the configs in etc/skel into $HOME, so editing a live file edits this repo.
# Anything already in the way is moved to ~/.dotfiles-backup-<date>/ (never deleted).
#
#   ./link.sh          link everything
#   ./link.sh -n       dry run: only print what would happen

set -euo pipefail

SKEL="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/etc/skel"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
DRY=0
[[ "${1:-}" == "-n" ]] && DRY=1

# Paths relative to $HOME. Folders that also hold other apps' files are linked one level deeper.
ITEMS=(
    .zshrc .zshrc.local .xbindkeysrc .Xresources
    .config/i3 .config/picom .config/rofi .config/conky .config/nano
    .config/viewnior .config/yazi
    .config/systemd/user/plasma-i3.service
    .local/share/rofi/themes
    .local/share/easyeffects/output
    .local/share/applications/yazi.desktop
    .local/share/applications/kitty-yt-x.desktop
    .icons/default .icons/Layan-border-cursors .icons/material_cursors
)

run() { if ((DRY)); then echo "  would: $*"; else "$@"; fi; }

for p in "${ITEMS[@]}"; do
    src="$SKEL/$p" dst="$HOME/$p"
    [[ -e "$src" ]] || { echo "skip (not in repo): $p"; continue; }
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        echo "ok:     $p"
        continue
    fi
    if [[ -e "$dst" || -L "$dst" ]]; then
        echo "backup: $p"
        run mkdir -p "$BACKUP/$(dirname "$p")"
        run mv "$dst" "$BACKUP/$p"
    fi
    echo "link:   $p"
    run mkdir -p "$(dirname "$dst")"
    run ln -s "$src" "$dst"
done

if [[ -L "$HOME/.config/systemd/user/plasma-i3.service" ]] && ((!DRY)); then
    systemctl --user daemon-reload || true
fi
echo "Done."
[[ -d "$BACKUP" ]] && echo "Backups: $BACKUP"
exit 0
