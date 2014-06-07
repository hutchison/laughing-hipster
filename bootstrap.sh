#!/bin/bash

# Exit immediately if a command exits with a non-zero status:
set -e

# Are we on a Mac?
on_a_mac() {
    local os=$(uname -s)

    [[ $os == "Darwin" ]]
}

# Is Homebrew installed?
is_brew_installed() {
    [[ -x '/usr/local/bin/brew' ]]
}

# Installs Homebrew:
install_homebrew() {
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
}

# Is SaltStack installed?
is_salt_installed() {
    [[ -x '/usr/local/bin/salt' ]]
}

# Is Munki installed?
is_munki_installed() {
    local MUNKIDIR="/usr/local/munki"
    [[ -d "$MUNKIDIR" ]] \
        && [[ -x "$MUNKIDIR/managedsoftwareupdate" ]]
}

# Installs Munki:
install_munki() {
    echo "Installing Munki..."

    local DMG_NAME="munkitools-latest.dmg"
    local DMG_URL="https://munkibuilds.org/$DMG_NAME"
    local LOCAL_DMG_PATH="$(pwd)/$DMG_NAME"

    local TMPMOUNT=$(/usr/bin/mktemp -d /tmp/munkibuilds.XXXX)
    local HDIUTIL="/usr/bin/hdiutil"
    local CURL="/usr/bin/curl"

    echo "Grabbing the latest version..."
    $CURL -s --connect-timeout 30 -o "$LOCAL_DMG_PATH" "$DMG_URL"

    echo "Mounting at $TMPMOUNT ..."
    $HDIUTIL attach "$LOCAL_DMG_PATH" -mountpoint "$TMPMOUNT"
    local MUNKI_MPKG_PATH="$TMPMOUNT/$(/bin/ls $TMPMOUNT | grep munkitools)"

    echo "Installing Munki from $MUNKI_MPKG_PATH ..."
    sudo /usr/sbin/installer -pkg "$MUNKI_MPKG_PATH" -target /

    echo "Unmounting installer dmg..."
    $HDIUTIL detach "$TMPMOUNT"

    echo "Cleaning up..."
    /bin/rm -f "$DMG_NAME"
    /bin/rm -rf "$TMPMOUNT"

    echo "Done."
}

main() {
    if ! on_a_mac; then
        echo "We are not on a Mac. Exiting."
        exit
    fi

    if ! is_brew_installed; then
        install_homebrew
    fi

    if ! is_salt_installed; then
        brew install saltstack
    fi

    if ! is_munki_installed; then
        install_munki
    fi
}

# Off we go!
main
