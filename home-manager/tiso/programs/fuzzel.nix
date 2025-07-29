{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=8";
        # FIX: no spaces
        prompt = "' ❭ '";
        width = 42;
        anchor = "center";
        line-height = 10;
      };

      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        prompt = "bac2deff";
        placeholder = "7f849cff";
        input = "cdd6f4ff";
        match = "89b4faff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "89b4faff";
        counter = "7f849cff";
        border = "89b4faff";
      };
      border = {
        width = 2;
        radius = 8;
      };
    };
  };
}
