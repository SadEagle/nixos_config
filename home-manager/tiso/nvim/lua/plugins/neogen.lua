return {
  "danymat/neogen",
  config = true,
  lazy = true,
  opts = {
    enables = true,
    snippet_engine = "nvim",

    languages = {
      lua = {
        template = {
          annotation_convention = "emmylua",
        }
      },
      python = {
        template = {
          annotation_convention = "google_docstrings",
        }
      },
    }
  },
  keys = {
    { "<F2>", function() require("neogen").generate() end, desc = "Generate doc" }
  }
}
