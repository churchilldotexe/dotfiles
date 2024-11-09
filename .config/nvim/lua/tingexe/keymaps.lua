vim.g.mapleader = ' '

local keymap = vim.keymap -- for conciseness

-- remap and unmap q to avoid CMP error
-- Unmap the 'q' key
keymap.set('n', 'q', '<Nop>', { noremap = true })
-- Remap 'q' to 'vm'
keymap.set('n', '<A-q>', 'q', { desc = 'Vim Macro-[Alt][q]' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
keymap.set('n', 'n', 'nzzzv', { desc = 'go to next search cursor stays Middle' })
keymap.set('n', 'N', 'Nzzzv', { desc = 'go to previous search cursor stays Middle' })
keymap.set('n', '<leader>raw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]ename [A]ll [W]ords under cursor' })

-- source %
keymap.set('n', '<leader>src', ':source %<CR>', { desc = 'source the file' })

-- Spell check
function toggleSpellCheck()
  if vim.o.spell then
    vim.o.spell = false
    vim.notify('spell check off', 2)
  else
    vim.o.spell = true
    vim.o.spelllang = 'en_us'

    vim.notify('spell check on', 2)
  end
end

keymap.set('n', '<leader>spc', toggleSpellCheck, { desc = '[S]et [S]pell' })

-- saving, closing, close and save a file
keymap.set('n', '<leader>ww', ':w<CR>', { desc = 'save file' })
keymap.set('n', '<leader>wn', ':w<CR>', { desc = '[W]rite file [N]o format' })
keymap.set('n', '<leader>wq', ':wq!<CR>', { desc = 'save and close file' })
keymap.set('n', '<leader>qq', ':qa!<CR>', { desc = 'close all files' })

-- Copy paste and delete mappings
keymap.set('n', '<leader>y', '"+y', { desc = '[Y]ank to system clipboard + Your Motion' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank to system clipboard + Your Motion' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = '[Y]ank to system clipboard + Your Motion' })
keymap.set('x', '<leader>P', [["_dP]], { desc = '[p]aste and retains prev word' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]], { desc = '[P]aste from system clipboard + Your Motion' })
keymap.set('n', '<leader>dd', '"_d', { desc = 'delete character and place to the void' })
keymap.set('v', '<leader>dd', '"_d', { desc = 'delete character and place to the void' })
keymap.set('n', 'x', '"_x', { desc = 'delete character and place to the void' })

-- setting/setting wrapping with break indent
keymap.set('n', '<leader>sw', '<cmd>set wrap<bar>set breakindent<CR>', { desc = '[S]et [W]rap with Breakindent' })
keymap.set('n', '<leader>snw', '<cmd>set nowrap<bar>set nobreakindent<CR>', { desc = '[S]et [N]o[W]rap with nobreakindent' })

--creating new line that stays in NORMAL MODE
keymap.set('n', '<leader>o', 'o<Esc>', { desc = "create new line 'under' the cursor and back to normal mode" })
keymap.set('n', '<leader>O', 'O<Esc>', { desc = "create new line 'above' the cursor and back to normal mode" })

-- increment/decrements numbers
keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' })
keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' })

-- window management
-- new tmux session
keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- pane
keymap.set('n', '<leader>|', '<C-w>v', { desc = 'Split window vertically' })
keymap.set('n', '<leader>-', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Make Splits equal size' })
keymap.set('n', '<leader>wx', '<cmd>close<CR>', { desc = 'Close current split' })

-- tab
keymap.set('n', '<tab><tab>', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
keymap.set('n', '<tab>x', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
keymap.set('n', '<tab>n', '<cmd>tabn<CR>', { desc = 'Go to next tab' })
keymap.set('n', '<tab>p', '<cmd>tabp<CR>', { desc = 'Go to previous tab' })
keymap.set('n', '<tab>f', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' })

-- insert mode navigation (without leaving insert mode)
keymap.set('i', '<C-h>', '<Left>', { desc = 'insert mode move left' })
keymap.set('i', '<C-j>', '<Dows>', { desc = 'insert mode move down' })
keymap.set('i', '<C-k>', '<Up>', { desc = 'insert mode move up' })
keymap.set('i', '<C-l>', '<Right>', { desc = 'insert mode move right' })

keymap.set('i', '<A-h>', '<C-Left>', { desc = 'insert mode move ONE word left' })
keymap.set('i', '<A-j>', '<C-Dows>', { desc = 'insert mode move ONE word down' })
keymap.set('i', '<A-k>', '<C-Up>', { desc = 'insert mode move ONE word up' })
keymap.set('i', '<A-l>', '<C-Right>', { desc = 'insert mode move ONE word right' })

-- visual mode mapping
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move the hightligted character one line UP' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move the hightligted character one line DOWN' })

-- normal mode mapping
keymap.set('n', 'J', 'mzJ`z', { desc = 'Append the line below to current line but cursor stays' })
keymap.set('n', '<leader>a', 'a <Esc>h', { desc = '[A]ppend one whitespace forward  ' })
keymap.set('n', '<leader>i', 'i <Esc>l', { desc = '[I]nsert one whitespace backward  ' })
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Page navigation
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'scroll half page up and stay screen center' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'scroll half page down and stay screen center' })
vim.keymap.set('n', '<leader>j', "'", { desc = '[J]ump on marker' })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>xe', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>xq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TransparentToggle
-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>td',
--   [[:TransparentToggle<CR>:highlight Normal guibg=#000000<CR>:lua vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true }) vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true }) vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })<CR>]],
--   { noremap = true, silent = true }
-- )

vim.api.nvim_set_keymap(
  'n',
  '<leader>td',
  [[:TransparentToggle<CR>:lua vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true }) vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true }) vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })<CR>]],
  { noremap = true, silent = true }
)

-- Restart LSP
keymap.set('n', '<leader>rs', ':LspRestart<CR>', { desc = '[R]estart L[S]P' }) -- mapping to restart lsp if necessary
keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Smart rename' })

-- dismiss NOICE.nvim
keymap.set('n', '<leader>nd', '<cmd>NoiceDismiss<CR>', { desc = '[N]oice [Dismiss]' })
