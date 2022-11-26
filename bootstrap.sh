#!/usr/bin/env bash

set -euo pipefail

RACKET_VERSION="8.7"

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

# Vim
link "vimrc" "$HOME/.vimrc"

# Shell config 
link "zshrc" "$HOME/.zshrc"
