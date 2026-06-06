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
				packages.default = self.packages.${system}.inadev;
			}
		) // {
			templates = {
				rust = {
					path = ./templates/rust/;
					description = "Rust dev shell";
					welcomeText = ''
						==================================
						           ____            _
						          |  _ \ _   _ ___| |_
						          | |_) | | | / __| __|
						          |  _ <| |_| \__ \ |_
						  Inadev: |_| \_\\__,_|___/\__|

						==================================

					'';
				};

				c = {
					path = ./templates/c/;
					description = "C dev shell";
					welcomeText = ''
						====================
						            ____
						           / ___|
						          | |
						          | |___
						  Inadev:  \____|

						====================

					'';
				};

				go = {
					path = ./templates/go/;
					description = "Go dev shell";
					welcomeText = ''
						===========================
						            ____
						           / ___| ___
						          | |  _ / _ \
						          | |_| | (_) |
						  Inadev:  \____|\___/

						===========================

					'';
				};

				lua = {
					path = ./templates/lua/;
					description = "Lua dev shell";
					welcomeText = ''
						================================
						           _
						          | |   _   _  __ _
						          | |  | | | |/ _` |
						          | |__| |_| | (_| |
						  Inadev: |_____\__,_|\__,_|

						================================

					'';
				};
			};
		};
}

