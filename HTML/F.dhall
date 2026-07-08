let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v23.1.0/Prelude/Map/Type.dhall
        sha256:210c7a9eba71efbb0f7a66b3dcf8b9d3976ffc2bc0e907aadfb6aa29c333e8ed

let F =
      λ(HTML : Type) →
        < TextNode : Text
        | Element : { name : Text, attrs : Map Text Text, children : List HTML }
        >

in  F
