return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		require("dap-go").setup()

		local os_name = vim.loop.os_uname().sysname
		local debugpy_path

		if os_name == "Linux" then
			debugpy_path = "python3"
		elseif os_name == "Darwin" then
			debugpy_path = vim.fn.expand("~/.virtualenvs/debugpy/bin/python")
			if vim.fn.executable(debugpy_path) ~= 1 then
				vim.notify("Creating debugpy virtualenv...", vim.log.levels.INFO)
				os.execute("mkdir -p ~/.virtualenvs")
				os.execute("cd ~/.virtualenvs && python3 -m venv debugpy")
				os.execute("~/.virtualenvs/debugpy/bin/pip install debugpy")
			end
		else
			debugpy_path = "python3"
		end

		require("dap-python").setup(debugpy_path)

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Keymaps
		vim.keymap.set("n", "<space>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<space>dc", dap.continue, {})
		vim.keymap.set("n", "<space>do", dapui.toggle, {})
		vim.keymap.set("n", "<space>ds", dap.step_over, {})
		vim.keymap.set("n", "<space>di", dap.step_into, {})
		vim.keymap.set("n", "<space>du", dap.step_out, {})
	end,
}
