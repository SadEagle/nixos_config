{...}:
{
  programs.ruff = {
    enable = true;
    settings = {
      format = {
        docstring-code-format = true;
      };
      lint = {
        select = "ALL";
      };
      tool.ruff.lint.pydocstyle = "google";
    };
  };
}
