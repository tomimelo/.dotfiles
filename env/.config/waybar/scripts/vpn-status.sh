#!/usr/bin/env bash

set -euo pipefail

vpn_lines="$(
  nmcli -t -f NAME,TYPE,DEVICE connection show --active 2>/dev/null \
    | awk -F: '$2 == "vpn" { print $1 ":" $3 }'
)"

if [[ -z "${vpn_lines}" ]]; then
  printf '{"text":"󰌾 0","tooltip":"No VPN connected","class":["vpn","disconnected"]}\n'
  exit 0
fi

mapfile -t vpns <<< "${vpn_lines}"
count="${#vpns[@]}"

tooltip="Connected VPNs:"
for vpn in "${vpns[@]}"; do
  name="${vpn%%:*}"
  dev="${vpn#*:}"
  if [[ -n "$dev" && "$dev" != "$name" ]]; then
    tooltip="${tooltip}\n- ${name} (${dev})"
  else
    tooltip="${tooltip}\n- ${name}"
  fi
done

if [[ "$count" -eq 1 ]]; then
  first="${vpns[0]%%:*}"
  text="󰌾 ${first}"
else
  text="󰌾 ${count} VPNs connected"
fi

printf '{"text":"%s","tooltip":"%s","class":["vpn","connected"]}\n' \
  "$text" "$tooltip"
