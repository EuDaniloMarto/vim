-- Garante que este script só seja carregado uma vez por buffer.
if vim.b.did_ftplugin then
  return
end
vim.b.did_ftplugin = true

-- Define uma variável para reverter as opções se o filetype for alterado.
vim.b.undo_ftplugin = "setl sw< ts< et<"

-- ===============================================
-- 📐 Configurações de Indentação e Tabulação
-- ===============================================

-- Define a tabulação para 2 espaços, conforme solicitado.
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true -- Converte TABs em espaços, padrão para código.

-- ===============================================
-- 💻 Otimizações Específicas para Shell Script
-- ===============================================

-- Define o 'omnifunc' para utilizar a funcionalidade de completion nativa
-- (útil para completion de caminhos, comandos e variáveis, que é padrão no Neovim).
vim.opt_local.omnifunc = 'sh#complete'

-- O Neovim lida bem com a sintaxe de Shell Script. Não são necessárias
-- outras configurações complexas para esta linguagem no nível de ftplugin.
