#!/bin/bash -eu

REPOSITORY_ROOT=$(git rev-parse --show-toplevel)
HOME_MANAGER_ROOT="${HOME}/.config/home-manager"

mkdir -p ${HOME_MANAGER_ROOT}


for file in ./nixpkgs/*; do
    nixfile=$(basename ${file})
    ln -sf $(realpath ${file}) "${HOME_MANAGER_ROOT}/${nixfile}" && echo "$(realpath ${file}) => ${HOME_MANAGER_ROOT}/${nixfile}"
done

[[ ! $(command -v nix) ]] && sh <(curl -L https://nixos.org/nix/install) --daemon || echo "[!] nix is already installed. Skipped."

if ! command -v home-manager &>/dev/null; then
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
else
    echo "[!] home-manager is already installed. Skipped."
fi


