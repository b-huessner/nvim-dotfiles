return {
  {
    "vimwiki/vimwiki",
    keys = {
      {
        "<leader>WW",
        ":VimwikiIndex<CR>",
        desc = "Open VimWiki Index"
      }
    }
  },
  {
    "ElPiloto/telescope-vimwiki.nvim",
    keys = {
      {
        "<leader>fw",
        ":Telescope vimwiki<CR>",
        desc = "Search vimwiki files"
      },
      {
        "<leader>fW",
        ":Telescope vimwiki live_grep<CR>",
        desc = "Search inside vimwiki files"
      }
    },
    config = function()
      require("telescope").load_extension("vimwiki")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    keys = {
      {
        "<leader>WT",
        ":MarkdownPreview<CR>",
        desc = "Open VimWiki Markdown Preview"
      }
    },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    build = function()
      vim.fn["mkdp#util#install"]()
    end
  }
}
