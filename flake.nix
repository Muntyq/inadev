{
	description = "Nix flake dev templates";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, utils }:
		utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs { inherit system; };
			in {
				packages.inadev = pkgs.writeShellScriptBin "inadev" (builtins.readFile ./script/inadev.sh);
				packages.default = self.packages.${pkgs.stdenv.hostPlatform.system}.inadev;
			}
		) // {
			templates = {
				rust = {
					path = ./templates/rust;
					description = "Rust dev shell";
				};

				c = {
					path = ./templates/c;
					description = "C dev shell";
				};

				go = {
					path = ./templates/go;
					description = "Go dev shell";
				};

				lua = {
					path = ./templates/lua;
					description = "Lua dev shell";
				};
			};
		};
}

