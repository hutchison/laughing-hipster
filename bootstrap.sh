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
}

# Off we go!
main
