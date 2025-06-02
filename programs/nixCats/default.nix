{
  config,
  lib,
  inputs,
  ...
}: let
  utils = inputs.nixCats.utils;
in {
  imports = [
    inputs.nixCats.homeModule
  ];
  config = {
    # this value, nixCats is the defaultPackageName you pass to mkNixosModules
    # it will be the namespace for your options.
    nixCats = {
      enable = true;
      # nixpkgs_version = inputs.nixpkgs;
      # this will add the overlays from ./overlays and also,
      # add any plugins in inputs named "plugins-pluginName" to pkgs.neovimPlugins
      # It will not apply to overall system, just nixCats.
      addOverlays =
        /*
        (import ./overlays inputs) ++
        */
        [
          (utils.standardPluginOverlay inputs)
        ];
      # see the packageDefinitions below.
      # This says which of those to install.
      packageNames = ["myHomeModuleNvim"];

      luaPath = ./.;

      # the .replace vs .merge options are for modules based on existing configurations,
      # they refer to how multiple categoryDefinitions get merged together by the module.
      # for useage of this section, refer to :h nixCats.flake.outputs.categories
      categoryDefinitions.replace = {
        pkgs,
        settings,
        categories,
        extra,
        name,
        mkNvimPlugin,
        ...
      } @ packageDef: {
        # to define and use a new category, simply add a new list to a set here,
        # and later, you will include categoryname = true; in the set you
        # provide when you build the package using this builder function.
        # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

        # lspsAndRuntimeDeps:
        # this section is for dependencies that should be available
        # at RUN TIME for plugins. Will be available to PATH within neovim terminal
        # this includes LSPs
        lspsAndRuntimeDeps = {
          general = with pkgs; [
            lazygit
            universal-ctags
            ripgrep
            fd
            kdlfmt
          ];
          lua = with pkgs; [
            lua-language-server
            stylua
          ];
          nix = with pkgs; [
            nixd
            alejandra
          ];
          neonixdev = {
            inherit (pkgs) nix-doc nil lua-language-server nixd;
          };
        };

        # This is for plugins that will load at startup without using packadd:
        startupPlugins = {
          other = with pkgs.neovimPlugins; [
            debugmaster
          ];
          general = with pkgs.vimPlugins; [
            lze
            lzextras
            vim-repeat
            plenary-nvim
            nvim-notify
            snacks-nvim
            mini-nvim
            onedark-nvim
            vim-sleuth
            nvim-web-devicons
            lazy-nvim
            noice-nvim
            snipe-nvim
            smear-cursor-nvim
            avante-nvim
          ];
          debug = with pkgs.vimPlugins; [
            nvim-nio
          ];
          neonixdev = with pkgs.vimPlugins; [
            neodev-nvim
            neoconf-nvim
          ];
          markdown = with pkgs.vimPlugins; [
            markdown-preview-nvim
            markview-nvim
          ];
          # You can retreive information from the
          # packageDefinitions of the package this was packaged with.
          # :help nixCats.flake.outputs.categoryDefinitions.scheme
          themer = with pkgs.vimPlugins; (
            builtins.getAttr (categories.colorscheme or "onedark") {
              # Theme switcher without creating a new category
              "onedark" = onedark-nvim;
              "catppuccin" = catppuccin-nvim;
              "catppuccin-mocha" = catppuccin-nvim;
              "tokyonight" = tokyonight-nvim;
              "tokyonight-day" = tokyonight-nvim;
              "nightfox" = nightfox-nvim;
              "carbonfox" = nightfox-nvim;
            }
          );
        };

        # not loaded automatically at startup.
        # use with packadd and an autocommand in config to achieve lazy loading
        optionalPlugins = {
          debug = with pkgs.vimPlugins; {
            # it is possible to add default values.
            # there is nothing special about the word "default"
            # but we have turned this subcategory into a default value
            # via the extraCats section at the bottom of categoryDefinitions.
            default = [
              nvim-dap
              nvim-dap-ui
              nvim-dap-virtual-text
              one-small-step-for-vimkind
            ];
            go = [nvim-dap-go];
          };
          lint = with pkgs.vimPlugins; [
            nvim-lint
          ];
          format = with pkgs.vimPlugins; [
            conform-nvim
          ];
          markdown = with pkgs.vimPlugins; [
            markdown-preview-nvim
          ];
          neonixdev = with pkgs.vimPlugins; [
            lazydev-nvim
          ];
          general = {
            cmp = with pkgs.vimPlugins; [
              # cmp stuff
              nvim-cmp
              luasnip
              friendly-snippets
              cmp_luasnip
              cmp-buffer
              cmp-path
              cmp-nvim-lua
              cmp-nvim-lsp
              cmp-cmdline
              cmp-nvim-lsp-signature-help
              cmp-cmdline-history
              lspkind-nvim
            ];
            treesitter = with pkgs.vimPlugins; [
              nvim-treesitter-textobjects
              nvim-treesitter.withAllGrammars
              # This is for if you only want some of the grammars
              # (nvim-treesitter.withPlugins (
              #   plugins: with plugins; [
              #     nix
              #     lua
              #   ]
              # ))
            ];
            telescope = with pkgs.vimPlugins; [
              telescope-fzf-native-nvim
              telescope-ui-select-nvim
              telescope-nvim
            ];
            always = with pkgs.vimPlugins; [
              nvim-lspconfig
              lualine-nvim
              gitsigns-nvim
              vim-sleuth
              vim-fugitive
              vim-rhubarb
              nvim-surround
              hardtime-nvim
            ];
            extra = with pkgs.vimPlugins; [
              fidget-nvim
              # lualine-lsp-progress
              which-key-nvim
              comment-nvim
              undotree
              indent-blankline-nvim
              vim-startuptime
              zellij-nav-nvim
              # If it was included in your flake inputs as plugins-hlargs,
              # this would be how to add that plugin in your config.
              # pkgs.neovimPlugins.hlargs
            ];
          };
        };

        # shared libraries to be added to LD_LIBRARY_PATH
        # variable available to nvim runtime
        sharedLibraries = {
          general = with pkgs; [];
        };

        # environmentVariables:
        # this section is for environmentVariables that should be available
        # at RUN TIME for plugins. Will be available to path within neovim terminal
        environmentVariables = {
          # test = {
          #   CATTESTVAR = "It worked!";
          # };
        };

        # categories of the function you would have passed to withPackages
        extraPython3Packages = {
          # test = [ (_:[]) ];
        };

        # If you know what these are, you can provide custom ones by category here.
        # If you dont, check this link out:
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
        extraWrapperArgs = {
          # test = [
          #   '' --set CATTESTVAR2 "It worked again!"''
          # ];
        };
      };

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions.replace = {
        # These are the names of your packages
        # you can include as many as you wish.
        myHomeModuleNvim = {pkgs, ...}: {
          # they contain a settings set defined above
          # see :help nixCats.flake.outputs.settings
          settings = {
            wrapRc = false;
            # configDirName = "nvim";
            unwrappedCfgPath = "${config.home.homeDirectory}/nixos-config/programs/nixCats/";
            # IMPORTANT:
            # your alias may not conflict with your other packages.
            aliases = ["nvim" "vim"];
            # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
          };
          # and a set of categories that you want
          # (and other information to pass to lua)
          # and a set of categories that you want
          categories = {
            general = true;
            lua = true;
            nix = true;
            neonixdev = true;
            debug = true;
            markdown = true;
            lint = true;
            format = true;
            themer = true;
            colorscheme = "carbonfox";
            other = true;
            default = true;
          };
          # anything else to pass and grab in lua with `nixCats.extra`
          extra = {
            nixdExtras.nixpkgs = ''import ${pkgs.path} {}'';
          };
        };

        defaultPackageName = "myHomeModuleNvim";
      };
    };
  };
}
