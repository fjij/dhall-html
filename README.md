# dhall-html

A [Dhall](https://dhall-lang.org/) library for constructing and rendering HTML.

## Usage

Import the package:

```dhall
let HTML = https://raw.githubusercontent.com/fjij/dhall-html/main/HTML/package.dhall
```

### Building HTML

Use `element` to create elements with attributes, and `textNode` for text content:

```dhall
let HTML = ./HTML/package.dhall

let page =
      HTML.element
        "html"
        (toMap {=} : List { mapKey : Text, mapValue : Text })
        [ HTML.element
            "head"
            (toMap {=} : List { mapKey : Text, mapValue : Text })
            [ HTML.element
                "title"
                (toMap {=} : List { mapKey : Text, mapValue : Text })
                [ HTML.textNode "My Page" ]
            ]
        , HTML.element
            "body"
            (toMap {=} : List { mapKey : Text, mapValue : Text })
            [ HTML.element
                "h1"
                (toMap {=} : List { mapKey : Text, mapValue : Text })
                [ HTML.textNode "Hello, World!" ]
            , HTML.element
                "a"
                (toMap { href = "https://example.com" })
                [ HTML.textNode "Click here" ]
            , HTML.element
                "br"
                (toMap {=} : List { mapKey : Text, mapValue : Text })
                ([] : List HTML.Type)
            ]
        ]

in  HTML.render 2 page
```

This produces:

```html
<html>
  <head>
    <title>
      My Page
    </title>
  </head>
  <body>
    <h1>
      Hello, World!
    </h1>
    <a href="https://example.com">
      Click here
    </a>
    <br />
  </body>
</html>
```

### API

| Export     | Type | Description |
|------------|------|-------------|
| `Type`     | `Type` | The HTML type |
| `element`  | `Text → Map Text Text → List HTML → HTML` | Create an element with a tag name, attributes, and children |
| `textNode` | `Text → HTML` | Create a text node |
| `render`   | `Natural → HTML → Text` | Render HTML to text with the given indentation width |
| `F`        | `Type → Type` | The base functor for the HTML type (for advanced use) |

### Notes

- Self-closing tags: elements with no children render as self-closing (e.g. `<br />`).
- Attributes: pass `(toMap {=} : List { mapKey : Text, mapValue : Text })` for no attributes, or `toMap { key = "value" }` for one or more.
- Indentation: the `Natural` argument to `render` controls the number of spaces per indent level.

## Development

### Prerequisites

- [Nix](https://nixos.org/) with flakes enabled

### Dev Shell

```sh
nix develop
```

### Formatting

```sh
nix fmt
```

### Running Tests

```sh
echo './HTML/tests.dhall' | dhall
```
