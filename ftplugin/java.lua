local on_attach = require("config.on_attach")

-- Define lombok path
local lombok_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. project_name

local config = {
	cmd = {
		"java",
		"-javaagent:" .. lombok_path,
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
		vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_mac",
		"-data",
		workspace_dir,
	},
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
	on_attach = on_attach,
}

vim.opt.shiftwidth = 2 -- to be aligned with the team

require("jdtls").start_or_attach(config)
