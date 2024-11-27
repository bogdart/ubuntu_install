-- These are Artem's settings
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { silent = true })
vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', {})
vim.api.nvim_set_keymap('n', '<CR>', 'a', {})

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('i', '(', '()<Left>', opts)
vim.api.nvim_set_keymap('i', '[', '[]<Left>', opts)
vim.api.nvim_set_keymap('i', '{', '{}<Left>', opts)
vim.api.nvim_set_keymap('i', '"', '""<Left>', opts)
vim.api.nvim_set_keymap('i', "'", "''<Left>", opts)


require 'FlexokiLight'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.cursorline = true
vim.opt.scrolloff = 20

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.opt.termguicolors = true
vim.opt.updatetime = 50

-- code line
vim.opt.colorcolumn = "80"
vim.cmd [[highlight ColorColumn guibg=#FFFFE0]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})









local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",  -- Corrected the path
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support
    },
    config = function()
      require('neo-tree').setup({
        sources = {
          'filesystem', 'buffers', 'git_status'
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true
          }
        }
      })
    end
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      defaults = {
        preset = 'helix',
      },
    },
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>u'] = { name = 'Undo tree', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = 'lazy git	', _ = 'which_key_ignore' },
        ['<leader>n'] = { name = 'Neotree', _ = 'which_key_ignore' },
        ['<leader>ng'] = { name = 'Neotree git', _ = 'which_key_ignore' },
	['<leader>f'] = { name = 'Find ...', _ = 'which_key_ignore' },
        ['<leader>ff'] = { name = 'Find files', _ = 'which_key_ignore' },
        ['<leader>fg'] = { name = 'Find git', _ = 'which_key_ignore' },
        ['<leader>fp'] = { name = 'Live Grep', _ = 'which_key_ignore' },
        ['<leader>fw'] = { name = 'Find word', _ = 'which_key_ignore' },
        ['<leader>fP'] = { name = 'String Grep', _ = 'which_key_ignore' },
        ['<leader>j'] = { name = 'Need to add jupyter', _ = 'which_key_ignore' },
      }
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'python', 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- maybe later - this is git
  -- {"tpope/vim-fugitive"}
  {
    "nvim-telescope/telescope.nvim",

    ranch = '0.1.x',

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')


        vim.keymap.set('n', '<leader>fw', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>fP', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)


	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
	vim.keymap.set('n', '<leader>fp', builtin.live_grep, {})


    end
  },

{
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
        -- this is an example, not a default. Please see the readme for more configuration options
        vim.g.molten_output_win_max_height = 12
    end,
},
{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'}



}

)

-- Function to open NeoTree on Neovim startup
local function open_neotree()
    vim.cmd("Neotree")  -- Opens the file explorer view
    -- If you want to open the git status view, use:
    -- vim.cmd("NeoTreeGitStatus")
end

-- Setup an autocommand to run the function at VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = open_neotree
})

vim.opt.termguicolors = true
require("bufferline").setup{}



vim.api.nvim_set_keymap('n', '<leader>ne', ':Neotree toggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ng', ':Neotree git_status<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)








