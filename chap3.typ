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
]