local dap = require("dap")
dap.adapters.lldv = {
  type = "executable",
  command = "/usr/bin/lldb", -- adjust as needed, must be absolute path
  name = "lldb",
}
dap.configurations.cpp ={
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function ()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local js_based_languages = {
  "typescript",
  "javascript",
  "javascriptreact",
  "typescriptreact",
  "vue",
}

for _, language in ipairs(js_based_languages) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}"
    }
  }
end
