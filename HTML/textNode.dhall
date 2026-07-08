let F = ./F.dhall

let HTML = ./Type.dhall

let textNode
    : Text → HTML
    = λ(t : Text) → λ(r : Type) → λ(frr : F r → r) → frr ((F r).TextNode t)

in  textNode
