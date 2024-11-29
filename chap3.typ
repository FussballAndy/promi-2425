#import "template.typ": *

#show: book-template.with(
  chapter: 3,
  version: "1.0",
)

= Verteilungen

Gucken wir uns nun mal verschiedene Verteilungen an.

#definition("Bernoulli Verteilung (Bernoulli Distribution)")[
  Eine Zufallsvariable $X$ hat eine *Bernoulli Verteilung* $X ~ "Ber"(p)$, 
  sofern diese nur zwei mögliche Ausgänge hat. Meist wird dabei einer dieser 
  beiden Ausgänge als Erfolg bezeichnet und der andere als Misserfolg. Das $p$
  in der Verteilung ist dabei die Wsk., dass der Erfolgszustand angenommen wird,
  ist aber im allgemeinen sehr Kontextabhängig.

  Es gilt also: 
  $
    P(X="'Erfolg'") = p quad P(X="'Misserfolg'") = 1-p
  $
  Der Einfachheit halber bezeichnen wir allerdings $"'Erfolg'"$ oft mit $1$ und
  $"'Misserfolg'"$ oft mit $0$.

  Die folgenden Eigenschaften gelten für $0<p<1$ mit $P(X=1)=p$ und $P(X=0)=q$.
  Dabei ist $q = 1-p$.
  - $expect[X]=p$
  - $variance[X] = p q$
  - Für $p=1/2$ symmetrisch
]

#definition("Binomialverteilung (Binomial Distribution)")[
  Die *Binomialverteilung* baut auf der Bernoulli Verteilung auf. Dabei werden
  nun aber mehrere Zufallsvariablen $X_1, X_2, ..., X_n ~ "Ber"(p)$ betrachtet, 
  wobei man wissen will, wie viele dieser Zufallsvariablen einen gewissen Wert 
  haben. Eine Zufallsvariable $Y$ hat also eine Binomialverteilung 
  $Y ~ "Bin"(n,p)$, wenn $Y = X_1 + X_2 + ... + X_n$, wobei $X_i$ wie oben
  definiert.

  Es gilt dann:
  $
    P(Y=k) = binom(n, k) p^k (1-p)^(n-k)
  $
  wobei wir dann entsprechend überprüfen, ob $k$ Variablen "erfolgreich" waren.

  Eigenschaften:
  - $expect[Y]=n p$
  - $variance[Y]=n p (1-p)$
]

#definition("Poisson-Verteilung (Poisson Distribution)")[
  entsprechend weiter baut die *Poisson-Verteilung* auf der Binomialverteilung
  auf, wobei wir aber hier nun eher unendlich viele Zufallsvariablen betrachten
  wollen. Ziel dabei ist eine bessere Genauigkeit.
  Eine Zufallsvariable $X$ hat also eine Poisson-Verteilung $X ~ "Poi"(lambda)$,
  wenn gilt:
  $
    P(X=k) = lambda^k/k! e^(-lambda)
  $
  Dabei ist $k$ entsprechend wieder die Anzahl an Variablen die "erfolgreich"
  sein sollen.
]

= Variablentausch (engl. Change of Variables)

Nun gucken wir uns ein sehr wichtiges Tool an, dass wir an sich auch schon in 
Kapitel 1 brauchen um die Varianz ordentlich ausrechnen zu können:
#sub[Fragt mich hier auch bitte nicht, warum Jan das ganze jetzt erst einführt.]

Wenn wir eine stetige Zufallsvariable $X$ haben mit PDF $f_X$ und CDF $F_X$,
dann können wir diese zu einer Zufallsvarible $Y$ via eines Transformer $g$
umwandeln. Sprich $Y=g(X)$.