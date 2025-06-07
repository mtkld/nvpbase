return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = false, -- Enable search mode or not. Interrupts my search.
      },
    },
  },
  -- stylua: ignore
  keys = {
    -- Jump by enter chars
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- Select by treesitter
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- Remote and go back, after pending operator
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- Remote and stay at remote, after pending operator
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
