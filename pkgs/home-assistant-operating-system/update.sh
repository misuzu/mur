#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq

cd "$(dirname "${BASH_SOURCE[0]}")"

curl https://api.github.com/repos/home-assistant/operating-system/releases/latest | jq -r '
{
  "aarch64-linux": ("haos_generic-aarch64-" + .tag_name + ".qcow2.xz" as $name | first(.assets[] | select(.name == $name)) | {
    url: .browser_download_url,
    hash: .digest
  }),
  "x86_64-linux": ("haos_ova-" + .tag_name + ".qcow2.xz" as $name | first(.assets[] | select(.name == $name)) | {
    url: .browser_download_url,
    hash: .digest
  }),
  version: .tag_name
}
' > src.json
