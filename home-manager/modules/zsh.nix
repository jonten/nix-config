{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nix-zsh-completions
    zsh-autosuggestions
    zsh-completions
    zsh-nix-shell
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    autocd = true;
		history.expireDuplicatesFirst = true;
		history.ignoreDups = true;
		history.ignorePatterns = [ "rm -rf *" "pkill *" "kill *" ];
		history.ignoreSpace = true;
    history.share = true;
    dotDir = ".config/zsh";
    initExtra = "export NIX_PATH=$NIX_PATH:$HOME/.nix-defexpr/channels\nexport PATH=$PATH:$HOME/bin\nbindkey -e";
    #completionInit = "autoload -U compinit && compinit";
    dirHashes = {
			docs  = "$HOME/Documents";
			dl    = "$HOME/Downloads";
			iso    = "$HOME/Downloads/iso";
			code    = "$HOME/code";
    };
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "v2.2.4";
          sha256 = "1smskx9vkx78yhwspjq2c5r5swh9fc5xxa40ib4753f00wk4dwpp";
        };
      }
    ];
    sessionVariables = {
      EDITOR = "vim";
    };
    shellAliases = {
      # Shell aliases
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      vi = "vim";
      vim = "spacevim";
      nvim = "spacevim";
      hm = "home-manager";
      hmg = "home-manager generations";
      hmh = "home-manager help";
      hmp = "home-manager packages";
      hms = "home-manager switch";
      hmsb = "home-manager switch -b backup";
      hmsu = "nix-channel --update home-manager && home-manager switch -b backup";

      # Kubernetes
      kc = "kubectl";
      kcc = "kubecolor";
      c = "kubectl config use-context";
      kn = "kubie ns";
      cx = "kubie ctx";

      # Git aliases
      gcl = "git clone";  
      ga = "git add";
      grm = "git rm";
      gap = "git add -p";
      gall = "git add -A";
      gf = "git fetch --all --prune";
      gft = "git fetch --all --prune --tags";
      gfv = "git fetch --all --prune --verbose";
      gftv = "git fetch --all --prune --tags --verbose";
      gus = "git reset HEAD";
      gpristine = "git reset --hard && git clean -dfx";
      gclean = "git clean -fd";
      gm = "git merge";
      gmv = "git mv";
      g = "git";
      get = "git";
      gs = "git status";
      gss = "git status -s";
      gsu = "git submodule update --init --recursive";
      gl = "git pull";
      gpl = "git pull";
      glum = "git pull upstream master";
      gpr = "git pull --rebase";
      gpp = "git pull && git push";
      gup = "git fetch && git rebase";
      gp = "git push";
      gpd = "git push --delete";
      gpo = "git push origin HEAD";
      gpu = "git push --set-upstream";
      gpuo = "git push --set-upstream origin";
      gpuoc = "git push --set-upstream origin $(git symbolic-ref --short HEAD)";
      gpom = "git push origin master";
      gr = "git remote";
      grv = "git remote -v";
      gra = "git remote add";
      grb = "git rebase";
      grem = "git rebase master";
      gremi = "git rebase master -i";
      gd = "git diff";
      gds = "git diff --staged";
      gdt = "git difftool";
      gdv = "git diff -w \"$@\" | vim -R -";
      gc = "git commit -v";
      gca = "git commit -v -a";
      gcm = "git commit -v -m";
      gcam = "git commit -v -am";
      gci = "git commit --interactive";
      gcamd = "git commit --amend";
      gb = "git branch";
      gba = "git branch -a";
      # FROM https://stackoverflow.com/a/58623139/10362396
      gbc = "git for-each-ref --format = \"%(authorname) %09 %(if)%(HEAD)%(then)*%(else)%(refname:short)%(end) %09 %(creatordate)\" refs/remotes/ --sort = authorname DESC";
      gbt = "git branch --track";
      gbm = "git branch -m";
      gbd = "git branch -d";
      gbD = "git branch -D";
      gcount = "git shortlog -sn";
      gcp = "git cherry-pick";
      gcpx = "git cherry-pick -x";
      gco = "git checkout";
      gcom = "git checkout master";
      gcb = "git checkout -b";
      gcob = "git checkout -b";
      gcobu = "git checkout -b \${USER}/";
      gct = "git checkout --track";
      gcpd = "git checkout master; git pull; git branch -D";
      gexport = "git archive --format zip --output";
      gdel = "git branch -D";
      gmu = "git fetch origin -v; git fetch upstream -v; git merge upstream/master";
      gll = "git log --graph --pretty=oneline --abbrev-commit";
      gg = "git log --graph --pretty=format:\"%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset\" --abbrev-commit --date=relative";
      ggf = "git log --graph --date=short --pretty=format:\"%C(auto)%h %Cgreen%an%Creset %Cblue%cd%Creset %C(auto)%d %s\"";
      ggs = "gg --stat";
      gsh = "git show";
      gsl = "git shortlog -sn";
      gwc = "git whatchanged";
      gt = "git tag";
      gta = "git tag -a";
      gtd = "git tag -d";
      gtl = "git tag -l";
      gpatch = "git format-patch -1";
      # From http://blogs.atlassian.com/2014/10/advanced-git-aliases/
      # Show commits since last pull
      gnew = "git log HEAD@{1}..HEAD@{0}";
      # Add uncommitted and unstaged changes to the last commit
      gcaa = "git commit -a --amend -C HEAD";
      # Rebase with latest remote master
      gprom = "git fetch origin master && git rebase origin/master && git update-ref refs/heads/master origin/master";
      gpf = "git push --force";
      gpunch = "git push --force-with-lease";
      ggui = "git gui";
      gcsam = "git commit -S -am";
      # Stash aliases
      gst = "git stash";
      gstb = "git stash branch";
      gstd = "git stash drop";
      gstl = "git stash list";
      # Push introduced in git v2.13.2
      gstpu = "git stash push";
      gstpum = "git stash push -m";
      # Save deprecated since git v2.16.0
      # - aliases now resolve to push
      gsts = "git stash push";
      gstsm = "git stash push -m";
      # Alias gstpo added for symmetry with gstpu (push)
      # - gstp remains as alias for pop due to long-standing usage
      gstpo = "git stash pop";
      gstp = "git stash pop";
      # Switch aliases - Requires git v2.23+
      gsw = "git switch";
      gswm = "git switch master";
      gswc = "git switch --create";
      gswt = "git switch --track";
      # Git home
      ghm = "cd \"$(git rev-parse --show-toplevel)\"";
      gh = "ghm";
      # Show untracked files
      gu = "git ls-files . --exclude-standard --others";
    }; 
  };
}
