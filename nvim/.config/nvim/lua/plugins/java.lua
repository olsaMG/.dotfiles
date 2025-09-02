return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        local jdtls = require("jdtls")

        -- Basic project setup
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name
        local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })

        local config = {
          cmd = { "jdtls", "-data", workspace_dir },
          root_dir = root_dir,

          settings = {
            java = {
              maven = { downloadSources = true },
              eclipse = { downloadSources = true },
              references = { includeDecompiledSources = true },
              contentProvider = { preferred = "fernflower" },
              configuration = { updateBuildConfiguration = "automatic" },
            }
          },

          init_options = {
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
          },

          -- Use your existing keymaps - no need to override
          on_attach = function(client, bufnr)
            -- Just enable JDTLS-specific features
            require("jdtls.setup").add_commands()

            -- Optional: Add a few Java-specific commands if you want
            -- vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, { buffer = bufnr, desc = "Organize imports" })
          end,
        }

        jdtls.start_or_attach(config)
      end,
    })
  end,
}
