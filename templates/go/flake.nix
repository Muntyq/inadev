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
						export DIRENV_LOG_FORMAT=""
						echo "\e[1mGo $(go version)\e[0m"
					'';
				};
			}
		);
}


