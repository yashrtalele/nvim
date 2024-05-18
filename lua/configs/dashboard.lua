local logo = [[
  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
[ @yashrtalele ]

]]

logo = string.rep("\n", 8) .. logo .. "\n\n"

-- local function open_project()
--   require("telescope.builtin").find_files {
--     cwd = vim.fn.expand("%:p:h"),
--     previewer = true,
--     prompt_title = "Open Project",
--   }
-- end

local function open_folder_with_nvim_tree()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local finders = require('telescope.finders')
  local pickers = require('telescope.pickers')
  local sorters = require('telescope.sorters')

  pickers.new({}, {
    prompt_title = "Select folder",
    finder = finders.new_oneshot_job({ 'fd', '-t', 'd', "--hidden", "--no-ignore", "--exclude", ".git" }, {
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    sorter = sorters.get_fuzzy_file(),
    attach_mappings = function(prompt_bufnr, map)
      local function open_in_nvim_tree()
      local selection = action_state.get_selected_entry()
      local folder_path = selection.value
      actions.close(prompt_bufnr)
      require('nvim-tree.api').tree.open(folder_path)
    end
      map('i', '<CR>', open_in_nvim_tree)
      map('n', '<CR>', open_in_nvim_tree)
      map('i', '<C-t>', function()
        local picker = action_state.get_current_picker(prompt_bufnr)
          if picker then
            local entry = picker:get_selection()
            local value = entry and entry.value
            if value then
              local exact_matches = {}
              for _, item in ipairs(picker.manager.sorter._original_entries) do
                if string.lower(item.display) == string.lower(value) then
                  table.insert(exact_matches, item)
                end
              end
              picker.manager.sorter.entries = exact_matches
              picker:refresh()
            end
          end
      end)
      return true
    end
    }):find()
end


local opts = {
  -- theme = "hyper",
  -- config = {
  --   shortcut = {
  --     {
  --       desc = "󰒲  Lazy",
  --       group = "@property",
  --       action = "Lazy",
  --       key = "l",
  --     },
  --     {
  --       desc = "  Files",
  --       group = "Number",
  --       action = "Telescope find_files",
  --       key = "f",
  --     },
  --     {
  --       desc = "  Config",
  --       group = "@property",
  --       action = "e $MYVIMRC",
  --       key = "c",
  --     },
  --     {
  --       desc = "  Search",
  --       group = "@property",
  --       action = "Telescope live_grep",
  --       key = "s",
  --     },
  --     {
  --       desc = "  Quit",
  --       group = "@property",
  --       action = "q",
  --       key = "q",
  --     },
  --   },
  --   project = {
  --     enable = true,
  --     limit = 3,
  --   },
  --   header = vim.split(logo, "\n"),
  --   mru = {
  --     limit = 5,
  --     truncate = {
  --       recent_files = true,
  --       files = true,
  --       folders = true,
  --     },
  --     icon = " ",
  --   },
  --   footer = function()
  --     return { "⚡ [ @yashrtalele ] " }
  --   end,
  -- },
  theme = "doom",
  hide = {
    statusline = false,
  },
  config = {
    header = vim.split(logo, "\n"),
    center = {
      { action = open_folder_with_nvim_tree, desc = " Open Project", icon = " ", key = "p" },
      { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
      { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
      { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
      { action = "Telescope live_grep", desc = "Find word", icon = "  ", key = "g" },
      { action = "e $MYVIMRC", desc = " Config", icon = " ", key = "c" },
      { action = "Lazy", desc = " Lazy", icon = " ", key = "l" },
      { action = "q", desc = " Quit", icon = " ", key = "q" },
    },
    footer = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return { "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms" }
    end,
  }
}

for _, button in ipairs(opts.config.center) do
  button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
  button.key_format = " %s"
end

if vim.o.filetype == "lazy" then
  vim.cmd.close()
  vim.api.nvim_create_autocmd("User", {
    pattern = "DashboardLoaded",
    callback = function()
      require("lazy").show()
  end
  })
end

require("dashboard").setup(opts)
