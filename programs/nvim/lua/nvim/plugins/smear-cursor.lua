return {
  "smear-cursor.nvim",
  enable = "true",
  load = require("smear_cursor").setup({
    stiffness = 0.7, -- 0.6, [0, 1]
    trailing_stiffness = 0.5, -- 0.4, [0, 1]
    stiffness_insert_mode = 0.6, -- 0.4, [0, 1]
    trailing_stiffness_insert_mode = 0.6, -- 0.4, [0, 1]
    distance_stop_animating = 0.5, -- 0.1, > 0
  }),
}
