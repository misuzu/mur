#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq

cd pkgs/$UPDATE_NIX_PNAME

curl https://api.github.com/repos/home-assistant/operating-system/releases/latest | jq -r '
{
  platforms: {
      "aarch64-linux": ("haos_generic-aarch64-" + .tag_name + ".qcow2.xz" as $name | first(.assets[] | select(.name == $name)) | {
        url: .browser_download_url,
        sha256: .digest | sub("^sha256:"; "")
      }),
      "x86_64-linux": ("haos_ova-" + .tag_name + ".qcow2.xz" as $name | first(.assets[] | select(.name == $name)) | {
        url: .browser_download_url,
        sha256: .digest | sub("^sha256:"; "")
      })
  },
  version: .tag_name
}
' > src.json
