local ls = require("luasnip")
local snip = ls.snippet
-- local func = ls.function_node
--
ls.filetype_extend("typescript", {"javascript"})

-- local date = function() return {os.date('%Y-%m-%d')} end
--
-- ls.add_snippets(nil, {
--     all = {
--         snip({
--             trig = "date",
--             namr = "Date",
--             dscr = "Date in the form of YYYY-MM-DD",
--         }, {
--             func(date, {}),
--         }),
--     },
-- })
