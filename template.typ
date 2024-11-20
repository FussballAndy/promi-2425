#import "@preview/showybox:2.0.3": showybox

#let book-template(
  chapter: 1,
  version: "1.0",
  body
) = {
  set document(
    title: [Kapitel #chapter -- Probabilistischer Untergang meines Lebens],
    author: "Andreas"
  )

  set page(
    margin: (
      top: 15mm,
      left: 15mm,
      right: 15mm,
      bottom: 20mm
    ),
    header: [
      #set align(right)
      Kapitel #chapter -- Version #version
    ],
    numbering: "1",
    number-align: right
  )

  set par(justify: true)
  set text(font: "Arial", size: 10pt, lang: "de")
  show math.equation: set text(font: "New Computer Modern Math", size: 1.1em)
  set list(marker: [--])

  body

  box[
    #set text(weight: "bold")
    Bei Fragen, Verbesserungen oder weiterem gerne entweder in Discord
    fragen oder in #link("https://github.com/FussballAndy/promi-2425")[GitHub].
  ]
}

#let definition(title, body) = {
  showybox(
    title: title,
    body
  )
}

#let note(body) = [
  #set text(size: .8em)
  *Hinweis:* #body
]

#let notation-table(body) = {
  set table(stroke: (_,y) => {
    (
      top: if y == 1 {
        1pt + gray
      } else if y > 1 {
        0.5pt + gray
      }
    )
  })
  body
}