---------------------------------------------
-- Lua nvim config for extensible features --
---------------------------------------------


--[[ GENERAL SETTINGS ]]--

-- show mode
-- NOTE: only turn off when using status line plugin
vim.opt.showmode = false

-- leader key
-- NOTE: Must happen before plugins (or wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set project specific settings as needed
-- NOTE: use .exrc, .nvimrc, or .nvim.lua in local directory
vim.o.exrc = true


--[[ TERMINAL MODE ]]--
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }), 
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

vim.keymap.set('n', "<leader>t", 
    function()
        vim.cmd.new()
        vim.cmd.term()
        vim.cmd.wincmd('J')
        vim.api.nvim_win_set_height(0, 5)
    end
)


--[[ PLUGIN MANAGER ]]--

-- bootstrap lazy.nvim --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


--[[ configure & install plugins ]]--
require("lazy").setup({
    spec = { 
        ---- plugins here ----

        -- Treesitter --
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            opts = {
                ensure_installed = { 'bash', 'c', 'cpp', 'diff', 'lua', 'luadoc', 'vim', 'vimdoc' },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = false },
            },
        },

        -- Telescope --
        {
            "nvim-telescope/telescope.nvim",
            event = "VimEnter",
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
        },

        -- Lualine --
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },

            options = {
                icons_enabled = true,
                theme = "gruvbox-material",
            }
        },

        -- yazi --
        {
            "mikavilpas/yazi.nvim",
            event = VeryLazy,
            keys = {
                {
                    '<leader>y',
                    '<cmd>Yazi<cr>',
                    desc = 'Open [Y]azi at current file'
                },
                {
                    '<leader>yd',
                    '<cmd>Yazi cwd<cr>',
                    desc = 'Open [Y]azi in working [D]irectory'
                },
            },
            --@type YaziConfig
            opts = {
                -- if you want to open yazi instead of netrw
                open_for_directories = false,
                keymaps = { show_help = '<f1>' }
            },
        },
    },
    ---- settings here ----
    -- automatically check for updates
    checker = { enabled = true },
})


--[[ plugin keybinds & Startup ]]--

-- telescope
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch existing [B]uffers' })
vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = '[S]earch [T]reesitter Queries' })

-- lualine
require('lualine').setup()

-- yazi
require('yazi').setup()

