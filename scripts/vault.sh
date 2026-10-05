#!/usr/bin/env bash
# Passphrase vault for visitor records.
#
#   scripts/vault.sh init   <alias>   create a new visitor folder from templates
#   scripts/vault.sh unlock <alias>   decrypt visitors/<alias>.vault into visitors/<alias>/
#   scripts/vault.sh lock   <alias>   encrypt visitors/<alias>/ into <alias>.vault, remove the plain folder
#   scripts/vault.sh status           list visitors and whether each is open or locked
#
# The passphrase is typed into this script's hidden prompt. Run it yourself in a
# terminal so it never appears in the chat. Encryption: AES-256-CBC, PBKDF2.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
V="$ROOT/visitors"
T="$ROOT/templates"
ITER=600000
MINLEN=6

cmd="${1:-}"
name="${2:-}"

die() { echo "Error: $*" >&2; exit 1; }

check_name() {
  [[ "$name" =~ ^[a-z0-9_-]{2,32}$ ]] || die "alias must be 2-32 chars: lowercase letters, digits, - or _"
}

ask_pass() {
  # sets PW; $1 = "confirm" to ask twice
  local p1 p2
  read -r -s -p "Passphrase: " p1; echo
  [[ ${#p1} -ge $MINLEN ]] || die "use at least $MINLEN characters (longer is safer: a short PIN can be guessed offline)"
  if [[ "${1:-}" == "confirm" ]]; then
    read -r -s -p "Repeat passphrase: " p2; echo
    [[ "$p1" == "$p2" ]] || die "passphrases do not match"
  fi
  PW="$p1"
  export PW
}

crypt() { # crypt enc|dec in out
  local mode="$1" in="$2" out="$3" flag="-e"
  [[ "$mode" == "dec" ]] && flag="-d"
  openssl enc "$flag" -aes-256-cbc -pbkdf2 -iter "$ITER" -salt -pass env:PW -in "$in" -out "$out" 2>/dev/null
}

case "$cmd" in
  init)
    check_name
    [[ ! -e "$V/$name" && ! -e "$V/$name.vault" ]] || die "visitor '$name' already exists"
    mkdir -p "$V/$name/sessions" "$V/$name/exercises"
    cp "$T/profile.md" "$V/$name/profile.md"
    cp "$T/themes.md"  "$V/$name/themes.md"
    echo "Created visitors/$name/. Run 'scripts/vault.sh lock $name' when done to protect it with a passphrase."
    ;;

  lock)
    check_name
    [[ -d "$V/$name" ]] || die "no open folder for '$name' (already locked?)"
    ask_pass confirm
    tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
    tar -C "$V" -czf "$tmp/p.tgz" "$name"
    crypt enc "$tmp/p.tgz" "$tmp/p.enc"
    # verify it decrypts before deleting anything
    crypt dec "$tmp/p.enc" "$tmp/check.tgz" && tar -tzf "$tmp/check.tgz" >/dev/null || die "verification failed; nothing was deleted"
    mv "$tmp/p.enc" "$V/$name.vault"
    rm -rf "$V/$name"
    echo "Locked. Records are now in visitors/$name.vault"
    echo "Note: deleting files on a normal disk is not a secure wipe. Use full-disk encryption (FileVault) for strong protection."
    ;;

  unlock)
    check_name
    [[ ! -d "$V/$name" ]] || die "'$name' is already open"
    [[ -f "$V/$name.vault" ]] || die "no vault for '$name'"
    ask_pass
    tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
    crypt dec "$V/$name.vault" "$tmp/p.tgz" && tar -tzf "$tmp/p.tgz" >/dev/null 2>&1 || die "wrong passphrase or damaged vault"
    tar -C "$V" -xzf "$tmp/p.tgz"
    echo "Unlocked: visitors/$name/ is open. Run 'scripts/vault.sh lock $name' after the session."
    ;;

  status)
    mkdir -p "$V"
    shopt -s nullglob
    found=0
    for d in "$V"/*/; do echo "open    $(basename "$d")"; found=1; done
    for f in "$V"/*.vault; do echo "locked  $(basename "$f" .vault)"; found=1; done
    [[ $found -eq 1 ]] || echo "no visitors yet"
    ;;

  *)
    sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'
    exit 1
    ;;
esac
