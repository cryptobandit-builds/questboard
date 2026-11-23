#!/usr/bin/env bash
# Helper: run a Quest Board transaction with gnokey.
#   REMOTE, CHAINID, PKG, KEYHOME, PASSFILE can be overridden by env.
#   usage: scripts/tx.sh <key> <func> [-send 1000000ugnot] [-args a -args b ...]
set -euo pipefail
REMOTE=${REMOTE:-http://127.0.0.1:26657}
CHAINID=${CHAINID:-dev}
PKG=${PKG:-gno.land/r/g1rwxskhs8tm98yxcj5tuehwplwnqzacuqsqgrtq/questboard}
KEY=$1; FUNC=$2; shift 2
PASSARGS=()
if [[ -n "${PASSFILE:-}" ]]; then PASSARGS=(-insecure-password-stdin); fi
cmd=(gnokey maketx call -pkgpath "$PKG" -func "$FUNC" "$@" \
  -gas-fee 1000000ugnot -gas-wanted 20000000 -max-deposit 10000000ugnot \
  -broadcast -chainid "$CHAINID" -remote "$REMOTE" ${KEYHOME:+-home "$KEYHOME"} "${PASSARGS[@]}" "$KEY")
if [[ -n "${PASSFILE:-}" ]]; then "${cmd[@]}" < "$PASSFILE"; else "${cmd[@]}"; fi
