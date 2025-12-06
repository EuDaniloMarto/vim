-- Garante que este script só seja carregado uma vez por buffer.
if vim.b.did_ftplugin then
  return
end
vim.b.did_ftplugin = true

-- ===============================================
-- 📐 Configurações de Indentação e Tabulação
-- ===============================================

-- Define que um TAB e a largura de indentação são de 2 espaços
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true -- Garante que TABs sejam convertidos em espaços

-- ===============================================
-- 💻 Otimizações Específicas para HTML/Web
-- ===============================================

-- 1. Detecção de Sintaxe
-- Tenta detectar sintaxes incorporadas (embedded), como CSS ou JS dentro de <style> ou <script>.
vim.opt_local.syntax = "on"
vim.opt_local.iskeyword:append("-") -- Útil para nomes de classes e IDs com hífens

-- 2. Correção de quebra de linha (Text Wrapping)
-- Garante que o texto não quebre no meio de tags longas.
vim.opt_local.textwidth = 0
vim.opt_local.wrapmargin = 0
vim.opt_local.wrap = false

-- 3. Melhoria na formatação automática (smartindent)
-- Adiciona tags HTML à lista de 'autoindent' para melhor comportamento ao pressionar ENTER.
vim.opt_local.cinkeys:append("0{,0},0),0],!,<")
vim.opt_local.cinwords:append("if,else,while,do,for,switch,case,default")
