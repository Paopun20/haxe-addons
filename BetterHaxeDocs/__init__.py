import re
from pygments.lexer import RegexLexer, bygroups, words  # type: ignore
from pygments.token import *  # type: ignore


class BetterHaxeLexer(RegexLexer):
    name = "Haxe"
    aliases = ["haxe", "haxe-addons"]
    filenames = ["*.hx"]

    flags = re.MULTILINE | re.DOTALL

    keywords = (
        "abstract",
        "break",
        "case",
        "cast",
        "catch",
        "class",
        "continue",
        "default",
        "do",
        "dynamic",
        "else",
        "enum",
        "extern",
        "extends",
        "false",
        "final",
        "for",
        "function",
        "if",
        "implements",
        "import",
        "in",
        "inline",
        "interface",
        "macro",
        "new",
        "null",
        "operator",
        "override",
        "package",
        "private",
        "public",
        "return",
        "static",
        "super",
        "switch",
        "this",
        "throw",
        "trace",
        "true",
        "try",
        "typedef",
        "untyped",
        "using",
        "var",
        "while",
    )

    types = (
        "Int",
        "Float",
        "Bool",
        "String",
        "Dynamic",
        "Void",
        "Array",
        "Map",
        "Vector",
        "Null",
    )

    tokens = {
        "root": [
            (r"\s+", Text),
            (r"//.*?$", Comment.Single),
            (r"/\*", Comment.Multiline, "comment"),
            (r"#(if|elseif|else|end|error)\b", Comment.Preproc),
            (r"@:[A-Za-z_]\w*", Name.Decorator),
            (r"\b(package|import|using)\b", Keyword.Namespace),
            # Declarations
            (
                r"\b(class|interface|enum|typedef|abstract)\b(\s+)([A-Z]\w*)",
                bygroups(Keyword, Text, Name.Class),
            ),
            (
                r"\b(function)\b(\s+)([A-Za-z_]\w*)",
                bygroups(Keyword, Text, Name.Function),
            ),
            # NEW: instantiation and inheritance contexts (Fixes "new SimpleThreadPool")
            (
                r"\b(new|extends|implements)\b(\s+)([A-Z]\w*)",
                bygroups(Keyword, Text, Name.Class),
            ),
            # Types
            (r"(:)(\s*)([A-Z]\w*)", bygroups(Punctuation, Text, Name.Class)),
            (r"\b([A-Z]\w*)(?=\s*<)", Name.Class),
            # Builtin types & keywords
            (words(types, suffix=r"\b"), Keyword.Type),
            (words(keywords, suffix=r"\b"), Keyword),
            # Constants (strictly ALL CAPS, at least 2 chars)
            (r"\b[A-Z]{2,}[A-Z0-9_]*\b", Name.Constant),
            # Numbers
            (r"0x[0-9a-fA-F]+", Number.Hex),
            (r"\d+\.\d+([eE][+-]?\d+)?", Number.Float),
            (r"\d+[eE][+-]?\d+", Number.Float),
            (r"\d+", Number.Integer),
            # Strings
            (r'"', String.Double, "string"),
            (r"'", String.Single),
            # Generic brackets & identifiers
            (r"[<>]", Punctuation),
            (r"[A-Za-z_]\w*", Name),
            # Operators & Punctuation
            (
                r"==|!=|<=|>=|=>|->|&&|\|\||<<|>>|>>>|\+\+|--|\+=|-=|\*=|/=|%=|&=|\|=|\^=",
                Operator,
            ),
            (r"[+\-*/%=&|^~!?]", Operator),
            (r"[{}\[\]();:,.]", Punctuation),
        ],
        "comment": [
            (r"[^*/]+", Comment.Multiline),
            (r"/\*", Comment.Multiline, "#push"),
            (r"\*/", Comment.Multiline, "#pop"),
            (r"[*/]", Comment.Multiline),
        ],
        "string": [
            (r"\\.", String.Escape),
            (r"\$\{[^}]+\}", String.Interpol),
            (r"\$[A-Za-z_]\w*", String.Interpol),
            (r'"', String.Double, "#pop"),
            (r'[^"\\$]+', String.Double),
            (r"[$\\]", String.Double),
        ],
    }
