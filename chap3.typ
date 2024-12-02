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

= Arbeiten mit Verteilungen

== Variablentausch (engl. Change of Variables)

Nun gucken wir uns ein sehr wichtiges Tool an, dass wir an sich auch schon in 
Kapitel 1 brauchen um die Varianz ordentlich ausrechnen zu können:
#sub[Fragt mich hier auch bitte nicht, warum Jan das ganze jetzt erst einführt.]

Wenn wir eine stetige Zufallsvariable $X$ haben mit PDF $f_X$ und CDF $F_X$,
dann können wir diese zu einer Zufallsvarible $Y$ via eines "Transformer" 
$g: bb(R) -> bb(R)$ umwandeln. Sprich $Y=g(X)$.

Nun ist der allgemeine Ansatz um $f_Y$ und $F_Y$ zu bestimmen, dass man zuerst
die CDF über einen etwas besonderen Weg herleitet und basierend darauf dann
die PDF automatisch als Ableitung erhält. Das ganze sieht dann wie folgt aus:
$
  F_Y (y) = P(Y <= y) = P(g(X) <= y) = P(X in {x | g(x) <= x})
$
#sub[$P(X in M)$ steht hierbei für die Wsk., dass der Wert, den $X$ annimmt in 
der Menge $M$ ist -- ist hoffentlich ab dem Punkt schon trivial.]

Entsprechend erhalten wir dann daraus die PDF:
$
  f_Y (y) = (dif F_Y) / (dif y) (y)
$

Ist nun $g$ (strikt) monoton, dann können wir die Umkehrfunktion $g^(-1)$
aufstellen. Mit dieser können wir dann eine simplere CDF aufstellen:
#grid(columns: (1fr, 1fr), column-gutter: 2em)[
Für ein monoton _wachsendes_ $g$:
$
  F_Y (y) &= P(g(X) <= y) \ &= P(X <= g^(-1) (y)) \ &= F_X (g^(-1) (y))
$
Daraus erhalten wir dann erneut:
$
  f_Y (y) = f_X (g^(-1) (y)) dif / (dif y) g^(-1) (y)
$
][
Für ein monoton _fallendes_ $g$:
$
  F_Y (y) &= P(g(X) <= y) \ &= P(X >= g^(-1) (y)) \ &= 1- F_X (g^(-1) (y))
$
Daraus erhalten wir dann erneut:
$
  f_Y (y) = - f_X (g^(-1) (y)) dif / (dif y) g^(-1) (y)
$
]

Die Kombination aus beidem ergibt:
$
  f_Y (y) = f_X (g^(-1) (y)) abs( dif / (dif y) g^(-1) (y) )
$

Für den Erwartungswert einer solch Transformierten Variable gilt:
$
  expect[g(X)] = integral_(-infinity)^(infinity) g(x) f_X (x) dif x
$

Wie schon eben angesprochen kann man hierdurch nun eben sowas berechnen, wie
$expect[X^2]$, was dann eben zu 
$integral_(-infinity)^(infinity) x^2 f_X (x) dif x $

== Convolution

Nun betrachten wir den Fall, dass wir zwei Zufallsvariablen $X$ und $Y$ haben 
und zu einer dritten Zufallsvariable $Z = X + Y$ die Verteilung wissen
wollen. Entsprechend müssen eben $X$ und $Y$ auch Zufallsvariablen über
ähnlichen Wertebereichen (hier zusammengefasst als $cal(X)$) sein.
Der allgemeine Ansatz dafür ist die _Convolution_. Diese ist anschaulich ein
Weg um zwei Funktionen flüssig zu verbinden bzw. zu "verschmieren".
$
  f_Z (z) = (f_X * f_Y) (z)
$

#grid(columns: (1fr, 1fr), column-gutter: 2em)[
  Für diskrete Wertebereiche gilt:
  $
    f_Z (z) = sum_(x in cal(X)) f_X (x) f_Y (z-x)
  $
][
  Für stetige Wertebereiche gilt:
  $
    f_Z (z) = integral_(x in cal(X)) f_X (x) f_Y (z-x) dif x
  $
]

== Central Limit Theorem

Das Central Limit Theorem besagt, dass $n$ unabhängige und gleichmäßig verteilte
Zufallsvariablen $X_1, X_2, ..., X_n$ mit gleichem Erwartungswert 
$expect[X_i] = mu$ und gleicher Varianz $variance[X_i] = sigma^2$ aufsummiert 
einer Normalverteilung annähern.

Die Zufallsvariable $S_n$ bezeichnet dabei die Summe von $n$ solcher 
Zufallsvariablen. Also $display(S_n = sum_(i=0)^n X_i)$. Des weiteren
bezeichnet die Zufallsvariable $Z_n$ die normalisierte Version dieser
Zufallsvariable:
$
  Z_n = (S_n - expect[S_n]) / sqrt(variance[S_n]) quad "mit" 
  lim_(n -> infinity) F_Z_n (z) = P(Z_n <= z) 
  = 1/(2pi) integral_(-infinity)^z e^(-x^2 slash 2) dif x = cal(N) (0;1)
$

Der letzte Teil der Formel ist dabei die konkrete Formel der Normalverteilung
mit Erwartungswert $mu = 0$ und Standardabweichung $sigma^2 = 1$.

Im allgeminen gilt auch für die PDF $f$ einer Normalverteilung 
$cal(N)(mu,sigma^2)$:
$
  f(x) = 1/(sigma sqrt(2pi)) integral_(-infinity)^z e^(-1/2 ((x-mu)/sigma)^2)  
$

Zudem ist der Grenzwert von $Z_n$ für beliebige Zufallsvariablen $X_i$ gleich,
solange eben der Erwartungswert und die Standardabweichung gleich sind und
alle Variablen unabhängig und gleichmäßig verteilt sind.

== Products and Quptients

Jan sagt selbst, dass dies wahrscheinlich weniger relevant ist, darum werde ich
das ganze hier auch nicht weiter ausführen. Der Vollständigkeit halber aber
trotzdem noch die PDF vom Produkt/Quotient zweier Zufallsvariablen $X$, $Y$:

#grid(columns: (1fr, 1fr), column-gutter: 2em)[
  PDF von $Z=X Y$:
  $
    f_Z (z) = integral_(x in cal(X)) f_X (x) f_Y (z slash x) 1/abs(x) dif x
  $
][
  PDF von $U=Y slash X$:
  $
    f_U (u) = integral_(x in cal(X)) f_X (x) f_Y (u x) abs(x) dif x
  $
]