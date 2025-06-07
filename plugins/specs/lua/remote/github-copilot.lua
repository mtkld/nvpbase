return {
  {
    --    'github/copilot.vim',
    --    copied and modified default config from https://github.com/zbirenbaum/copilot.lua
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot', -- Allows the plugin to be lazy-loaded on the `Copilot` command.
    event = 'InsertEnter', -- Alternatively, it triggers on `InsertEnter`, which means it loads when entering insert mode.
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            --accept = '<M-l>',
            accept = '<A-Tab>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          --          yaml = false,
          --          markdown = false,
          --          help = false,
          --          gitcommit = false,
          --          gitrebase = false,
          --          hgcommit = false,
          --          svn = false,
          --          cvs = false,
          --          ['.'] = false,
          ['*'] = true,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      }
    end,
  },
}
