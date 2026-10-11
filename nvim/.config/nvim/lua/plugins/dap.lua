return {
	"mfussenegger/nvim-dap",

	dependencies = {
		"mfussenegger/nvim-dap-python",
	},

	config = function()
		local dap = require("dap")

		-- C/C++ debugger: CodeLLDB
		local codelldb = vim.fn.exepath("codelldb")

		if codelldb ~= "" then
			dap.adapters.codelldb = {
				type = "executable",
				command = codelldb,
			}
		else
			vim.notify("Install codelldb with :MasonInstall codelldb", vim.log.levels.WARN)
		end

		local cpp_config = {
			{
				name = "Launch executable",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
			{
				name = "Attach to process",
				type = "codelldb",
				request = "attach",
				pid = require("dap.utils").pick_process,
			},
		}

		dap.configurations.cpp = cpp_config
		dap.configurations.c = cpp_config

		-- Python debugger: debugpy
		local debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"

		if vim.fn.executable(debugpy_python) == 1 then
			require("dap-python").setup(debugpy_python)
		else
			vim.notify("Install debugpy with :MasonInstall debugpy", vim.log.levels.WARN)
		end

		-- Keymaps
		local map = vim.keymap.set

		map("n", "<leader>dc", dap.continue, { desc = "Debug: Continue / Start" })

		map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

		map("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })

		map("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })

		map("n", "<leader>ds", dap.step_over, { desc = "Debug: Step Over" })

		map("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })

		map("n", "<leader>dr", dap.restart, { desc = "Debug: Restart" })

		map("n", "<leader>dR", dap.repl.open, { desc = "Debug: Open REPL" })

		-- Python test debugging
		map("n", "<leader>dm", function()
			require("dap-python").test_method()
		end, { desc = "Debug: Python Test Method" })
	end,
}
