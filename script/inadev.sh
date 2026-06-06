#!/usr/bin/env bash

set -e

REPO="github:Muntyq/inadev"
LOCAL_PATH="$HOME/Projects/inadev"

AVAIBLE_LANGS="rust go c lua"

usage() {
	echo "Usage: inadev <project_name> <lang> [--local]"
	echo "       inadev --list"
	exit 1
}

list_langs() {
	echo "Avaible templates for:"
	for lang in $AVAIBLE_LANGS; do
		echo "   - $lang"
	done
	exit 0
}

if [[ "$1" == "--list" ]]; then
	list_langs
fi

if [[ $# -lt 2 ]]; then
	usage
fi

NAME="$1"
LANG="$2"
LOCAL=false

if [[ "$3" == "--local" ]]; then
	LOCAL=true
fi

if [[ "$LOCAL" == true ]]; then
	TEMPLATE="path:$LOCAL_PATH#$LANG"
else
	TEMPLATE="$REPO#$LANG"
fi

echo "Creating project '$NAME' with '$LANG' template..."

mkdir "$NAME"
cd "$NAME"

git init
nix flake init -t "$TEMPLATE"
git add .
direnv allow

echo "Set-up complete project '$NAME' started >ᴗ< "

