return {
  'sudo-tee/opencode.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MeanderingProgrammer/render-markdown.nvim',
    'saghen/blink.cmp',
    'ibhagwan/fzf-lua'
  },
  opts = {
    preferred_picker = 'fzf',
    preferred_completion = 'blink',
  }
}
