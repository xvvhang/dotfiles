return {
  'sudo-tee/opencode.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'saghen/blink.cmp',
    'ibhagwan/fzf-lua'
   },
   opts = {
     ui = {
       window_highlight = 'Pmenu:OpencodeBackground,FloatBorder:OpencodeBorder',
       icons = {
         preset = 'text',
         overrides = {
           header_user = '',
           header_assistant = '󱙺',
           run = '',
           task = '',
           read = '',
           edit = '',
           write = '',
           plan = '',
           search = '',
           web = '',
           list = '',
           tool = '',
           snapshot = '',
           restore_point = '',
           restore_count = '',
           file = '',
           status_on = '',
           status_off = '',
           border = '│',
           bullet = '•',
         },
       },
       input = {
         text = {
           wrap = true
         }
       }
     }
   },
   config = function(_, opts)
     require('opencode').setup(opts)
   end,
   lazy = false
 }
