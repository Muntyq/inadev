{
	description = "Go development shell";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils, ... }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
				};
			in {
				devShells.default = pkgs.mkShell {
					buildInputs = [
						pkgs.go
						pkgs.gopls
						pkgs.gotools
						pkgs.delve
					];
					shellHook = ''
						echo -e "\e[1m;94mGo $(go version)\e[0m"
					'';
				};
			}
		);
}


