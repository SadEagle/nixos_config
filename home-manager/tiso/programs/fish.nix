{ ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''

      set -g fish_greeting
      # NOTE: vim deletion inside scope `di(` dont work, need to make ticket. Add ticket?
      set -g fish_key_bindings fish_vi_key_bindings
      set -gx EDITOR nvim
      set -gx TERMINAL kitty

      function fish_prompt
        set -l nix_shell_info (
          if test -n "$IN_NIX_SHELL"
            echo -n "<nix-shell>"
          end
        )
        echo -n (set_color cyan)$nix_shell_info (set_color green)$USER (set_color blue)(prompt_pwd) (set_color cyan)(fish_git_prompt '(%s)') (set_color blue)'❭ '
      end

      # FZF setup
      # FIX: "** + tab" dont call fzf because tabulation used by something else
      set -gx FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git'
      set -gx FZF_DEFAULT_OPTS '--bind=tab:down,shift-tab:up,enter:accept-non-empty,alt-enter:select
                              --multi --reverse --ignore-case --color header:italic --height=60%'
      set -gx FZF_CTRL_R_OPTS " --header 'Search command in history...'"
      set -gx FZF_CTRL_T_OPTS "
          --header 'Search file in current directory and add to cmd...'
          --preview 'bat --style=numbers --color=always --line-range :500 {}' --bind='ctrl-j:toggle-preview'"
      set -gx FZF_ALT_C_OPTS "
          --header 'Search and jump in directory...'"

      # Plugins connection
      zoxide init fish | source
      fzf --fish | source
    '';

    shellAliases = {
      lg = "lazygit";
      nv = "nvim";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
    functions = {
      # Redefine default prompt
      nix-shell = {
        description = "nix-shell with fish";
        body = "command nix-shell --run fish $argv";
      };
      y = {
        description = "cmd yazi";
        body = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
      fish_mode_prompt = {
        # Change mode to non-bold part
        body = ''
          if test "$fish_key_bindings" = fish_vi_key_bindings 
              or test "$fish_key_bindings" = fish_hybrid_key_bindings
              switch $fish_bind_mode
                  case default
                      set_color red
                      echo '[N]'
                  case insert
                      set_color green
                      echo '[I]'
                  case replace_one
                      set_color green
                      echo '[R]'
                  case replace
                      set_color cyan
                      echo '[R]'
                  case visual
                      set_color magenta
                      echo '[V]'
              end
              set_color normal
              echo -n ' '
          end
        '';

      };
    };
  };
}
