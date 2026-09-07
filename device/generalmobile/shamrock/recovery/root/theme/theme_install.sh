#!/sbin/sh

SRC="/FFiles/OF_default_theme/theme"
DATA_FOX="/data/media/0/Fox"
SDCARD_FOX="/sdcard/Fox"

if [ -d "$SRC" ]; then
    if [ -d "/data/media/0" ]; then
        mkdir -p "$DATA_FOX/.theme"
        cp -rf "$SRC"/* "$DATA_FOX/.theme/"
        
        if [ -f "$SRC/foxs" ]; then
            cp -f "$SRC/foxs" "$DATA_FOX/.foxs"
            echo "foxs copied to .foxs"
        fi
        
        chmod -R 0777 "$DATA_FOX"
    fi

    if [ -d "/sdcard" ]; then
        mkdir -p "$SDCARD_FOX/.theme"
        cp -rf "$SRC"/* "$SDCARD_FOX/.theme/"
        
        if [ -f "$SRC/foxs" ]; then
            cp -f "$SRC/foxs" "$SDCARD_FOX/.foxs"
        fi
        
        chmod -R 0777 "$SDCARD_FOX"
    fi
fi

exit 0