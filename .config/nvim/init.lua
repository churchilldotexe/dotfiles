package.path = package.path .. ";/home/ting/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path
  .. ";/nix/store/4w03kfgrpnyvmvzsdnzflam247zkmkzn-luarocks_bootstrap-3.11.1/share/lua/5.1/?.lua"
package.path = package.path
  .. ";/nix/store/4w03kfgrpnyvmvzsdnzflam247zkmkzn-luarocks_bootstrap-3.11.1/share/lua/5.1/?/init.lua"

-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "tingexe.keymaps"
require "tingexe.options"
require "tingexe.autocmds"
require "polish"
