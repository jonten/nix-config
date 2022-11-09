{ config, pkgs, ... }:
{
  home.file.".pre-commit-config.yaml".text = ''
# See https://pre-commit.com for more information
# See https://pre-commit.com/hooks.html for more hooks
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v3.2.0
    hooks:
    -   id: trailing-whitespace
    -   id: end-of-file-fixer
    -   id: check-yaml
    -   id: check-added-large-files
    -   id: check-executables-have-shebangs
    -   id: check-shebang-scripts-are-executable
    -   id: check-merge-conflict
    -   id: check-symlinks
    -   id: check-json
    -   id: pretty-format-json
    -   id: detect-aws-credentials
    -   id: detect-private-key
    -   id: fix-byte-order-marker
    -   id: mixed-line-ending
        stages: [push]
-   repo: local
    hooks:
    -   stages: [push]
	'';

  home.packages = [ pkgs.pre-commit ];
}
