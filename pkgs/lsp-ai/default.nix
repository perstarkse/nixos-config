{ lib, fetchCrate, rustPlatform }:

rustPlatform.buildRustPackage rec {
pname = "lsp-ai";
version = "0.3.0";

src = fetchCrate {
inherit pname version;
sha256 = lib.fakeSha256;
};

cargoHash = lib.fakeSha256;

meta = with lib; {
description = "LSP-AI is an open-source language server that serves as a backend for AI-powered functionality, designed to assist and empower software engineers, not replace them.";
homepage = "https://github.com/SilasMarvin/lsp-ai";
license = licenses.mit;
maintainers = [perstarkse];
};
}
