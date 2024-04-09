-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


-- Change Theme to catppuccin mocha
lvim.plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
},

}
lvim.colorscheme = "catppuccin-mocha"

-- Map "<leader> + g" to jump to a line number
lvim.keys.normal_mode["<Leader>g"] = [[:lua GoToLine()<CR>]]

function GoToLine()
    local lnum = vim.fn.input(": ")
    vim.cmd("normal " .. lnum .. "G")
end

