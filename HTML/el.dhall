let HTML = ./Type.dhall

let element = ./element.dhall

let el
    : Text → List HTML → HTML
    = λ(name : Text) →
        element name (toMap {=} : List { mapKey : Text, mapValue : Text })

in  el
