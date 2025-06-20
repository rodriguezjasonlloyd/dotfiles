return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {},
            },
            { "williamboman/mason.nvim" },
            { "jay-babu/mason-nvim-dap.nvim", event = "VeryLazy", opts = {} },
        },

        keys = {
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "Breakpoint Condition",
            },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle Breakpoint",
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Run/Continue",
            },
            {
                "<leader>da",
                function()
                    require("dap").continue({ before = get_args })
                end,
                desc = "Run with Args",
            },
            {
                "<leader>dC",
                function()
                    require("dap").run_to_cursor()
                end,
                desc = "Run to Cursor",
            },
            {
                "<leader>dg",
                function()
                    require("dap").goto_()
                end,
                desc = "Go to Line (No Execute)",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "Step Into",
            },
            {
                "<leader>dj",
                function()
                    require("dap").down()
                end,
                desc = "Down",
            },
            {
                "<leader>dk",
                function()
                    require("dap").up()
                end,
                desc = "Up",
            },
            {
                "<leader>dl",
                function()
                    require("dap").run_last()
                end,
                desc = "Run Last",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out",
            },
            {
                "<leader>dO",
                function()
                    require("dap").step_over()
                end,
                desc = "Step Over",
            },
            {
                "<leader>dP",
                function()
                    require("dap").pause()
                end,
                desc = "Pause",
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl.toggle()
                end,
                desc = "Toggle REPL",
            },
            {
                "<leader>ds",
                function()
                    require("dap").session()
                end,
                desc = "Session",
            },
            {
                "<leader>dt",
                function()
                    require("dap").terminate()
                end,
                desc = "Terminate",
            },
            {
                "<leader>dw",
                function()
                    require("dap.ui.widgets").hover()
                end,
                desc = "Widgets",
            },
        },
        config = function()
            require("dap")
            require("dapui").setup()
            require("nvim-dap-virtual-text").setup({})

            if package.loaded["mason-nvim-dap"] then
                require("mason-nvim-dap").setup()
            end

            vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("DapLogPoint", { text = "🔍", texthl = "DiagnosticWarn" })

            vim.api.nvim_set_hl(0, "DapStoppedLine", { link = "Visual", default = true })

            local vscode = require("dap.ext.vscode")
            local plenary_json = require("plenary.json")
            vscode.json_decode = function(str)
                return vim.json.decode(plenary_json.json_strip_comments(str))
            end
        end,
    },
}
