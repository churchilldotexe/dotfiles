local keymap = vim.keymap -- for conciseness
local vscode = require 'vscode'

vim.cmd 'nmap <C-BS> :e ~/.config/nvim/vsvim/init.lua<cr>'

vim.opt.hlsearch = true
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.cmd 'nmap n nzzzv'
vim.cmd 'nmap N Nzzzv'

-- Page navigation
vim.cmd 'nmap <C-u> <C-u>zz '
vim.cmd 'nmap <C-d> <C-d>zz '

-- peek buffers
vim.keymap.set('n', '<leader> ', function()
  vscode.call 'workbench.action.showAllEditors'
end, {})

-- tabs
vim.keymap.set('n', '<leader>wx', function()
  vscode.call 'workbench.action.closeActiveEditor'
end, { silent = true })
vim.keymap.set('n', '<tab>n', function()
  vscode.call 'workbench.action.nextEditorInGroup'
end, { silent = true })
vim.keymap.set('n', '<tab>p', function()
  vscode.call 'workbench.action.previousEditorInGroup'
end, { silent = true })

-- moving selected lines
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move the hightligted character one line UP' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move the hightligted character one line DOWN' })

--- CODE and FILES KEYBINDINGS ---
-- code action
vim.keymap.set('n', '<leader>ca', function()
  vscode.call 'editor.action.codeAction'
end, { silent = true })

-- go to symbols(variables)
vim.keymap.set('n', '<leader>cs', function()
  vscode.call 'workbench.action.gotoSymbol'
end, { silent = true })

--rename symbol(variables)
vim.keymap.set('n', '<leader>rn', function()
  vscode.call 'editor.action.rename'
end, { silent = true })

--go to Reference(types)
vim.keymap.set('n', 'gr', function()
  vscode.call 'editor.action.goToReferences'
end, { silent = true })

-- go to link
vim.keymap.set('n', '<leader>gl', function()
  vscode.call 'editor.action.openLink'
end, { silent = true })

-- --File list(search file)
-- vim.keymap.set('n', '<leader>sf', function()
--   vscode.call 'workbench.action.quickOpen'
-- end, { silent = true })

--FindItFaster File search(search file)
vim.keymap.set('n', '<leader>sf', function()
  vscode.call 'find-it-faster.findFiles'
end, { silent = true })

-- live grep(search grep)
-- vim.keymap.set('n', '<leader>sg', function()
--   vscode.call 'workbench.action.findInFiles'
-- end, { silent = true })

-- FindItFaster search word (search grep)
vim.keymap.set('n', '<leader>sg', function()
  vscode.call 'find-it-faster.findWithinFiles'
end, { silent = true })

-- go to git(like lazy git)
vim.keymap.set('n', '<leader>lg', function()
  vscode.call('workbench.scm.focus', { args = { 'scmInput' } })
end, { silent = true })

-- command palettte
vim.keymap.set('n', '<leader>sp', function()
  vscode.call 'workbench.action.showCommands'
end, { silent = true })

-- incremental select
vim.keymap.set({ 'n', 'x' }, '<C-n>', function()
  vscode.call 'editor.action.addSelectionToNextFindMatch'
end, { silent = true })

-- inQuickOpen && neovim.mode != 'cmdline'

--creating new line that stays in NORMAL MODE
keymap.set('n', '<leader>o', 'o<Esc>', { desc = "create new line 'under' the cursor and back to normal mode" })
keymap.set('n', '<leader>O', 'O<Esc>', { desc = "create new line 'above' the cursor and back to normal mode" })

keymap.set('n', '<leader>a', 'a <Esc>h', { desc = '[A]ppend one whitespace forward  ' })
keymap.set('n', '<leader>i', 'i <Esc>l', { desc = '[I]nsert one whitespace backward  ' })

-- Opening File Explorer
vim.keymap.set({ 'n', 'x' }, '<leader>ef', function()
  vscode.call 'workbench.view.explorer'
end, { silent = true })

-- saving, closing, close and save a file
vim.cmd 'nmap <leader>ww :w<CR>'
vim.cmd 'nmap <leader>wq :wq<CR>'
vim.cmd 'nmap <leader>qq :qa<CR>'

-- Copy paste and delete mappings
keymap.set('n', '<leader>y', '"+y', { desc = '[Y]ank to system clipboard + Your Motion' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank to system clipboard + Your Motion' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = '[Y]ank to system clipboard + Your Motion' })
keymap.set('x', '<leader>P', [["_dP]], { desc = '[p]aste and retains prev word' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]], { desc = '[P]aste from system clipboard + Your Motion' })
keymap.set('n', '<leader>dd', '"_d', { desc = 'delete character and place to the void' })
keymap.set('v', '<leader>dd', '"_d', { desc = 'delete character and place to the void' })
keymap.set('n', 'x', '"_x', { desc = 'delete character and place to the void' })
