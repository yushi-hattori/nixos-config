--[[
NOTE:
if you plan to always load your nixCats via nix,
you can safely ignore this setup call,
and the require('nvim.non_nix_download') call below it.
as well as the entire lua/nvim/non_nix_download file.
Unless you want the lzUtils file, or the lazy wrapper, you also wont need lua/nixCatsUtils

IF YOU DO NOT DO THIS SETUP CALL:
the result will be that, when you load this folder without using nix,
the global nixCats function which you use everywhere
to check for categories will throw an error.
This setup function will give it a default value.
Of course, if you only ever download nvim with nix, this isnt needed.]]
--[[ ----------------------------------- ]]
--[[ This setup function will provide    ]]
--[[ a default value for the nixCats('') ]]
--[[ function so that it will not throw  ]]
--[[ an error if not loaded via nixCats  ]]
--[[ ----------------------------------- ]]
require('nixCatsUtils').setup {
  non_nix_value = true,
}

require('nvim')
