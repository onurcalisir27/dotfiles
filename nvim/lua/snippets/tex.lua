local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  -- Fraction: type "//" to get \frac{}{}
  s({ trig = "//", snippetType = "autosnippet" }, {
    t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0)
  }),

  -- Equation environment
  s("eqn", {
    t({"\\begin{equation}", "\t"}),
    i(1),
    t({"", "\\end{equation}"}),
    i(0)
  }),

  -- Align environment
  s("ali", {
    t({"\\begin{align}", "\t"}),
    i(1),
    t({"", "\\end{align}"}),
    i(0)
  }),

  -- Figure
  s("fig", {
    t({"\\begin{figure}[htbp]", "\t\\centering", "\t\\includegraphics[width="}),
    i(1, "0.8"), t({"\\textwidth]{"}), i(2, "path"), t({"}", "\t\\caption{"}),
    i(3, "caption"), t({"}", "\t\\label{fig:"}), i(4, "label"),
    t({"}", "\\end{figure}"}), i(0)
  }),

  -- Itemize
  s("item", {
    t({"\\begin{itemize}", "\t\\item "}), i(1),
    t({"", "\\end{itemize}"}), i(0)
  }),

  -- Bold text
  s("bf", {
    t("\\textbf{"), i(1), t("}"), i(0)
  }),

  -- Italic text
  s("it", {
    t("\\textit{"), i(1), t("}"), i(0)
  }),

  -- Common math
  s({ trig = "sum", snippetType = "autosnippet" }, {
    t("\\sum_{"), i(1, "i=1"), t("}^{"), i(2, "n"), t("} "), i(0)
  }),

  s({ trig = "int", snippetType = "autosnippet" }, {
    t("\\int_{"), i(1, "a"), t("}^{"), i(2, "b"), t("} "), i(0)
  }),

  -- s({ trig="bmat", snippetType = })
}
