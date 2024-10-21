return {
  'kylechui/nvim-surround',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  config = true,
}

-- surround sample --
-- keys combinations:
-- NOTE: surround TLDR command: [operator] [s] [motion] [double keys]
-- double keys:'',"",{},(),[], tags = Html tags e.g. <div></div>

-- adding a key to surround
-- "ys" to surround([Y]ank [S]urround) + motion + keys(e.g. , "",{},tags,())
-- E.g:
-- "ysiw''" -- add a '' surrounding the word
-- "ysiwt" -- add a tag surrounding to the word

-- deleting the surround keys:
-- "ds" to surround([D]elete [S]urround) + motion + keys(e.g. , "",{},tags,())
-- E.g:
-- "dsiw''" -- delete a '' surrounding the word
-- "dsiwt" -- delete a tag surrounding to the word

-- changing the surround keys:
-- "cs" to surround([C]elete [S]urround) + motion + keys(e.g. , "",{},tags,())
-- E.g:
-- "csiw''" -- change a '' surrounding the word
-- "csiwt" -- change a tag surrounding to the word

-- more about tag:
-- if you do the command in the nested tag. Wherever your cursor is will select the parent tag
