#!/bin/bash

if [[ -z "$BW_SESSION" ]]; then
  echo "🔐 Unlocking Bitwarden..."
  export BW_SESSION=$(bw unlock --raw)
  bw sync
fi

chezmoi update
