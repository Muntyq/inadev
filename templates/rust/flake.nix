{
	description = "Rust development shell";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		rust-overlay = {
			url = "github:oxalica/rust-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
					overlays = [ rust-overlay.overlays.default ];
				};
				rustToolchain = pkgs.rust-bin.stable.latest.default.override {
					extensions = [ "rust-src" "rust-analyzer" ];
				};
			in {
				devShells.default = pkgs.mkShell {
					buildInputs = [
						rustToolchain
						pkgs.pkg-config
						# pkgs.openssl # Needed only for some crates
					];
					shellHook = ''
						export DIRENV_LOG_FORMAT=""
						echo -e "\e[1mRust $(rustc --version)\e[0m"
					'';
				};
			}
		);
}

