-- Garante que este script só seja carregado uma vez por buffer.
if vim.b.did_ftplugin then
  return
end
vim.b.did_ftplugin = true

-- Define a prioridade para o 'filetype' para evitar que configurações de outros plugins
-- (como o LSP) substituam estas, garantindo que o Ruff seja usado se disponível.
vim.b.undo_ftplugin = "setl sw< ts< et< | au! BufWritePre <buffer>"

-- ===============================================
-- 📐 Configurações de Indentação e Tabulação
-- ===============================================

-- Python usa 4 espaços (PEP 8)
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true -- Garante que TABs sejam convertidos em espaços

-- Configurações padrão de indentação para linguagens C-style (útil para Python)
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true

-- ===============================================
-- 🛠️ Integração Direta com Ruff (Substituindo ALE)
-- ===============================================

-- Cria um comando de formatação para o buffer atual que executa o Ruff.
-- Ruff é extremamente rápido, por isso pode ser chamado diretamente.
-- O Neovim utiliza o sistema de formatação nativo do LSP primeiro.
-- Se você quiser garantir que o Ruff seja o formatador principal,
-- você pode usar este Autocmd para forçar a formatação antes de salvar.

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("RuffFormat", { clear = true }),
  buffer = vim.api.nvim_get_current_buf(),
  -- Verifica se o Ruff está instalado antes de tentar executar
  command = 'if executable("ruff") | silent execute "!ruff check --fix --exit-code 0 " . shellescape(expand("<afile>")) | endif',
  desc = "Formata com Ruff antes de salvar (Python)",
})

-- ===============================================
-- 💡 Otimizações Gerais
-- ===============================================

-- Define o 'omnifunc' para usar a funcionalidade de completion do LSP (pyright)
vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- Ajusta a quebra de linha para 88 (padrão Black/Ruff)
vim.opt_local.textwidth = 88
vim.opt_local.wrap = true
