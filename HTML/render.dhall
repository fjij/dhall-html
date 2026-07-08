let List/map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v23.1.0/Prelude/List/map.dhall
        sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let Text/concatSep =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v23.1.0/Prelude/Text/concatSep.dhall
        sha256:e4401d69918c61b92a4c0288f7d60a6560ca99726138ed8ebc58dca2cd205e58

let Text/spaces =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v23.1.0/Prelude/Text/spaces.dhall
        sha256:fccfd4f26601e006bf6a79ca948dbd37c676cdd0db439554447320293d23b3dc

let Text/concat =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v23.1.0/Prelude/Text/concat.dhall
        sha256:731265b0288e8a905ecff95c97333ee2db614c39d69f1514cb8eed9259745fc0

let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v23.1.0/Prelude/Map/Type.dhall
        sha256:210c7a9eba71efbb0f7a66b3dcf8b9d3976ffc2bc0e907aadfb6aa29c333e8ed

let F = ./F.dhall

let HTML = ./Type.dhall

let indent =
      λ(n : Natural) →
      λ(t : Text) →
        Text/concat
          [ Text/spaces n
          , Text/replace "\n" (Text/concat [ "\n", Text/spaces n ]) t
          ]

let Attribute = { mapKey : Text, mapValue : Text }

let renderAttribute = λ(a : Attribute) → "${a.mapKey}=\"${a.mapValue}\""

let renderAttributes =
      λ(attrs : List Attribute) →
        let texts = List/map Attribute Text renderAttribute attrs

        in  Text/concatSep " " texts

let isEmpty =
      λ(T : Type) → λ(list : List T) → Natural/isZero (List/length T list)

let render
    : Natural → HTML → Text
    = λ(indentN : Natural) →
      λ(html : HTML) →
        let frr
            : F Text → Text
            = λ(fr : F Text) →
                merge
                  { TextNode = λ(t : Text) → t
                  , Element =
                      λ ( b
                        : { name : Text
                          , attrs : Map Text Text
                          , children : List Text
                          }
                        ) →
                        Text/concat
                          (   [ if    isEmpty Attribute b.attrs
                                then  "<${b.name}"
                                else  "<${b.name} ${renderAttributes b.attrs}"
                              ]
                            # ( if    isEmpty Text b.children
                                then  [ " />" ]
                                else  [ ''
                                        >
                                        ''
                                      , indent
                                          indentN
                                          (Text/concatSep "\n" b.children)
                                      , "\n"
                                      , "</${b.name}>"
                                      ]
                              )
                          )
                  }
                  fr

        in  html Text frr

in  render
