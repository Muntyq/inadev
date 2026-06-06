{
	description = "Lua development shell";

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
						pkgs.lua
						pkgs.luarocks
						pkgs.lua-language-server
					];
					shellHook = ''
						echo -e "\e[1mLua $(lua -v)\e[0m"
					'';
				};
			}
		);
}


