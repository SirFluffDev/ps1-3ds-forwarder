# Get Details
echo
echo "ROM    - $1"
echo "ICON   - $2"
echo "BANNER - $3"
echo "SOUND  - $4"
echo

read -p "Long name: " LONG_NAME

read -p "Short name (optional): " SHORT_NAME
SHORT_NAME=${SHORT_NAME:-$LONG_NAME}

read -p "Publisher: " PUBLISHER

read -p "Title ID (optional): " TITLE_ID
TITLE_ID=${TITLE_ID:-0xb$(openssl rand -hex 2)}

echo
echo "$LONG_NAME / $SHORT_NAME / $PUBLISHER / $TITLE_ID"
#echo "$1 / $2 / $3 / $4"
echo

# Copy rom
echo "Copying ROM"
cp "$1" "romfs/game.chd"

# Create icon
resources/bannertool-linux makesmdh \
    -s "$SHORT_NAME" -l "$LONG_NAME"  -p "$PUBLISHER" \
    -i "$2" \
    -o icon.icn \
    &> /dev/null # Hide output

# Create banner
resources/bannertool-linux makebanner \
    -i "$3" \
    -a "$4" \
    -o "banner.bnr" \
    &> /dev/null # Hide output

echo "Configuring settings"
cp "resources/retroarch.cfg" "romfs"
sed -i "s/ROMNAME/$SHORT_NAME/g" "romfs/retroarch.cfg"

echo "Building RomFS"
resources/3dstool -cvtf romfs romfs.bin --romfs-dir ./romfs

echo "Building CIA"
resources/makerom-linux \
    -f cia -o "$LONG_NAME".cia \
    -rsf resources/template.rsf \
    -exefslogo -elf resources/retroarch_3ds.elf \
    -romfs romfs.bin \
    -icon icon.icn \
    -banner banner.bnr \
    -DAPP_UNIQUE_ID=$TITLE_ID \
    -DAPP_SYSTEM_MODE=64MB \
    -DAPP_SYSTEM_MODE_EXT=124MB \
    -DAPP_ENCRYPTED=false

echo "Cleaning up"
rm icon.icn
rm banner.bnr
rm romfs/retroarch.cfg
rm romfs/game.chd
rm romfs.bin

echo
echo "Finished ($LONG_NAME.cia)"
