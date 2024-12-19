#import "@preview/showybox:2.0.3": showybox
#import "template.typ": *

#show: book-template.with(
  chapter: 1,
  version: "1.0",
)

= Grundlagen

== Begriffe


#notation-table(table(
  columns: (auto, 1fr),
  table.header([Name], [Bedeutung]),
  [Ergebnisraum \ (engl. Sample Spaces)], 
  [Eine Menge $cal(X)$ aller möglichen Ergebnisse.\
  Bsp. Münzwurf: $cal(X) = {"Heads", "Tails"}$],
  [Ereignis \ (engl. Event)],
  [Eine Menge $E$ an Ergebnissen, die im Ergebnisraum möglich sind. 
  Entsprechend eine Teilmenge des Ergebnisraum. \
  Bsp. Münze landet auf Kopf: $E = {"Tails"}$],
  [Zufallsvariable \ (engl. Random Variable)],
  [Eine Variable, deren Wert durch Zufall bestimmt wird, da z.B. ihr Wert noch 
  unbekannt ist. \
  Wir nennen eine Zufallsvariable _diskret_ (engl. _discrete_), wenn der 
  Ergebnisraum endlich ist, und _stetig_ (engl. _continuous_), wenn der 
  Ergebnisraum unendlich ist.]
))

*Wahrscheinlichkeit*

Mit der "Funktion" $P$ können wir die Wahrscheinlichkeit eines Events bestimmen.
So schreiben wir z.B. $P(E)$ für die Wahrscheinlichkeit, dass $E$ eintritt.
Ähnlich schreiben wir $P(X=x)$ für die Wahrscheinlichkeit, dass die 
Zufallsvariable $X$ den Wert $x$ annimmt.

*Wahrscheinlichkeits Axiome*
+ Wahrscheinlichkeit ist nicht negativ: $P(E) >= 0$
+ Wahrscheinlichkeit des Ergebnisraum ist 1: $P(cal(X)) = 1$
+ Für die Wsk. von zwei Ereignissen $E$, $F$ gilt: 
  $P(E union F) = P(E) + P(F) - P(E sect F)$. Für Ereignisse ohne
  Gemeinsamkeiten ist $P(E sect F)=0$. Daher ist für diese die Wsk. einfach die 
  Summe der einzelnen Wsk.

Des weiteren gilt: $P(overline(E)) = 1 - P(E)$.

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
    Die *PDF* ist eine Funktion $f: cal(X) -> bb(R)_(>=0)$, die die Wsk. 
    angibt, dass eine stetige Zufallsvariable $X$ nahe einem Wert $x$ ist.
    
    Dabei ist $integral_(x in cal(X)) f(x) dif x=1$

    #note[
      In der Vorlesung wurde die PDF mit Symbol $p$ eingeführt. Es scheint 
      allerdings (auch auf Jans Folien) üblicher zu sein diese mit $f$ zu 
      bezeichnen. In den weiteren Kapiteln wird allerdings eher wieder $p$
      genutzt.
    ]
  ]
)

#definition("Cumulative Distribution Function (CDF)")[
  Die *CDF* ist eine Funktion $F: bb(R) -> [0,1]$, die die Wsk. angibt,
  dass eine Zufallsvariable $X$ einen Wert kleiner oder gleich $x$ annimmt.
  $ F(x) = P(X <= x) = integral_(-infinity)^(x) p(x') dif x' $
  Dabei ist $F(-infinity)=0$ und $F(+infinity)=1$

  Gemäß Folien schreibt man auch gelegentlich $F_X$ um die Zufallsvariable $X$ 
  zu verdeutlichen.

  Des weiteren gilt: $ f(x) = (dif F_X) / (dif x) (x)$
]

== Verteilungen (engl. Distributions)

Bevor wir uns einzelne Verteilungen anschauen, gilt es erstmal den Begriff der 
Verteilung zu klären: \
Eine Verteilung beschreibt die Wahrscheinlichkeit, mit welcher eine 
Zufallsvariable gewisse Werte annimmt. Sowohl die Wahrscheinlichkeit, als auch 
die Werte, hängen dabei stark vom Kontext ab. \
Des weiteren schreiben wir $X ~ D$, wobei $D$ eine Verteilung ist (mehr dazu 
gleich), um zu sagen, dass die Variable $X$ eine entsprechende Verteilung hat.

#definition("Gleichverteilung (engl. Uniform Distribution)")[
  Eine stetige Zufallsvariable $X$ hat eine *Gleichverteilung* $X ~ U(a,b)$, 
  falls die Wsk., dass $X$ einen Wert $x in [a,b]$ animmt für alle $x$ gleich 
  ist und für alle anderen $x in.not [a,b]$ 0 ist.

   Die PDF ist entsprechend wie folgt definiert:
   $ f(x) = cases(
    1/(b-a) quad &"for" a <= x <= b \
    0 &"otherwise"
   ) $
]

#definition("Categorical Distribution")[
  #quote(block: true, attribution: [Chris Piech])[
    The Categorical Distribution is a fancy name for random variables which 
    takes on values *_other than numbers_*
  ]
  Entsprechend hat eine diskrete Zufallsvariable $X$ eine *Categorical 
  Distribution*, wenn es $K$ mögliche Kategorien gibt ($K$ ist endlich), wobei 
  jede dieser Kategorien eine eigene Wsk. $p_i$ hat.
  
  Die PMF ist entsprechend wie folgt definiert: \
  $ p(i)=P(X=i)=p_i "für alle" i in {1,2,...,K} "mit" sum_(i=1)^(K) p_i = 1 $


  #align(center,{
    table(
      stroke: 0.2pt + black,
      columns: 3,
      table.header([Category], $x$, $p(x)$),
      [Even], $0$, $0.5$,
      [Odd], $1$, $0.5$
    )
  })

  #note[Im deutschen scheint diese Art der Verteilung nicht gerade geläufig zu 
  sein.]
]

== Verknüpfungen von Wahrscheinlichkeiten

#notation-table(table(
  columns: (auto, auto, 1fr),
  table.header([Name], [Notation], [Bedeutung]),
  [Konjunktion, \ "Verundung", \ Schnitt], [$X Y$, \ $X "and" Y$, \ $X sect 
  Y$], [Die Konjunktion von zwei Ereignissen ist ein Ereignis, dass auftritt, 
  wenn beide Ereignisse auftreten. Zur Notation ist zu beachten, dass im Rahmen 
  von Wsk.-Funktionen oft auch $P(X,Y)$ für die Konjunktion von $X$ und $Y$ 
  geschrieben wird. ],
  [Disjunktion, \ "Veroderung", \ Vereinigung], [$X+Y$, \ $X "or" Y$, \ $X 
  union Y$], [Die Disjunktion von zwei Ereignissen ist ein Ereignis, dass 
  auftritt, wenn mind. eins von beiden Ereignissen auftritt.],
  [Konditionelle Wsk.\ Conditional Prob.], [$X | Y$], [Die Konditionelle Wsk. 
  von zwei Ereignissen ist die Wsk., dass $X$ auftritt, sofern $Y$ bereits 
  aufgetreten ist. \
  #note[An sich ist $P(X|Y)$ die konditionelle Wsk. Da es allerdings zu den 
  Verknüpfungen passt habe ich die konditionelle Verknüpfung zweier Ereignisse 
  hier bereits aufgenommen.]]
))

Hierbei bindet die Konjunktion (zumindest in der Schreibweise $X,Y$) mehr als 
die konditionelle Wsk. D.h., dass $X,Y | Z$ für $(X,Y) | Z$ steht und nicht $X, 
(Y | Z)$. Zu den weiteren Präszedenzen kann ich aktuell keine Aussage treffen.

Dazu ist zu beachten, dass Jan in seinen Folien meist die PMF/PDF mit 
eingesetzten Variablen nutzt. Also z.B. $p(x,y)$. Dies ist eine 
kurzschreibweise für $P(X=x,Y=y)$. \
Generell wird im folgenden bei der Nutzung von PMF/PDF meist mit $x$, $y$, etc.
auf unterschiedliche Zufallsvariablen $X$, $Y$, etc. abgezielt. Heißt 
$p(x)=P(X=x)$, aber $p(y)=P(Y=y)$ und nicht $P(X=y)$.

== Verhältnisse von Variablen

#definition("Unabhängigkeit (Independence)")[
  Zwei Zufallsvariablen $X$, $Y$ sind *unabhängig*, wenn die Wahrscheinlichkeit,
  dass die Werte $x$, $y$ angenommen werden, nur von den jeweiligen 
  Wahrscheinlichkeiten, dass $X=x$ und $Y=y$ eintritt, abhängig ist. \
  D.h.
  $ p(x,y)=p(x)p(y) $
  Sofern dies nicht gilt sind $X$ und $Y$ abhängig.
]

#definition("Konditionale Unabhängigkeit (Conditionally Independent)")[
  Zwei Zufallsvariablen $X$, $Y$ sind *konditional unabhängig* gegeben einer 
  dritten Zufallsvariable $Z$, wenn die Wsk. für $X=x$ und $Y=y$ gegeben 
  $Z=z$ unabhängig sind. \
  D.h.
  $ p(x,y | z) = p(x | z) p(y | z) $
]

== Arten von Wsk.

#definition("Joint Probability")[
  Die *joint probability* ist die Wsk., dass zwei Zufallsvariablen $X$, $Y$ 
  bestimmte Werte $x$, $y$ annehmen -- Also quasi die Wsk. der Konjunktion 
  von $X=x$ und $Y=y$. \
  Für diskrete Variablen ist die PMF dabei:
  $ p(x,y) = p(x) p(y | x) = p(y) p(x | y) $
  Für stetige Variablen ist die PDF erstmal analog, kann aber mit der CDF $F$ 
  verknüpft werden:
  $ f(x,y) = f(x) f(y | x) = f(y) f(x | y) = (diff^2)/(diff x diff y) F(x,y) $

  Man beachte, dass für unabhängige Variablen diese Wsk. genau wieder die 
  Formel $p(x,y)=p(x)p(y)$ wiedergibt, da $p(y | x)$ bei unabhängigkeit 
  gleich $p(y)$ ist.

  #note[Die deutsche Übersetzung hierfür wäre "Multivariat". Da dieses Wort 
  sehr ungewöhnlich ist, wurde die deutsche Übersetzung hier weggelassen.]
]

#definition("Marginal Probability")[
  Die *marginal probability* ist die Wsk., dass eine Zufallsvariable $X$ einen 
  Wert $x$ annimmt, unabhängig von einer weiteren Zufallsvariable $Y$. Bzw. 
  anders herum: man hat einen Weg um die Wsk. $p(x,y)$ zu bestimmen, will aber 
  $p(x)$ wissen.
  Für diskrete Variablen:
  $ p(x) = sum_(y in cal(Y)) p(x,y) = sum_(y in cal(Y)) p(x)p(y | x) $
  Für stetige Variablen:
  $ f(x) = integral_(-infinity)^(infinity) f(x,y) dif y $

  Bei einer konditionalen Unabhängigkeit gilt des weiteren:
  $ p(x,y) = sum_(z in cal(Z)) p(x | z) p(y | z) p(z) $
]

== Satz von Bayes (Bayes' Rule / Theorem)

Mithile des Satz von Bayes kann man die abhängigkeit von Wsk. umdrehen. D.h. man 
kann $P(B | A)$ in $P(A | B)$ umwandeln -- zumindest solange man auch $P(A)$ 
und $P(B)$ hat.

tldr:
$ P(A | B) = (P(B | A) P(A)) / P(B) $

*Herleitung:*
Aus der konditionalen Wsk. von $A$ und $B$ erhalten wir:
$ P(A | B) = P(A, B) / P(B) quad "und" quad P(B | A) = P(A,B) / P(A) $
Formt man nun beide Seiten nach $P(A,B)$ um und setzt diese gleich erhält man:
$ P(A | B) P(B) = P(B | A) P(A) $
Und daraus erhält man schlussendlich den Satz. 


Hier kann man auch noch das _Law of total probability_ erwähnen:
$P(E) = P(E | F) P(F) + P(E | overline(F)) P(overline(F))$.
== Statistik von Wsk. bzw. Verteilungen

#definition("Erwartung (Expectation)")[
  Die *Erwartung* / *Erwatungswert* von einer Zufallsvariable $X$ (geschrieben 
  $expect[X]$) beschreibt den durchschnittlichen Wert, den
  die Zufallsvariable annimmt. \
  #grid(
    columns: (1fr, 1fr),
    [
      Für diskrete Variablen gilt:
      $ expect[X] = sum_(x in cal(X)) x p(x) $
    ], [
      Für stetige Variablen gilt:
      $ expect[X] = integral_(x in cal(X)) x f(x) dif x $
    ]
  )
  Oft schreiben wir auch $mu$ oder $mu_X$ für $bb(E)[X]$
]

#grid(
  columns: (48%, 48%),
  column-gutter: 1fr,
  definition("Varianz (Variance)")[
    Die *Varianz* misst, wie sehr die möglichen Werte einer Zufallsvariable $X$ 
    ausgebreitet sind bzw. wie weit sich diese strecken. \
    Man berechnet die Varianz wie folgt:
    $ variance[X] = expect[(X-expect[X])^2] = expect[X^2] - expect[X]^2 $
    Man beachte, dass die Varianz stets $>= 0$ ist.
  ],
  definition("Standardabweichung (Standard Deviation)")[
    Die *Standardabweichung* $sigma$ misst hingegen die Varianz um den
    Erwartungswert $mu$ herum.
    $ sigma=sqrt(variance[X]) $
    Entsprechend ist diese auch wieder $>= 0$. Dazu ist die Standardabweichung 
    deutlich verbreiteter / wichtiger.
  ]
)

Eigenschaften von Erwartungswert und Varianz:
+ Erwartung ist linear $expect[X+Y] = expect[X] + expect[Y]$
+ $variance[X+c] = variance[X]$ für alle Konstanten $c$
+ $variance[c X] = c^2 variance[X]$ für alle Konstanten $c$
+ $variance[X+Y] = variance[X] + variance[Y]$ für unabhängige $X$, $Y$

#definition("Moment")[
  *Momente* sind quantitive Messungen von der Form der Verteilung einer
  Zufallsvariable $X$. Was sie aber wirklich aussagen weiß keiner so
  genau.
  #grid(
    columns: 3,
    column-gutter: 1em,
    [
      n-ter Moment um einen Wert $c$ $ expect[(X-c)^n] $
    ],
    [
      n-ter Zentraler Moment um die Erwartung $ expect[(X-mu)^n] $
    ],
    [
      n-ter _Standardized_ Moment $ expect[((X-mu)/sigma)^n] $
    ]
  )
]

#definition("Schiefe (Skewness)")[
  Die *Schiefe* einer Zufallsvariable $X$ bzw. von deren Verteilung gibt an, wie 
  asymmetrisch die Verteilung um den Erwartungswert $mu$ herum ist.
  $
    "Skew"(X) = expect[((X-mu)/sigma)^3]
  $
  Für eine symmetrische Verteilung ist die Schiefe 0.
]

#definition("Wölbung (Kurtosis)")[
  Die *Wölbung* einer Zufallsvariable $X$ gibt an, wie sehr die Verteilung bzw. 
  deren Mitte/Gipfel einer Normalverteilung ähnelt. Speziell im Hinblick auf 
  wie spitz/flach der Gipfel ist.
  $ "Kurt"(X) = expect[((X-mu)/sigma)^4]-3 $
  Entsprechend wegen des Vergleiches mit der Normalverteilung rechnen wir hier 
  auch minus $3$, was die Höhe des Gipfels der Normalverteilung ist. 
]

#definition("Covariance")[
  Die *Covariance* misst die Abhängigkeit von zwei Zufallsvariablen. Genauer 
  wird geguckt, inwiefern die Abweichung von einer Variable zu ihrem 
  Erwartungswert der Abweichung von einer anderen Variable zu ihrem 
  Erwartungswert ähnelt.
  $ Cov(X,Y) = expect[(X-mu_X)(Y-mu_Y)] = expect[X Y] - mu_X mu_Y $
  Wenn größere Werte von einer Variable mit größeren Werten einer anderen 
  Variable entsprechen, dann ist die Covariance positiv, andernfalls negativ. 
  Und wenn beide unabhängig sind ist die Covariance 0 (Umkehrung gilt nicht 
  unbedingt). \
  Eigenschaften:
  + $Cov(X,X)=variance[X]$
  + $Cov(X,Y)=Cov(Y,X)$
  + $Cov(X,c)=0$ für alle Konstanten $c$
  + $variance[X+Y]=variance[X]+variance[Y]+2Cov(X,Y)$
  + $Cov(X+Y,Z+W)=Cov(X,Z)+Cov(X,W)+Cov(Y,Z)+Cov(Y,W)$
]

#definition("Correlation")[
  Die *Correlation* ist die Covariance zweier Variablen genormt nach der Varianz
  der beiden Variablen.
  $ Corr(X,Y) = Cov(X,Y)/(sigma_X sigma_Y) $

  Eigenschaften:
  + $Corr(X,Y) in [-1,1]$
  + Gemäß $Cov$: $X$, $Y$ unabhängig $=> Corr(X,Y)=0$ 
    (erneut Umkehrung nicht unbedingt)
]

#definition("Median")[
  Wir sagen ein Wert $c$ ist der *Median* einer Zufallsvariable $X$, wenn die 
  "Masse" links von $c$ gleich der "Masse" rechts von $c$ ist. Der Median teilt 
  also die Verteilung in zwei gleichmäßige Massen. \
  Mathematisch drückt man das ganze wie folgt aus:
  $ c "median" <=> P(X <= c) >= 0.5 "und" P(X >= c) >= 0.5 $
  Bei symmetrischen Verteilungen ist der Erwartungswert auch der Median.
]

#definition("Quantile, Perzentile und Quartile")[
  Diese Begriffe bezeichnen die Aufteilung der Verteilung in entsprechend viele 
  gleichmassige Teile. Also für Quartile in 4 Teile und Perzentile in 100 Teile 
  etc.
]

#definition("Modi (Modes)")[
  *Modi* sind Werte in der Verteilung, die mit hohe Dichte bzw. Wsk. haben. 
  Anschaulich sind es einfach die Maxima der Verteilung.
]