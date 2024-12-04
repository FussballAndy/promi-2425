#import "template.typ": *

#show: book-template.with(
  chapter: 4,
  version: "1.0"
)

= Estimators

Erneut befinden wir uns an dem Punkt, wo wir die genaue Verteilung zu etwas nicht
wissen. Bzw. wir wissen ggf. was für eine Art von Verteilung haben, wissen dann
aber nicht mit welchen Parametern diese Verteilung aufgebaut ist. Dieses Thema
beschäftigt sich eben genau mit der Bestimmung solcher Parameter.

Aber erst einmal was sind denn überhaupt diese Parameter? \
Visuell sind die Parameter einfach die Werte, die man der Verteilung übergibt. 
Bei $cal(N)(mu, sigma^2)$ sind z.B. $mu$ und $sigma^2$ die Parameter. Diese
ganzen Parameter fassen wir dann in einen Vektor $theta$ zusammen:
$theta = (mu, sigma^2)^T$. Nun einmal für alle uns bekannte Verteilungen:
#notation-table(table(
  columns: (1fr,1fr),
  table.header([Verteilung], [Parameter]),
  $"Ber"(p)$, $theta=p$,
  $"Bin"(n,p)$, $theta=(n,p)^T$,
  $"Poi"(lambda)$, $theta=lambda$,
  $"Uniform"(a,b)$, $theta=(a,b)^T$,
  $cal(N)(mu, sigma^2)$, $theta=(mu, sigma^2)^T$
))

Um diese Parameter zu schätzen gibt es nun zwei Arten von Estimators:

#grid(columns: (1fr, 1fr), column-gutter: 2em)[
  #definition("Point Estimators")[
    *Point Estimators* nutzen gesammelte Daten und rechnen damit einen
    einzelnen geschätzten Wert für einen Parameter aus. Dieser ist dann die
    beste Schätzung.
  ]
][
  #definition("Interval Estimators")[
    *Interval Estimators* bestimmen im Kontrast dazu ein Intervall an 
    möglichen Werten für einen Parameter. Typischerweise wird dieses Intervall
    durch eine Unter-/Obergrenze angegeben.
  ]
]

// Zwei Folien geskippt, sehe aber für die keine relevanz, da wenig Inhalt.

== Maximum Likelihood Estimation

Hierfür brauchen wir zuerst unsere Beispieldaten $cal(D) = {x_i}_(i=1)^n$

Außerdem brauchen wir noch den Begriff der _Likelihood_ $L(theta)$: Diese gibt 
die Wsk. an, dass Daten $cal(D)$ mit den Parametern $theta$ generiert wurden.

Nun ist unser Ziel hier diese _Likelihood_ zu maximieren, also
$
  arg max_theta L(theta) = p(cal(D) | theta)
$
zu bestimmen.

Dafür müssen die Daten allerdings *unabhängig* und *gleichmäßig verteilt* sein,
heißt:
- unabhängig: $P(X_1 <= alpha, X_2 <= beta)=P(X_1 <= alpha) P(X_2 <= beta) quad
  forall alpha, beta in bb(R)$
- gleichmäßig verteilt: $P(X_1 <= alpha) = P(X_2 <= beta) quad forall alpha, 
  beta in bb(R)$

Aus dieser Bedingung erhalten wir dann:
$
  L(theta) = p(cal(D) | theta) = p(x_1,x_2,...,x_n | theta) =
  p(x_1 | theta) p(x_2 | theta) ... p(x_n | theta) = Pi_(k=1)^n p(x_k | theta)
$
Für das Ergebnis der MLE schreiben wir auch $hat(theta)_"ML"$. Das wichtige
hierbei ist das dies erst einmal wieder als Zufallsvariable ansehbar ist. Uns
interessiert dabei dann der Erwartungswert und die Varianz.

*Log Likelihood*: \
Da es meist einfacher zu berechnen ist, kann man auch den Logarithmus der
Likelihood maximieren. Dies ist möglich, da der Logarithmus soweit ordentlich
runterskaliert.

$
  log L(theta) = log p(cal(D) | theta) = log Pi_(k=1)^n p(x_k | theta) = 
  sum_(k=1)^n p(x_k | theta)
$

Das Maximum einer Summe zu bestimmen ist nun deutlich einfacher, da z.B. auch
ableiten deutlich einfacher wird. Dazu ist es auch numerisch stabiler,
da Werte nahe 0 im Logarithmus wieder etwas größer werden, wodurch wir die
floating point precision unserer Rechner nicht ankratzen.

== Bayesian Estimation

TODO

#emoji.construction BIG TODO

MLE vs MAP:
MLE mit limitierten Daten ist gefährlich, da Varianz dann sehr niedrig. Somit 
ggf. Division durch 0. MAP hingegen durch Subjektibvität robuster. 

Prior $p(Theta)$ \
Likelihood $p(D | Theta)$ \
Posterior $p(Theta | D)$ \
Evidence $p(D)$

$p(Theta,D)$ nonsense

p. 49
$D = cal(X) times cal(Y)$

w = parameters ???

p. 72: I = Einheitsmatrix

; steht für | aber mit Parametern

Auffrischen: Multivariate Gaußverteilung

; bindet stärker

p. 73:  $sigma_0$ Parameter über Gauss Prior $w$

p. 78: $lambda$ Kontroliiert wie sehr wir Daten vs Prior vertrauen. $lambda$
reduzieren erhöht komplexität

Bessere Werte meist in $10^(-6)$ bis $10^(-8)$. $0.1N$ schon sehr hoch.