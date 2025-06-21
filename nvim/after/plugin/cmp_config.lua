local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- Check if lspkind is available
local has_lspkind, lspkind = pcall(require, 'lspkind')

-- Helper function for super-tab functionality (from NvimDocs)
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_config = {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({
            winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpCursorLine,Search:None",
            scrollbar = true,
        }),
        documentation = cmp.config.window.bordered({
            winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder,CursorLine:CmpDocCursorLine,Search:None",
            scrollbar = true,
        }),
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        -- Add explicit insert mapping to insert selected item with Tab when menu is visible
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                -- Only navigate in the completion menu without inserting
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                -- Use the default tab behavior
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' })
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip',  priority = 750 },
        { name = 'buffer',   priority = 500 },
        { name = 'path',     priority = 200 },
    }),
    experimental = {
        ghost_text = true,
    },
}

-- Add additional sources if they exist
-- local has_nvim_lua, _ = pcall(require, 'cmp_nvim_lua')
-- local has_buffer, _ = pcall(require, 'cmp_buffer')
-- local has_path, _ = pcall(require, 'cmp_path')
-- local has_cmdline, _ = pcall(require, 'cmp_cmdline')
-- -- local has_signature_help, _ = pcall(require, 'cmp_nvim_lsp_signature_help') -- intentionally not used

-- local sources = cmp_config.sources
-- -- if has_nvim_lua then table.insert(sources, { name = 'nvim_lua', priority = 500 }) end
-- -- -- if has_signature_help then table.insert(sources, { name = 'nvim_lsp_signature_help', priority = 300 }) end
-- -- if has_buffer then table.insert(sources, { name = 'buffer', priority = 249 }) end
-- -- if has_path then table.insert(sources, { name = 'path', priority = 200 }) end

-- Add lspkind formatting if available
if has_lspkind then
    cmp_config.formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                nvim_lua = "[Lua]",
                path = "[Path]",
                nvim_lsp_signature_help = "[Signature]",
            },
        }),
    }
end

-- Define highlight groups for cmp window if not already set by colorscheme
vim.api.nvim_set_hl(0, "CmpNormal", { link = "Pmenu", default = true })
vim.api.nvim_set_hl(0, "CmpBorder", { link = "Pmenu", default = true })
vim.api.nvim_set_hl(0, "CmpCursorLine", { link = "PmenuSel", default = true })
vim.api.nvim_set_hl(0, "CmpDocNormal", { link = "NormalFloat", default = true })
vim.api.nvim_set_hl(0, "CmpDocBorder", { link = "FloatBorder", default = true })
vim.api.nvim_set_hl(0, "CmpDocCursorLine", { link = "Visual", default = true })

cmp.setup(cmp_config)

-- Dynamically disable cmp ghost_text when menu opens, re-enable when closed
local ghost_text_enabled = true
cmp.event:on('menu_opened', function()
    if cmp_config.experimental.ghost_text then
        ghost_text_enabled = true
        cmp_config.experimental.ghost_text = false
        cmp.setup(cmp_config)
    end
end)
cmp.event:on('menu_closed', function()
    if ghost_text_enabled then
        cmp_config.experimental.ghost_text = true
        cmp.setup(cmp_config)
    end
end)

-- Use buffer source for `/` and `?` (if available)
if has_buffer and has_cmdline then
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })
end

-- Use cmdline & path source for ':' (if available)
if has_cmdline and has_path then
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
end
