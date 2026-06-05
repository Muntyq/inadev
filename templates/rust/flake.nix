{
	description = "Rust development shell";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		rust-overlay = {
			url = "github:oxalica/rust-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outpus = { self, nixpkgs, rust-overlay, ... };
		let
			systems = [ "x86_64-linux" "aarch64-linux" ];
			overlays = [ rust-overlay.overlays.default ];
		};
		in {
			devShells =
