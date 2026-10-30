#!/bin/zsh
# Publish the latest JMP draft to the website and the application folder.
# Usage: ./publish_jmp.sh            (uses the default draft below)
#        ./publish_jmp.sh path/to/draft.pdf
set -e
SRC="${1:-$HOME/Dropbox/LSE/Research/2024.02_CapeTown/Local/Drafts/Draft_October_v4.pdf}"
REPO="$(cd "$(dirname "$0")" && pwd)"
APP="$HOME/Dropbox/LSE/Job Market/Emiliano Application Folder/RinaldiJMP.pdf"

[ -f "$SRC" ] || { echo "Draft not found: $SRC"; exit 1; }
cp "$SRC" "$REPO/files/Rinaldi_JMP.pdf"
cp "$SRC" "$APP"
cd "$REPO"
if git diff --quiet -- files/Rinaldi_JMP.pdf; then
  echo "Website copy already up to date."
else
  git add files/Rinaldi_JMP.pdf
  git commit -m "Update JMP draft ($(date +%Y-%m-%d))"
  git push
  echo "Published: https://www.emilianorinaldi.com/files/Rinaldi_JMP.pdf"
fi
