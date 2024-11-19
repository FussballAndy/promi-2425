#import "@preview/showybox:2.0.3": showybox

#set document(
  title: "1. Probabilistischer Untergang meines Lebens",
  author: "Andreas"
)

#set page(
  margin: (
    top: 15mm,
    left: 15mm,
    right: 15mm,
    bottom: 20mm
  ),
  numbering: "1",
  number-align: right
)

#set par(justify: true)
#set text(font: "Arial", size: 10pt, lang: "de")
#show math.equation: set text(font: "New Computer Modern Math", size: 1.1em)
#set list(marker: [--])

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


= Grundlagen

== Begriffe


#table(
  columns: (auto, 1fr),
  stroke: (_,y) => {
    (
      top: if y == 1 {
        1pt + gray
      } else if y > 1 {
        0.5pt + gray
      }
    )
  },
  table.header([*Name*], [*Bedeutung*]),
  [Ergebnisraum \ (engl. Sample Spaces)], 
  [Eine Menge $cal(X)$ aller möglichen Ergebnisse.\
  Bsp. Münzwurf: $cal(X) = {"Heads", "Tails"}$],
  [Ereignis \ (engl. Event)],
  [Eine Menge $E$ an Ergebnissen, die im Ergebnisraum möglich sind. Entsprechend eine Teilmenge des Ergebnisraum. \
  Bsp. Münze landet auf Kopf: $E = {"Tails"}$],
  [Zufallsvariable \ (engl. Random Variable)],
  [Eine Variable, deren Wert durch Zufall bestimmt wird, da z.B. ihr Wert noch unbekannt ist. \
  Wir nennen eine Zufallsvariable _diskret_ (engl. _discrete_), wenn der Ergebnisraum endlich ist, und _stetig_ (engl. _continuous_), wenn der Ergebnisraum unendlich ist.]
)

*Wahrscheinlichkeit*

Mit der "Funktion" $P$ können wir die Wahrscheinlichkeit eines Events bestimmen.
So schreiben wir z.B. $P(E)$ für die Wahrscheinlichkeit, dass $E$ eintritt.
Ähnlich schreiben wir $P(X=x)$ für die Wahrscheinlichkeit, dass die Zufallsvariable $X$ den Wert $x$ annimmt.

*Wahrscheinlichkeits Axiome*
+ Wahrscheinlichkeit ist nicht negativ: $P(E) >= 0$
+ Wahrscheinlichkeit des Ergebnisraum ist 1: $P(cal(X)) = 1$
+ Falls zwei Events keine Gemeinsamkeiten haben ($E_1 sect E_2 = emptyset$), dann ist die gemeinsame Wsk. die Summe der einzelnen Wsk.: $P(E_1 union E_2) = P(E_1) + P(E_2)$

== Funktionen

#grid(
  columns: (48%, 48%),
  column-gutter: 1fr,
  definition("Probability Mass Function (PMF)")[
    Die *PMF* ist eine Funktion $p: cal(X) -> [0,1]$, die die Wsk. angibt, 
    dass eine diskrete Zufallsvariable $X$ einen Wert $x$ annimmt.
    $ p(x)=P(X=x) $
    Dabei ist $sum_(x in cal(X)) p(x)=1$
  ],
  definition("Probability Density Function (PDF)")[
    Die *PDF* ist eine Funktion $f: cal(X) -> bb(R)_(>=0)$, die die Wsk. angibt, 
    dass eine stetige Zufallsvariable $X$ nahe einen Wert $x$ ist.
    
    Dabei ist $integral_(x in cal(X)) f(x) dif x=1$

    #note[
      In der Vorlesung wurde die PDF mit Symbol $p$ eingeführt. Es scheint allerdings (auch auf Jans Folien) üblicher zu sein diese mit $f$ zu bezeichnen.
    ]
  ]
)

#definition("Cumulative Distribution Function (CDF)")[
  Die *CDF* ist eine Funktion $F: bb(R) -> [0,1]$, die die Wsk. angibt,
  dass eine Zufallsvariable $X$ einen Wert kleiner oder gleich $x$ annimmt.
  $ F(x) = P(X <= x) = integral_(-infinity)^(x) p(x') dif x' $
  Dabei ist $F(-infinity)=0$ und $F(+infinity)=1$

  Gemäß Folien schreibt man auch gelegentlich $F_X$ um die Zufallsvariable $X$ zu verdeutlichen.

  Des weiteren gilt: $ p(x) = (dif F_X) / (dif x) (x)$
]

== Verteilungen (engl. Distributions)

Bevor wir uns einzelne Verteilungen anschauen gilt es erstmal den Begriff der Verteilung zu klären: \
Eine Verteilung beschreibt die Wahrscheinlichkeit, mit welcher eine Zufallsvariable gewisse Werte annimmt. Sowohl die Wahrscheinlichkeit, als auch die Werte hängt dabei stark vom Kontext ab. \
Des weiteren schreiben wir $X ~ D$, wobei $D$ eine Verteilung ist (mehr dazu gleich), um zu sagen, dass die Variable $X$ eine entsprechende Verteilung hat.

#definition("Gleichverteilung (engl. Uniform Distribution)")[
  Eine stetige Zufallsvariable $X$ hat eine *Gleichverteilung* $X ~ U(a,b)$, falls die Wsk., dass $X$ einen Wert $x in [a,b]$ animmt für alle $x$ gleich ist und für alle anderen $x in.not [a,b]$ 0 ist.

   Die PDF ist entsprechend wie folgt definiert:
   $ f(x) = cases(
    1/(b-a) quad &"for" a <= x <= b \
    0 &"otherwise"
   ) $
]

#definition("Categorical Distribution")[
  #quote(block: true, attribution: [Chris Piech])[
    The Categorical Distribution is a fancy name for random variables which takes on values *_other than numbers_*
  ]
  Entsprechend hat eine diskrete Zufallsvariable $X$ eine *Categorical Distribution*, wenn es $K$ mögliche Kategorien gibt ($K$ ist endlich), wobei jede dieser Kategorien eine eigene Wsk. $p_i$ hat.
  
  Die PMF ist entsprechend wie folgt definiert: \
  $ p(X=i)=p_i "für alle" i in {1,2,...,K} "mit" sum_(i=1)^(K) p_i = 1 $


  #align(center,{
    table(
      stroke: 0.2pt + black,
      columns: 3,
      table.header([Category], $x$, $p(x)$),
      [Even], $0$, $0.5$,
      [Odd], $1$, $0.5$
    )
  })

  #note[Im deutschen scheint diese Art der Verteilung nicht gerade geläufig zu sein.]
]

== Arten der Wsk. / Verhältnisse von Variablen

Zufallsvariablen können in verschiedenen Verhältnissen zueinander stehen. 

#definition("Unabhängigkeit (Independence)")[
  Zwei Zufallsvariablen $X$, $Y$ sind *unabhängig*, wenn die Wsk., dass sie die Werte $x$, $y$ annehmen nur von der Wsk., dass $X=x$ und $Y=y$, abhängig sind. \
  D.h.
  $ p(x,y)=p(x)p(y) $
  Sofern dies nicht gilt sind $X$ und $Y$ abhängig.
]


Etwas zum lesen:
- https://chrispiech.github.io/probabilityForComputerScientists/en/ProbabilityForComputerScientists.pdf \
  Bzw. der dazugehörige Online Reader: \
  https://chrispiech.github.io/probabilityForComputerScientists/en/