return {
    "nvim-treesitter/nvim-treesitter-context",
    main = "treesitter-context",
    -- TODO: formultiline_threshold > 1
    -- 1. Skip empty lines inside comtext
    -- 2. Add python specific rule
    opts = {
        mode = "topline",
        multiwindow = true,
        multiline_threshold = 1,
    },
}
