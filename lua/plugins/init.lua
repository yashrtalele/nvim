return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server", "stylua",
        "jdtls", "java-debug-adapter",
        "css-lsp", "html-lsp", "typescript-language-server", "deno", "prettier", "js-debug-adapter", "tailwindcss-language-server",
        "clangd", "clang-format", "codelldb", "shfmt",
      }
    }
  },
  {
    'Exafunction/codeium.vim',
    config = function ()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end,
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "markdown",
        "markdown_inline",
        "bash",
        "json",
        "jsonc",
        "dockerfile",
      },
      indent = {
        enable = true
      },
    },
  },

  -- UI
  -- DASHBOARD
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require "configs.dashboard"
    end,
  },
  {
    "MunifTanjim/nui.nvim",
  },
  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  -- },
  --
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
