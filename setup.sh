#!/usr/bin/env bash

# Install script for polybar themes

# Dirs
DIR=`pwd`
FDIR="$HOME/.local/share/fonts"
PDIR="$HOME/.config/polybar"

# Install Fonts
install_fonts() {
	echo -e "\n[*] Installing fonts..."
	[[ ! -d "$FDIR" ]] && mkdir -p "$FDIR"
	cp -rf $DIR/fonts/* "$FDIR"
}

# Install Themes
install_themes() {
	if [[ -d "$PDIR" ]]; then
		echo -e "[*] Creating a backup of your polybar configs..."
		mv "$PDIR" "${PDIR}.old"
		{ mkdir -p "$PDIR"; cp -rf $DIR/$STYLE/* "$PDIR"; }
	else
		{ mkdir -p "$PDIR"; cp -rf $DIR/$STYLE/* "$PDIR"; }	
	fi
	if [[ -f "$PDIR/launch.sh" ]]; then
		echo -e "[*] Successfully Installed.\n"
		exit 0
	else
		echo -e "[!] Failed to install.\n"
		exit 1
	fi
}

# Main
main() {
	if [[ -z "$1" ]]; then
		echo -e "[!] Please provide a style option (1 for Simple, 2 for Bitmap)"
		exit 1
	fi

	echo -e "[*] Installing Polybar Themes..."

	if [[ $1 == "1" ]]; then
		STYLE='simple'
		install_fonts
		install_themes
	elif [[ $1 == "2" ]]; then
		STYLE='bitmap'
		install_fonts
		install_themes
	else
		echo -e "\n[!] Invalid Option, Exiting...\n"
		exit 1
	fi
}

main "$1"
