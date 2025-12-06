-- --- INICIO DO INIT.LUA --- --

-- --- Autor: Danilo Marto de Carvalho <carvalho.dm@proton.me>
-- --- Descrição: Configuração Neovim com o essencial e LSP nativo.

-- ==============================================================================
-- 🧠 Configuração do LSP NATIVO (vim.lsp)
-- ==============================================================================

-- 1. Definição das Funções de Auxílio do LSP

-- Funções que serão executadas ao anexar um LSP a um buffer
local on_attach = function(client, bufnr)
  -- Formatação no salvamento (se o servidor suportar)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", {}),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })
  end

  -- Mapeamentos de Teclas Específicos do LSP
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  map("n", "gD", vim.lsp.buf.declaration, opts)            -- Ir para declaração
  map("n", "gd", vim.lsp.buf.definition, opts)             -- Ir para definição
  map("n", "K", vim.lsp.buf.hover, opts)                   -- Informações ao passar o mouse
  map("n", "gi", vim.lsp.buf.implementation, opts)         -- Ir para implementação
  map("n", "<Leader>rn", vim.lsp.buf.rename, opts)         -- Renomear
  map("n", "<Leader>ca", vim.lsp.buf.code_action, opts)    -- Ação de código
  map("n", "gr", vim.lsp.buf.references, opts)             -- Referências
  map("n", "[d", vim.diagnostic.goto_prev, opts)           -- Ir para diagnóstico anterior
  map("n", "]d", vim.diagnostic.goto_next, opts)           -- Ir para próximo diagnóstico
  map("n", "<Leader>e", vim.diagnostic.open_float, opts)   -- Mostrar diagnóstico em float
end

-- 2. Configuração Manual dos Servidores LSP

local lsp_servers = {
  -- PYRIGHT para Python
  python = {
    cmd = { "pyright-langserver", "--stdio" },
    on_attach = on_attach,
    root_dir = vim.fs.dirname(vim.fs.find({ "pyproject.toml", "setup.py", "setup.cfg", ".git" }, { upward = true })[1] or vim.fn.getcwd()),
  },

  -- CLANGD para C/C++
  c = {
    cmd = { "clangd" },
    on_attach = on_attach,
  },
  cpp = {
    cmd = { "clangd" },
    on_attach = on_attach,
  },

  -- GOPLS para Go
  go = {
    cmd = { "gopls" },
    on_attach = on_attach,
  },

  -- RUST_ANALYZER para Rust
  rust = {
    cmd = { "rust-analyzer" },
    on_attach = on_attach,
  },

  -- HTML Language Server
  html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    on_attach = on_attach,
  },

  -- CSS/LESS/SCSS Language Server
  css = {
    cmd = { "vscode-css-language-server", "--stdio" },
    on_attach = on_attach,
  },
  less = {
    cmd = { "vscode-css-language-server", "--stdio" },
    on_attach = on_attach,
  },
  scss = {
    cmd = { "vscode-css-language-server", "--stdio" },
    on_attach = on_attach,
  },

  -- TypeScript Language Server (para JavaScript e TypeScript)
  javascript = {
    cmd = { "typescript-language-server", "--stdio" },
    on_attach = on_attach,
  },
  typescript = {
    cmd = { "typescript-language-server", "--stdio" },
    on_attach = on_attach,
  },
}

-- 3. AutoComand para Iniciar o LSP

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("LspManualStart", { clear = true }),
  callback = function(args)
    local config = lsp_servers[args.match]
    if config then
      config.name = args.match
      config.capabilities = vim.lsp.protocol.make_client_capabilities()
      vim.lsp.start(config)
    end
  end,
})

-- ==============================================================================
-- ⚙️ Opções Gerais (vim.opt)
-- ==============================================================================

-- Ativa o suporte a plugins, indentação e tipos de arquivo
vim.cmd.filetype({ "plugin", "indent", "on" })

-- Configurações gerais de edição
vim.opt.backup = false        -- CORRIGIDO: nobackup -> backup = false
vim.opt.swapfile = false      -- CORRIGIDO: noswapfile -> swapfile = false
vim.opt.history = 256
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.wildmenu = true
vim.opt.wrap = false          -- CORRIGIDO: nowrap -> wrap = false

-- Configurações de tabulação e indentação
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Configurações de busca
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ==============================================================================
-- ✨ Aparência (vim.opt)
-- ==============================================================================

-- Ativa a sintaxe e define o esquema de cores
vim.cmd.syntax("on")
vim.cmd.colorscheme("default")

-- Configurações da interface
vim.opt.cmdheight = 2
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.scrolloff = 3
vim.opt.laststatus = 2

-- Configurações de divisão de janelas
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Configurações de títulos
vim.opt.title = true
vim.opt.titleold = "Terminal"
vim.opt.titlestring = "%F"

-- Configurações de modeline
vim.opt.modeline = true
vim.opt.modelines = 10

-- Ignora arquivos e diretórios específicos
vim.opt.wildignore:append({
  "*/tmp/*",
  "*.so",
  "*.swp",
  "*.zip",
  "*.pyc",
  "*.db",
  "*.sqlite",
  "*node_modules/",
  "*.o",
  "*.obj",
  ".git",
  "*.rbc",
  "__pycache__",
})

-- ==============================================================================
-- ⌨️ Mapeamentos Essenciais (vim.keymap)
-- ==============================================================================

local opts = { noremap = true, silent = true }
local nmap = vim.keymap.set
local vmap = vim.keymap.set

-- Define o líder do mapeamento
vim.g.mapleader = ","

-- Mapeamentos para divisão de janelas
nmap("n", "<Leader>h", ":<C-u>split<CR>", opts)
nmap("n", "<Leader>v", ":<C-u>vsplit<CR>", opts)

-- Navegação entre buffers
nmap("n", "<Leader>q", ":bp<CR>", opts)
nmap("n", "<Leader>w", ":bn<CR>", opts)
nmap("n", "<Leader>c", ":bd<CR>", opts)

-- Navegação entre janelas (Ctrl+H/J/K/L)
nmap("n", "<C-j>", "<C-w>j", {})
nmap("n", "<C-k>", "<C-w>k", {})
nmap("n", "<C-l>", "<C-w>l", {})
nmap("n", "<C-h>", "<C-w>h", {})

-- Navegação entre abas
nmap("n", "<Tab>", "gt", {})
nmap("n", "<S-Tab>", "gT", {})
nmap("n", "<leader><Tab>", ":tabnew<CR>", {})

-- Limpa a pesquisa visualmente
nmap("n", "<leader><space>", ":noh<cr>", opts)

-- Manter seleção ao recuar ou avançar no modo visual
vmap("v", "<", "<gv", opts)
vmap("v", ">", ">gv", opts)

-- ==============================================================================
-- 💬 Abreviações e Comandos
-- ==============================================================================

-- Abreviações de comandos na linha de comando
vim.cmd.cnoreabbrev("W!", "w!")
vim.cmd.cnoreabbrev("Q!", "q!")
vim.cmd.cnoreabbrev("Qall!", "qall!")
vim.cmd.cnoreabbrev("Wq", "wq")
vim.cmd.cnoreabbrev("Wa", "wa")
vim.cmd.cnoreabbrev("wQ", "wq")
vim.cmd.cnoreabbrev("WQ", "wq")
vim.cmd.cnoreabbrev("W", "w")
vim.cmd.cnoreabbrev("Q", "q")
vim.cmd.cnoreabbrev("Qall", "qall")

-- Comando para remover espaços em branco ao final de cada linha
vim.cmd([[command! FixWhitespace :%s/\s\+$//e]])

-- ==============================================================================
-- 🤖 Auto Comandos (vim.api.nvim_create_autocmd)
-- ==============================================================================

-- Função de quebra de linha (setupWrapping)
local setupWrapping = function()
  vim.opt.wrap = true
  vim.opt.wm = 2
  vim.opt.textwidth = 79
end

-- Lembra a posição do cursor ao reabrir arquivos
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("vimrc-remember-cursor-position", { clear = true }),
  callback = function()
    local mark = vim.fn.line("'\"")
    if mark > 1 and mark <= vim.fn.line("$") then
      vim.cmd.execute("normal! g`\"")
    end
  end,
})

-- Configuração de quebra de linha automática para arquivos de texto (.txt)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("vimrc-wrapping", { clear = true }),
  pattern = "*.txt",
  callback = setupWrapping,
})

-- --- FIM DO INIT.LUA --- --
