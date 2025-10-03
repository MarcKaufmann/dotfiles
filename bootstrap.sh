#!/usr/bin/env bash

set -euo pipefail

RACKET_VERSION="8.18"

log () {
    printf "[%s] %s\n" "$(date)" "$@"
}

link () {
    if [ "$#" -ne 2 ]; then
        echo "usage: link SRC DST"
        exit 1
    fi

    SRC="$ROOT/$1"
    DST="$2"
    log "Linking '$SRC' to '$DST'..."
    ln -sf "$SRC" "$DST"
}

ROOT=$(cd "$(dirname "$0")" && pwd)
log "ROOT is $ROOT"

log "Creating workspace..."
mkdir -p "$ROOT/workspace"

log "Logging installed packages..."
port installed > "$ROOT/workspace/installed"

log "Clearing failures..."
if [ -f "$ROOT/workspace/failures" ]; then
   echo "" > "$ROOT/workspace/failures"
fi

log "Installing packages..."
while IFS= read -r PKG; do
    if ! grep -q "$PKG" "$ROOT/workspace/installed"; then
	log "Installing $PKG..."
	if ! sudo port install "$PKG" 2>"$ROOT/workspace/errors.$PKG"; then
	     echo "$PKG" >> "$ROOT/workspace/failures"
        fi
    fi
done < "$ROOT/packages"


# Racket

RACKET_APP="/Applications/Racket v${RACKET_VERSION}" 
if [ -d "$RACKET_APP" ]; then
    RACKET_BIN="$RACKET_APP/bin"
    ln -sf "$RACKET_BIN/racket" "$HOME/bin/racket"
    ln -sf "$RACKET_BIN/raco" "$HOME/bin/raco"
    ln -sf "$RACKET_BIN/drracket" "$HOME/bin/drracket"
else
    log "Could not find an installation for Racket version ${RACKET_VERSION} in ${RACKET_APP}."
fi

# Doom Emacs
if [ ! -d "$HOME/.emacs.d" ]; then
    log "Installing and configuring Doom Emacs..."
    git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d
    if [ ! -d "$HOME/.doom.d" ]; then
        mkdir "$HOME/.doom.d"
    fi
    link "doom.d/config.el" "$HOME/.doom.d/config.el"
    link "doom.d/init.el" "$HOME/.doom.d/init.el"
    link "doom.d/packages.el" "$HOME/.doom.d/packages.el"
    PATH="/Applications/MacPorts/Emacs.App/Contents/MacOS:$HOME/.emacs.d/bin:$HOME/bin:$PATH"
    doom sync
    log "Installing the icon fonts needed for Doom Emacs..."
    emacs --batch -f all-the-icons-install-fonts
fi

# PostgreSQL

if [ ! -d "/opt/local/var/db/postgresql16/defaultdb" ]; then
    log "Setting up PostgreSQL database..."
    sudo mkdir -p /opt/local/var/db/postgresql16/defaultdb
    sudo chown postgres:postgres /opt/local/var/db/postgresql16/defaultdb
    sudo su postgres -c 'cd /opt/local/var/db/postgresql16 && /opt/local/lib/postgresql16/bin/initdb -D /opt/local/var/db/postgresql16/defaultdb'

    log "Loading PostgreSQL agent..."
    if [ "$DRY_RUN" -eq 0 ]; then
        sudo port load postgresql16-server
    fi

    log "Loading PostgreSQL version..."
    sudo port load postgresql16-server
fi

log "Selecting PostgreSQL version..."
sudo port select postgresql postgresql16

# tmux
link "tmux.conf" "$HOME/.tmux.conf"

# Vim
link "vimrc" "$HOME/.vimrc"

# Shell config 
link "zshrc" "$HOME/.zshrc"
link "zshenv" "$HOME/.zshenv"
