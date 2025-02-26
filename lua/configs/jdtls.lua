local function get_jdtls_config()
  -- Store workspaces in CStuff folder
  local workspace_path = "C:\\Users\\pr0h3\\CStuff\\jdtls-workspaces\\"
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = workspace_path .. project_name

  local home = os.getenv "USERPROFILE"

  local config = {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      vim.fn.glob(
        home .. "\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\plugins\\org.eclipse.equinox.launcher_*.jar"
      ),
      "-configuration",
      home .. "\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\config_win",
      "-data",
      workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = "JavaSE-21",
              path = "C:\\Program Files\\Java\\jdk-21", -- Make sure this matches your JDK path
            },
          },
        },
      },
    },
  }

  config.on_attach = function(client, bufnr)
    if client.name == "jdtls" then
      require("dap").adapters.java = {
        type = "server",
        host = "127.0.0.1",
        port = 5005,
        executable = {
          command = "java",
          args = {
            "-jar",
            "C:\\Users\\pr0h3\\CStuff\\javaLspPlugin\\java-debug\\com.microsoft.java.debug.plugin\\target\\com.microsoft.java.debug.plugin-*.jar",
          },
        },
      }

      require("dap").configurations.java = {
        {
          type = "java",
          request = "launch",
          name = "Launch Java Program",
          mainClass = function()
            return vim.fn.input("Main Class: ", "", "file")
          end,
          projectName = "MyJavaProject",
          cwd = vim.fn.getcwd(),
        },
      }
    end
  end

  return config
end

local jdtls_augroup = vim.api.nvim_create_augroup("jdtls_config", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  group = jdtls_augroup,
  callback = function()
    local config = get_jdtls_config()
    require("jdtls").start_or_attach(config)
  end,
})
