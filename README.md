# dhall-html

A [Dhall](https://dhall-lang.org/) library for constructing and rendering HTML.

## Usage

Import the package:

```dhall
let HTML = https://raw.githubusercontent.com/fjij/dhall-html/main/HTML/package.dhall
```

### Building HTML

Use `el` to create elements and `text` for text content:

```dhall
let HTML = ./HTML/package.dhall

let page =
      HTML.el
        "html"
        [ HTML.el "head" [ HTML.el "title" [ HTML.text "My Page" ] ]
        , HTML.el
            "body"
            [ HTML.el "h1" [ HTML.text "Hello, World!" ]
            , HTML.element
                "a"
                (toMap { href = "https://example.com" })
                [ HTML.text "Click here" ]
            , HTML.el "br" ([] : List HTML.Type)
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

When you need attributes, use `element` with an attribute map:

```dhall
let HTML = ./HTML/package.dhall

in  HTML.element
      "input"
      (toMap { type = "text", placeholder = "Enter name" })
      ([] : List HTML.Type)
```

### API

| Export     | Type | Description |
|------------|------|-------------|
| `Type`     | `Type` | The HTML type |
| `Attrs`    | `Type` | The attributes type (`List { mapKey : Text, mapValue : Text }`) |
| `el`       | `Text → List HTML → HTML` | Create an element with no attributes |
| `element`  | `Text → Attrs → List HTML → HTML` | Create an element with attributes |
| `text`     | `Text → HTML` | Create a text node |
| `render`   | `Natural → HTML → Text` | Render HTML to text with the given indentation width |
| `F`        | `Type → Type` | The base functor for the HTML type (for advanced use) |

### Notes

- Self-closing tags: elements with no children render as self-closing (e.g. `<br />`).
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
dhall <<< './HTML/tests.dhall'
```
