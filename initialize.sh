#!/bin/bash

if [ -n "$SUDO_USER" ]; then
    REAL_USER="$SUDO_USER"
    REAL_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
    REAL_USER="$USER"
    REAL_HOME="$HOME"
fi

TARGET_DIR="$REAL_HOME/Desktop/OrangeFoxBuild"
LOG_FILE="/tmp/orangefox_sync_${REAL_USER}.log"
MAX_ATTEMPTS=20
WAIT_TIME=30
BRANCH="12.1"
BUILD_PATH="$REAL_HOME/Desktop/OrangeFoxBuild/fox_12.1"
SYNC_DIR="$REAL_HOME/Desktop/OrangeFoxBuild/OrangeFox_sync/sync"

SUCCESS_MARKER="Now, clone your device trees to the correct locations!"

show_status() {
    local pid=$1
    local logfile=$2
    local msg="${3:-Syncing}"
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'

    tput civis 2>/dev/null

    while ps -p "$pid" > /dev/null 2>&1; do
        local progress
        progress=$(grep -oE "(Syncing|Fetching|Checking|Finalizing)[^%]*[0-9]+% \([0-9]+/[0-9]+\)" "$logfile" 2>/dev/null | tail -1)
        progress=$(echo "$progress" | tr -d '\r')

        if [ -n "$progress" ]; then
            printf "\r  ${spinstr:0:1}  %s" "$progress"
        else
            printf "\r  ${spinstr:0:1}  %s..." "$msg"
        fi

        spinstr=${spinstr#?}${spinstr:0:1}
        sleep 0.2
    done

    tput cnorm 2>/dev/null
    printf "\r\033[K"
}

echo "Installation process has been started."
sleep 2

if [ -d "$TARGET_DIR" ]; then
    echo "Cleaning existing directory: $TARGET_DIR"
    rm -rf "$TARGET_DIR"
    echo "Cleanup done."
    sleep 1
fi

mkdir -p "$REAL_HOME/Desktop/OrangeFoxBuild/scripts"
cd "$REAL_HOME/Desktop/OrangeFoxBuild"

echo "Installing dependencies..."
sudo apt install git aria2 -y > /dev/null 2>&1

if [ ! -d "$REAL_HOME/Desktop/OrangeFoxBuild/scripts/setup" ]; then
    git clone https://gitlab.com/OrangeFox/misc/scripts > /dev/null 2>&1
fi

cd "$REAL_HOME/Desktop/OrangeFoxBuild/scripts"
sudo bash setup/android_build_env.sh > /dev/null 2>&1
sudo bash setup/install_android_sdk.sh > /dev/null 2>&1
echo "Dependencies installed."

mkdir -p "$REAL_HOME/Desktop/OrangeFoxBuild/OrangeFox_sync"
mkdir -p "$BUILD_PATH"
cd "$REAL_HOME/Desktop/OrangeFoxBuild/OrangeFox_sync"

if [ ! -d "sync/.git" ]; then
    git clone https://gitlab.com/OrangeFox/sync.git > /dev/null 2>&1
fi

cd "$SYNC_DIR"

GIT_NAME=$(sudo -u "$REAL_USER" git config --global user.name 2>/dev/null)
GIT_EMAIL=$(sudo -u "$REAL_USER" git config --global user.email 2>/dev/null)

if [ -z "$GIT_NAME" ]; then
    GIT_NAME="$REAL_USER"
fi

if [ -z "$GIT_EMAIL" ]; then
    GIT_EMAIL="${REAL_USER}@localhost"
fi

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

ATTEMPT=1

while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    echo ""
    echo "==> Attempt $ATTEMPT/$MAX_ATTEMPTS"

    AVAILABLE=$(df "$BUILD_PATH" --output=avail -BG 2>/dev/null | tail -1 | tr -d 'G ')
    if [ -n "$AVAILABLE" ] && [ "$AVAILABLE" -lt 5 ]; then
        echo "ERROR: Low disk space ($AVAILABLE GB left). Free up space and retry."
        exit 1
    fi

    > "$LOG_FILE"

    script -q -c "./orangefox_sync.sh --branch $BRANCH --path $BUILD_PATH" "$LOG_FILE" > /dev/null 2>&1 &
    SYNC_PID=$!

    show_status "$SYNC_PID" "$LOG_FILE" "Syncing source code"

    wait "$SYNC_PID"
    exit_code=$?

    if grep -q "$SUCCESS_MARKER" "$LOG_FILE"; then
        echo "  Sync and patch completed successfully."

        echo ""
        echo "==> Cloning device repo and copying into $BUILD_PATH ..."

        TMP_REPO="/tmp/orangefox_shamrock_tmp"
        rm -rf "$TMP_REPO"

        git clone https://github.com/adilaytanofficial/orangefox_shamrock.git "$TMP_REPO" 2>/dev/null

        if [ $? -ne 0 ]; then
            echo "ERROR: Failed to clone device repo. Aborting."
            rm -rf "$TMP_REPO"
            exit 1
        fi

        rsync -a --exclude='.git' --exclude='screenshots' "$TMP_REPO"/ "$BUILD_PATH"/

        rm -rf "$TMP_REPO"

        # Fix ownership so files belong to the real user, not root
        chown -R "$REAL_USER":"$REAL_USER" "$TARGET_DIR"

        echo ""
        echo "==> All preparation completed."
        echo "   To build: cd $BUILD_PATH && ./build_shamrock.sh"
        exit 0
    fi

    if grep -qE "429|RESOURCE_EXHAUSTED|rate limit|Unable to fully sync|SyncError|Failing repos|Connection reset|Connection timed out|Could not resolve host" "$LOG_FILE"; then
        ATTEMPT=$((ATTEMPT + 1))
        if [ $ATTEMPT -le $MAX_ATTEMPTS ]; then
            printf "  Waiting %ss before retry... (attempt %d/%d)\n" \
                   "$WAIT_TIME" "$ATTEMPT" "$MAX_ATTEMPTS"
            sleep $WAIT_TIME
        fi
        continue
    fi

    if grep -qE "Could not read|did not send all necessary objects|Failed to traverse parents|index-pack failed|unpack-objects failed" "$LOG_FILE"; then
        echo "  Corrupted object detected, repairing..."
        cd "$BUILD_PATH"
        repo forall -c 'git fsck --full 2>/dev/null' 2>/dev/null
        cd "$SYNC_DIR"

        ATTEMPT=$((ATTEMPT + 1))
        if [ $ATTEMPT -le $MAX_ATTEMPTS ]; then
            printf "  Retrying after repair... (attempt %d/%d)\n" \
                   "$ATTEMPT" "$MAX_ATTEMPTS"
            sleep 10
        fi
        continue
    fi

    ATTEMPT=$((ATTEMPT + 1))
    if [ $ATTEMPT -le $MAX_ATTEMPTS ]; then
        echo "  Sync was interrupted (exit code: $exit_code)."
        printf "  Waiting %ss before retry... (attempt %d/%d)\n" \
               "$WAIT_TIME" "$ATTEMPT" "$MAX_ATTEMPTS"
        sleep $WAIT_TIME
    fi
done

echo ""
echo "FAILED: Maximum retry attempts reached ($MAX_ATTEMPTS)."
echo "   Log file: $LOG_FILE"
tail -30 "$LOG_FILE"
exit 1