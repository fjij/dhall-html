let List/map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v23.1.0/Prelude/List/map.dhall
        sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v23.1.0/Prelude/Map/Type.dhall
        sha256:210c7a9eba71efbb0f7a66b3dcf8b9d3976ffc2bc0e907aadfb6aa29c333e8ed

let F = ./F.dhall

let HTML = ./Type.dhall

let element
    : Text → Map Text Text → List HTML → HTML
    = λ(name : Text) →
      λ(attrs : Map Text Text) →
      λ(children : List HTML) →
      λ(r : Type) →
      λ(frr : F r → r) →
        let fr =
              (F r).Element
                { name
                , attrs
                , children = List/map HTML r (λ(e : HTML) → e r frr) children
                }

        in  frr fr

in  element
