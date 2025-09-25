# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license

# This is an empty nixCats config.
# you may import this template directly into your nvim folder
# and then add plugins to categories here,
# and call the plugins with their default functions
# within your lua, rather than through the nvim package manager's method.
# Use the help, and the example config github:BirdeeHub/nixCats-nvim?dir=templates/example

# It allows for easy adoption of nix,
# while still providing all the extra nix features immediately.
# Configure in lua, check for a few categories, set a few settings,
# output packages with combinations of those categories and settings.

# All the same options you make here will be automatically exported in a form available
# in home manager and in nixosModules, as well as from other flakes.
# each section is tagged with its relevant help section.

{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    plugins-volt = {
      url = "github:nvchad/volt";
      flake = false;
    };

    plugins-xcodebuild = {
      url = "github:wojciech-kulik/xcodebuild.nvim";
      flake = false;
    };

    plugins-fzf-lua = {
      url = "github:ibhagwan/fzf-lua";
      flake = false;
    };

    plugins-fzf-lua-frecency = {
      url = "github:elanmed/fzf-lua-frecency.nvim";
      flake = false;
    };
    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    # };

    # see :help nixCats.flake.inputs
    # If you want your plugin to be loaded by the standard overlay,
    # i.e. if it wasnt on nixpkgs, but doesnt have an extra build step.
    # Then you should name it "plugins-something"
    # If you wish to define a custom build step not handled by nixpkgs,
    # then you should name it in a different format, and deal with that in the
    # overlay defined for custom builds in the overlays directory.
    # for specific tags, branches and commits, see:
    # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html#examples

  };

  # see :help nixCats.flake.outputs
  outputs = { self, nixpkgs, nixCats, ... }@inputs: let
    inherit (nixCats) utils;
    luaPath = ./.;
    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
    # the following extra_pkg_config contains any values
    # which you want to pass to the config set of nixpkgs
    # import nixpkgs { config = extra_pkg_config; inherit system; }
    # will not apply to module imports
    # as that will have your system values
    extra_pkg_config = {
      # allowUnfree = true;
    };
    # management of the system variable is one of the harder parts of using flakes.

    # so I have done it here in an interesting way to keep it out of the way.
    # It gets resolved within the builder itself, and then passed to your
    # categoryDefinitions and packageDefinitions.

    # this allows you to use ${pkgs.system} whenever you want in those sections
    # without fear.

    # see :help nixCats.flake.outputs.overlays
    dependencyOverlays = /* (import ./overlays inputs) ++ */ [
      # This overlay grabs all the inputs named in the format
      # `plugins-<pluginName>`
      # ex:
      # plugins-base46 = {
      #   url = "github:nvchad/base46";
      #   flake = false;
      # };
      # Once we add this overlay to our nixpkgs, we are able to
      # use `pkgs.neovimPlugins`, which is a set of our plugins.
      (utils.standardPluginOverlay inputs)
      # add any other flake overlays here.

      # when other people mess up their overlays by wrapping them with system,
      # you may instead call this function on their overlay.
      # it will check if it has the system in the set, and if so return the desired overlay
      # (utils.fixSystemizedOverlay inputs.codeium.overlays
      #   (system: inputs.codeium.overlays.${system}.default)
      # )
    ];

    # see :help nixCats.flake.outputs.categories
    # and
    # :help nixCats.flake.outputs.categoryDefinitions.scheme
    categoryDefinitions = { pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef: {
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
          nixd
          nixfmt
          lua-language-server
          bash-language-server
          stylua
          shfmt
          languagetool
        ] ++ 
          pkgs.lib.optionals pkgs.stdenv.isDarwin (with pkgs; [
            pngpaste
          ]);
      };

      # This is for plugins that will load at startup without using packadd:
      startupPlugins = {
        gitPlugins = with pkgs.neovimPlugins; [
          volt
        ];

        editor = with pkgs.vimPlugins; [
          base46
          lze
          lzextras
          nvchad-ui
          oil-nvim
          plenary-nvim
          # folke plugin
          snacks-nvim
        ];

        mini = with pkgs.vimPlugins; [
          mini-cursorword
          mini-icons
          mini-pairs
          mini-surround
          mini-files
          mini-clue
        ];
      };

      # not loaded automatically at startup.
      # use with packadd and an autocommand in config to achieve lazy loading
      optionalPlugins = {
        general = with pkgs.vimPlugins; [
          conform-nvim

          gitsigns-nvim
          grug-far-nvim

          render-markdown-nvim

          vim-sleuth
          vim-jjdescription
        ];

        debug = with pkgs.vimPlugins; [
          nvim-dap
          nvim-dap-ui
          nvim-nio
        ];

        jj = with pkgs.vimPlugins; [
          hunk-nvim
        ];

        neodev = with pkgs.vimPlugins; [
          luvit-meta
          # folke plugin
          lazydev-nvim
        ];

        lsp = with pkgs.vimPlugins; [
          nvim-lspconfig
          blink-cmp
          luasnip
          friendly-snippets
        ];

        ui = with pkgs.vimPlugins; [
          fidget-nvim
          pkgs.neovimPlugins.fzf-lua
          pkgs.neovimPlugins.fzf-lua-frecency
          nui-nvim
          # folke plugins
          todo-comments-nvim
          noice-nvim
        ];

        xcodebuild = [
          pkgs.neovimPlugins.xcodebuild
          pkgs.vimPlugins.telescope-nvim
        ];

        treesitter = with pkgs.vimPlugins; [
          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects
          mini-ai
        ];

        ai = with pkgs.vimPlugins; [
          codecompanion-nvim
          avante-nvim
          dressing-nvim
          img-clip-nvim
        ];
      };

      # shared libraries to be added to LD_LIBRARY_PATH
      # variable available to nvim runtime
      sharedLibraries = {
        general = with pkgs; [
          # libgit2
        ];
      };
    };

    # And then build a package with specific categories from above here:
    # All categories you wish to include must be marked true,
    # but false may be omitted.
    # This entire set is also passed to nixCats for querying within the lua.

    # see :help nixCats.flake.outputs.packageDefinitions
    packageDefinitions = {
      # These are the names of your packages
      # you can include as many as you wish.
      stevenvim = {pkgs , name, ... }: {
        # they contain a settings set defined above
        # see :help nixCats.flake.outputs.settings
        settings = {
          suffix-path = true;
          suffix-LD = true;
          wrapRc = true;
          configDirName = "stevenvim";
          # IMPORTANT:
          # your alias may not conflict with your other packages.
          aliases = [ "svim" ];
          # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
        };
        # and a set of categories that you want
        # (and other information to pass to lua)
        categories = {
          editor = true;
          general = true;
          gitPlugins = true;
          mini = true;
          debug = true;
          neodev = true;
          lsp = true;
          ui = true;
          treesitter = true;
          ai = true;
          xcodebuild = pkgs.stdenv.hostPlatform.isDarwin;
        };
      };

      jjedit = { pkgs, name, ...}: {
        settings = {
          suffix-path = true;
          suffix-LD = true;
          wrapRc = true;
          configDirName = "jjedit";
        };
        # and a set of categories that you want
        # (and other information to pass to lua)
        categories = {
          editor = true;
          gitPlugins = true;
          mini = true;
          treesitter = true;
          jj = true;
        };
      };
    };
  # In this section, the main thing you will need to do is change the default package name
  # to the name of the packageDefinitions entry you wish to use as the default.
    defaultPackageName = "stevenvim";
  in


  # see :help nixCats.flake.outputs.exports
  forEachSystem (system: let
    nixCatsBuilder = utils.baseBuilder luaPath {
      inherit nixpkgs system dependencyOverlays extra_pkg_config;
    } categoryDefinitions packageDefinitions;
    defaultPackage = nixCatsBuilder defaultPackageName;
    # this is just for using utils such as pkgs.mkShell
    # The one used to build neovim is resolved inside the builder
    # and is passed to our categoryDefinitions and packageDefinitions
    pkgs = import nixpkgs { inherit system; };
  in
  {
    # these outputs will be wrapped with ${system} by utils.eachSystem

    # this will make a package out of each of the packageDefinitions defined above
    # and set the default package to the one passed in here.
    packages = utils.mkAllWithDefault defaultPackage;

    # choose your package for devShell
    # and add whatever else you want in it.
    devShells = {
      default = pkgs.mkShell {
        name = defaultPackageName;
        packages = [ defaultPackage ];
        inputsFrom = [ ];
        shellHook = ''
        '';
      };
    };

  }) // (let
    # we also export a nixos module to allow reconfiguration from configuration.nix
    nixosModule = utils.mkNixosModules {
      moduleNamespace = [ defaultPackageName ];
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
    };
    # and the same for home manager
    homeModule = utils.mkHomeModules {
      moduleNamespace = [ defaultPackageName ];
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
    };
  in {

    # these outputs will be NOT wrapped with ${system}

    # this will make an overlay out of each of the packageDefinitions defined above
    # and set the default overlay to the one named here.
    overlays = utils.makeOverlays luaPath {
      inherit nixpkgs dependencyOverlays extra_pkg_config;
    } categoryDefinitions packageDefinitions defaultPackageName;

    nixosModules.default = nixosModule;
    homeModules.default = homeModule;

    inherit utils nixosModule homeModule;
    inherit (utils) templates;
  });

}
