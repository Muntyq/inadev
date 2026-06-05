{
	description = "Nix flake dev templates";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, utils }: {
		templates = {
			rust = {
				path = ./templates/rust/;
				description = "Rust dev shell";
				welcomeText = ''
		============================
		 ____            _
		|  _ \ _   _ ___| |_
		| |_) | | | / __| __|
		|  _ <| |_| \__ \ |_
		|_| \_\\__,_|___/\__|

		Rust dev shell ready!
		============================

		Run `direnv allow` to activate the environment.
		Run `git add flake.nix .envrc` if nix complains.
'';
			};

			c = {
				path = ./templates/c/;
				description = "C dev shell";
			};

			go = {
				path = ./templates/go/;
				description = "Go dev shell";
			};

			lua = {
				path = ./templates/lua/;
				description = "Lua dev shell";
			};
		};
	};
}

