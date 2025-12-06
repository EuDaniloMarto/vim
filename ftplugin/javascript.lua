-- Garante que este script só seja carregado uma vez por buffer.
if vim.b.did_ftplugin then
  return
end
vim.b.did_ftplugin = true

-- ===============================================
-- 📐 Configurações de Indentação e Tabulação
-- ===============================================

-- Define a tabulação para 2 espaços
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true -- Garante que TABs sejam convertidos em espaços

-- ===============================================
-- 💻 Otimizações Específicas para JavaScript/TS
-- ===============================================

-- 1. Remoção de Configurações Legadas
-- O Neovim utiliza Tree-sitter e LSP (TypeScript Language Server)
-- para gerenciar a sintaxe e a integração DOM/HTML/CSS.
-- As opções 'g:javascript_enable_domhtmlcss' e configurações de ALE são desnecessárias.

-- 2. Opções de Indentação C-Style
-- Configura 'smartindent' específico para linguagens C-style (como JS/TS) para
-- melhor detecção de blocos de código ({...}).
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true

-- 3. Configurações Específicas para JS/TS
-- Define a quebra de linha (textwidth) como 80 para JS/TS (pode ser ajustado)
vim.opt_local.textwidth = 80
vim.opt_local.wrap = true

-- 4. Melhoria na formatação de comentários
-- Ajusta a formatação automática para lidar corretamente com '//' e '/*' */
vim.opt_local.comments = "s1:/*,mb:*,ex:*/,://,b:#"

-- 5. Configurações de Completion (Com o LSP ativado no init.lua)
-- Garante que o buffer use o sistema de tags para autocompletar palavras.
vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
