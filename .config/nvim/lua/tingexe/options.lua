-- " Disable tmux navigator when zooming the Vim pane
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.tmux_navigator_preserve_zoom = 1

vim.cmd 'let g:netrw_liststyle = 3'
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 3 -- 2 spaces for tabs(prettier default)
opt.shiftwidth = 3 -- 2 spaces for indent width
opt.softtabstop = 3
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = true -- setting wrap
opt.breakindent = true -- to follow the indentation

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- /vim.* =
-- this will highligh "vim." until "=" only

opt.cursorline = true

--turn on termguicolors for theme colorscheme to work
--(need a true color terminal to work)
opt.termguicolors = true
opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
opt.signcolumn = 'yes' -- show sign column so that text doesn't shift
opt.isfname:append '@-@'
-- vim.opt.colorcolumn = "80"

--backspace
--opt.backspace = "indent,eol,start" == allow backspace on indent, end of line or insert mode start position

-- clipboard
-- opt.clipboard:append 'unnamedplus' -- use system clipboard as default register
-- opt.clipboard = "unnamedplus,unnamed"

-- Decrease update time
opt.updatetime = 50

-- split windows
opt.splitright = true -- split window vertically to the right
opt.splitbelow = true -- split window horizontally to the bottom

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Set tabs to 2 spaces
opt.tabstop = 3
opt.softtabstop = 3
opt.expandtab = true

-- Enable persistent undo history
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv 'HOME' .. '/.vim/unodir'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- options ---

-- Function to get the full path and replace the home directory with ~
local function get_winbar_path()
  local full_path = vim.fn.expand '%:p'
  return full_path:gsub(vim.fn.expand '$HOME', '~')
end

-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
  local buffers = vim.fn.execute 'ls'
  local count = 0
  -- Match only lines that represent buffers, typically starting with a number followed by a space
  for line in string.gmatch(buffers, '[^\r\n]+') do
    if string.match(line, '^%s*%d+') then
      count = count + 1
    end
  end
  return count
end
-- Function to update the winbar
local function update_winbar()
  local home_replaced = get_winbar_path()
  local buffer_count = get_buffer_count()
  vim.opt.winbar = '%#WinBar1#%m '
    .. '%#WinBar2#('
    .. buffer_count
    .. ') '
    .. '%#WinBar1#'
    .. home_replaced
    .. '%*%=%#WinBar2#'
    .. vim.fn.systemlist('hostname')[1]
end
-- Autocmd to update the winbar on BufEnter and WinEnter events
vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  callback = update_winbar,
})
