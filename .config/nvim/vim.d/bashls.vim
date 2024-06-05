" bash language server
" To install:
"   $ yarn global add bash-language-server
"   # dnf install shellcheck

lua<<EOF
    require'lspconfig'.bashls.setup{}
EOF
