return {

  'nvim-tree/nvim-web-devicons',

  {
    'yamatsum/nvim-nonicons',
    dependencies = 'nvim-tree/nvim-web-devicons',
  },

  { -- colorize colors
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        css = true,
        names = false,
        mode = 'background',
        tailwind = 'lsp',
      },
    },
  },

  {
    'ziontee113/icon-picker.nvim',
    cmd = { 'IconPickerNormal', 'IconPickerInsert', 'IconPickerYank' },
    opts = {},
  },
}
