#import "@preview/athena-tu-darmstadt-exercise:0.1.0": tudaexercise, tuda-section as section

#show: tudaexercise.with(
  show-title: false,
  language: "ger",
  design: (
    // darkmode: true,
  )
)


#set enum(indent: 1em)
#set list(marker: [--])

#[
  #set text(font: "Roboto") 
  #align(center)[*Diese Fragen wurden größtenteils aus den Übungen zusammengesammelt.*]

  Für Lösungen siehe Lösungen der Übungen. Zudem ist der hier gegebene Platz
  teilweise deutlich übergegriffen für die eigentliche Aufgabe.
] 

#let generic-angled(sym, cont) = $#sym [#cont]$
#let expectation(cont, sub: none) = if sub != none {
  generic-angled($bb(E)_(#sub)$, cont)
} else {
  generic-angled($bb(E)$, cont)
}
#let variance(cont) = generic-angled($bb(V)$, cont)

= Basics und Informationstheorie

== PDF und CDF

Gegeben sei die folgende PDF einer Zufallsvariable $X$:
$
  f(x) = cases(
    c(2 - 2x^2) quad &"für" -1 < x < 1 \
    0 &"sonst"
  )
$

+ Bestimme den Wert für $c$
+ Bestimme den Erwartungswert $expectation(X)$
+ Bestimme die CDF von $X$
+ Bestimme die Wsk. für $0.5 <= X <= 0.5$

#pagebreak()

== De Morgan
Gegeben zwei unabhängige Ereignisse $E_1$ und $E_2$. Zeige, dass auch
$accent(E_1, macron)$ und $accent(E_2, macron)$ auch unabhängig sind.

#pagebreak()

== Rechnen mit Wsk.
Wir betrachten den Cache eines Systems. Dabei gibt es folgende Ereignisse:
- $P$: eine populäre Datei wurde angefragt
- $U$: der Cache wurde kürzlich aktualisiert

Außerdem sind folgende Wsk. gegeben:
- $p(P) = 0.1$
- $p(P|U) = 0.2$
- $p(P|accent(U, macron)) = 0.05$

+ Bestimme die Wsk. einer Aktualisierung $p(U)$
+ Bestimme die Wsk. einer Aktualisierung, wenn eine populäre Datei angefragt 
  wurde $p(U|P)$

#pagebreak()

== Exponentielle Verteilung
Gegeben sei eine stetige Zufallsvariable $T$ mit einer exponentiellen 
Verteilung:
$
  p(t) = lambda e^(-lambda t)
$
+ Bestimme den Erwartungswert $expectation(T)$
+ Bestimme ein $lambda$, dass einen Erwartungswert von $100 med 000$ gibt.
+ Bestimme die CDF von $T$
+ Bestimme den Median

#pagebreak()

== Covariance
Zeige, dass $variance(X + Y) = variance(X) + variance(Y) + 2"Cov"(X,Y)$

#pagebreak()

== Channel capacity
Gegeben sei ein Binary Erasure Channel (BEC) mit einer erasure Wsk. von 
$p_epsilon = 0.25$. Dazu kann der Sender $X$ die Nachrichten ${0,1}$ senden und
der Empfänger $Y$ die Nachrichten ${0,1,epsilon}$ empfangen, wobei $epsilon$
für ein gelöschtes Symbol steht. Berechne die zugehörige Channel Capacity.

Recap: Die Channel Capacity ist gegeben durch
$
  C = max_p(x) I(X;Y)
$

#pagebreak()

= Variablen Transformation, Mixture Models und MLE

== Betrag einer Zufallsvariable
Gegeben sei eine stetige Zufallsvariable $X$. Bestimme die CDF und PDF einer
neuen Zufallsvariable $Z = |X|$.

Hinweis: $|dot|$ ist der Betrag bzw. die Betragsfunktion

#pagebreak()

== Lineare Transformation einer Zufallsvariable
Gegeben sei erneut eine stetige Zufallsvariable $X$ mit PDF $p_X$. Zeige, dass 
eine lineare Transformation #box[$Y = a X + b$] mit 
$a in RR$, $b in RR backslash {0}$ allgemein eine PDF $p_Y$ der Form
$
  p_Y (y) = 1/(|b|) p_X ((y-a)/b)
$
hat.

#pagebreak()

== Mixture Modelle
Gegeben sei ein Gaussian Mixture Modell bestehend aus $n$ Gaußverteilungen:
$
  p(x) = sum_(k=1)^n pi_k cal(N) (x|mu_k,sigma_k^2)
$
Bestimme den Erwartungswert.

#pagebreak()

== MLE für eine kategorische Verteilung
Wir betrachten nun ein Ereignis mit $K$ verschiedenen Ausgangsmöglichkeiten.
Dazu modellieren wir die einzelnen Ausgänge als ein one-hot encoding Vektor:
$
  x in {0,1}^K quad "mit" quad sum_(i=1)^K x_i = 1
$
Nun wollen wir die Wsk. einer diskreten Zufallsvariable $X$ über einer
kategorischen Verteilung modellieren. Dabei sieht die PMF von $X$ wie folgt aus:
$
  p(x; theta) = product_(i=1)^K theta_i^(x_i)
$
Dabei gibt $theta_i$ die Wsk. an, dass $x_i=1$. Somit müssen wir auch 
sicherstellen, dass $sum_(i=1)^K theta_i = 1$.

Es seien die gemessenen Daten $cal(D)={d_1,...,d_n}$ gegeben. Bestimme die
optimalen Parameter $theta_i^"ml"$.

Hinweis: Die Umformung $sum_(i=1)^K theta_i = 1$ zu 
$theta_K = 1-sum_(i=1)^(K-1) theta_i = 1$ kann hilfreich sein.

#pagebreak()

= Bias & Variance

== Bias Variance Tradeoff
#let estf = $hat(f)_cal(D)$

Den Bias Variance Tradeoff kennt man bereits aus der Vorlesung. Wir wollen nun
die Formal dahinter weiter beweisen. \
Dafür nehmen wir wieder an, dass unsere Daten $y$ ein gewisses rauschen auf der
Ursprungsfunktion $f$ beinhalten:
$
  y(x) = f(x) + epsilon #h(2em) epsilon ~ cal(N)(0,sigma_epsilon^2)
$
Die loss function ist wie folgt gegeben:
$
  cal(L)(x) = sigma_epsilon^2 + expectation((y(x) - estf(x))^2, 
    sub: #{$cal(D), epsilon$})
$
$estf$ ist dabei unsere Schätzung für die Funktion.

Zeige, dass sich die loss function zu
$
  cal(L)(x) = sigma_epsilon^2 + "bias"^2(hat(f)) + "var"(hat(f))
$
umformen lässt.

Hinweis:
$
  "bias"(estf) &= expectation(f(x) - estf(x), sub: cal(D)) \
  "var"(estf) &= expectation((estf(x) - expectation(estf(x), sub: cal(D)'))^2, 
    sub: cal(D))
$

#pagebreak()

== Bias der Sample Variance
Die Sample Variance ist wie folgt definiert:
$
  hat(sigma)^2 = 1/n sum_(i=1)^n (x_i - overline(x))^2
$
wobei $overline(x)$ der Sample Mean ist.

Gegeben ist nun ein i.i.d. Datensatz $X = {x_1,...,x_n}$ aus einer 
Normalverteilung $cal(N)(mu,sigma^2)$. Bestimme den Erwartungswert für die
Sample Variance $expectation(hat(sigma)^2,sub:X)$. Ist die Sample Variance
biased?

Hinweis: Ein estimator ist biased, sofern der Erwartungswert des estimators 
nicht der tatsächlichen Varianz entspricht.

#pagebreak()

= Testing, Monte Carlo

== Assumptions
Gebe die Vermutungen (Assumptions) für folgende Testverfahren an:
+ A/B Test
+ Z-Test
+ Student's t-Test

#pagebreak()

== Monte Carlo für Integrale
Gegeben ist eine Funktion
$
  f(x) = sin(x) exp(-x/2) + 1
$
über einem Intervall $x in [a,b]$ mit $b >= a$. Zudem gilt $f(x) >= 0$ für
dieses Intervall.

Nun wollen wir das Integral der Funktion über dem Intervall bestimmen. Dafür
wollen wir prüfen, wie viele zufällig gewählte Punkte in einer Box
um $[a,b] times [0,"f_max"]$ unter der Kurve liegen.

#sub[Ich finde so sollten eigentlich Integrale in Mathe 2 eingeführt werden.
Viel schöner als Riemann Integrale.]

+ Stelle zuerst eine Gleichung für die Fläche der Box $A_"box"$ auf.
+ Stelle eine Gleichung für die Fläche unter der Kurve auf, gemäß der Fläche
  der Box und dem Verhätlnis $P$, wie viele Punkte unter der Kurve liegen.
+ Berechne die Fläche unter der Kurve für das Intervall $[0,2]$. Dabei ist
  $f_"max" approx 1.51$ und aus $1000$ Punkten liegen $543$ Punkte unter der 
  Kurve.