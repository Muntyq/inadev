{
	description = "C development shell";

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
						pkgs.gcc
						pkgs.gnumake
						pkgs.cmake
						pkgs.gdb
						pkgs.pkg-config
						pkgs.clang-tools
					];
					shellHook = ''
						export DIRENV_LOG_FORMAT=""
						echo "\e[1mGCC $(gcc --version | head -1)\e[0m"
					'';
				};
			}
		);
}


