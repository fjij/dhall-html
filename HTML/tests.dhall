let HTML = ./Type.dhall

let render = ./render.dhall

let el = ./el.dhall

let text = ./textNode.dhall

let element = ./element.dhall

let example0 =
        assert
      :     render
              2
              ( el
                  "html"
                  [ el "head" [ el "title" [ text "My Page" ] ]
                  , el
                      "body"
                      [ el "h1" [ text "My Page" ]
                      , el "br" ([] : List HTML)
                      , element
                          "a"
                          (toMap { href = "./other.html" })
                          [ text "Other Page" ]
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
