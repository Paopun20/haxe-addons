import re

from pygments.lexer import RegexLexer, bygroups, words  # type: ignore
from pygments.token import *  # type: ignore


class BetterHaxeLexer(RegexLexer):
    name = "Haxe"
    aliases = ["haxe"]
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
            # whitespace
            (r"\s+", Text),
            # comments
            (r"//.*?$", Comment.Single),
            (r"/\*", Comment.Multiline, "comment"),
            # compiler directives
            (r"#(if|elseif|else|end|error)\b", Comment.Preproc),
            # metadata
            (r"@:[A-Za-z_]\w*", Name.Decorator),
            # namespace keywords
            (r"\b(package|import|using)\b", Keyword.Namespace),
            # declarations (highest priority)
            (
                r"\b(class|interface|enum|typedef|abstract)" r"(\s+)([A-Z]\w*)",
                bygroups(Keyword, Text, Name.Class),
            ),
            (
                r"\b(function)(\s+)([A-Za-z_]\w*)",
                bygroups(Keyword, Text, Name.Function),
            ),
            # types
            # type after colon:
            # :Type
            (
                r"(:)(\s*)([A-Z]\w*)",
                bygroups(Punctuation, Text, Name.Class),
            ),
            # generic type name:
            # Type<
            (r"\b([A-Z]\w*)(?=\s*<)", Name.Class),
            # builtin types
            (words(types, suffix=r"\b"), Keyword.Type),
            # keywords
            (words(keywords, suffix=r"\b"), Keyword),
            # constants
            (r"\b[A-Z][A-Z0-9_]*\b", Name.Constant),
            # numbers
            (r"0x[0-9a-fA-F]+", Number.Hex),
            (r"\d+\.\d+([eE][+-]?\d+)?", Number.Float),
            (r"\d+[eE][+-]?\d+", Number.Float),
            (r"\d+", Number.Integer),
            # strings
            (r'"', String.Double, "string"),
            (r"'", String.Single),
            # generic brackets
            (r"[<>]", Punctuation),
            # identifiers
            (r"[A-Za-z_]\w*", Name),
            # operators
            (
                r"==|!=|<=|>=|=>|->|&&|\|\||<<|>>|>>>"
                r"|\+\+|--|\+=|-=|\*=|/=|%=|&=|\|=|\^=",
                Operator,
            ),
            (r"[+\-*/%=&|^~!?]", Operator),
            # punctuation
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
            (r'[^\\"$]+', String.Double),
            (r'[$\\"]', String.Double),
        ],
    }
