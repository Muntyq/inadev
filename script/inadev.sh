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

case "$LANG" in
	rust)
		cat << 'EOF'
==================================
           ____            _
          |  _ \ _   _ ___| |_
          | |_) | | | / __| __|
          |  _ <| |_| \__ \ |_
  Inadev: |_| \_\\__,_|___/\__|

==================================
EOF
		cargo init
		;;
	c)
		cat << 'EOF'
====================
            ____
           / ___|
          | |
          | |___
  Inadev:  \____|

====================
EOF
		;;
	go)
		cat << 'EOF'
===========================
            ____
           / ___| ___
          | |  _ / _ \
          | |_| | (_) |
  Inadev:  \____|\___/

===========================
EOF
		;;
	lua)
		cat << 'EOF'
================================
           _
          | |   _   _  __ _
          | |  | | | |/ _` |
          | |__| |_| | (_| |
  Inadev: |_____\__,_|\__,_|

================================
EOF
		;;
esac

git add .
direnv allow

echo ""
echo -e "Set-up complete, project '$NAME' initialized! \e[1;94m>ヮ<\e[0m"
echo ""
echo -e "\e[3mRun 'git add flake.nix .envrc' if nix complains\e[0m"
echo -e "\e[3mAdd 'pkgs.openssl' to buildInputs if cargo complains\e[0m"
