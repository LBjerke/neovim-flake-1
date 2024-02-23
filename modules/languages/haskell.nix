{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.haskell;
in {
  options.vim.languages.haskell = {
    enable = mkEnableOption "Haskell language support";

    treesitter = {
      enable = mkOption {
        description = "Enable Haskell treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "haskell";
    };
    lsp = {
      enable = mkOption {
        description = "Haskell LSP support (hls)";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      package = mkOption {
        description = "HLS package";
        type = types.package;
        default = pkgs.haskell-language-server;
      };
      haskellPackage = mkOption {
        description = "Haskell package used by HLS";
        type = types.package;
        default = pkgs.ghc;
      };
    };
    format = {
      enable = mkOption {
        description = "Enable Haskell formatting";
        type = types.bool;
        default = config.vim.languages.enableFormat;
      };
      type = mkOption {
        description = "Haskell formatter to use";
        type = with types; enum (attrNames formats);
        default = defaultFormat;
      };
      package = mkOption {
        description = "Haskell formatter package";
        type = types.package;
        default = formats.${cfg.format.type}.package;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.treesitter.enable {
      vim.treesitter.enable = true;
      vim.treesitter.grammars = [cfg.treesitter.package];
    })

    (mkIf cfg.lsp.enable {
      vim.lsp.lspconfig.enable = true;
      vim.lsp.lspconfig.sources.haskell-lsp = ''
        lspconfig.hls.setup {
        capabilities = capabilities,
        on_attach=default_on_attach,
        cmd = {"${cfg.lsp.package}/bin/haskell-language-server-wrapper", "--lsp"},
        filetypes = { 'haskell', 'lhaskell', 'cabal' },
        haskell = {
        cabalFormattingProvider = "${pkgs.haskellPackages.cabal-fmt}/bin/cabalfmt",
        }
        }
      '';
    })
  ]);
}
