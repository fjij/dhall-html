let HTML = ./Type.dhall

let render = ./render.dhall

let t = ./textNode.dhall

let ea = ./element.dhall

let e =
      \(name : Text) ->
        ea name (toMap {=} : List { mapKey : Text, mapValue : Text })

let example0 =
        assert
      :     render
              2
              ( e
                  "html"
                  [ e "head" [ e "title" [ t "My Page" ] ]
                  , e
                      "body"
                      [ e "h1" [ t "My Page" ]
                      , e "br" ([] : List HTML)
                      , ea
                          "a"
                          (toMap { href = "./other.html" })
                          [ t "Other Page" ]
                      ]
                  ]
              )
        ===  ''
             <html>
               <head>
                 <title>
                   My Page
                 </title>
               </head>
               <body>
                 <h1>
                   My Page
                 </h1>
                 <br />
                 <a href="./other.html">
                   Other Page
                 </a>
               </body>
             </html>''

in  True
