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

#note[Jan, genauso wie viele andere auch, verwenden oft auch eckige Klammern
um den Vektor darzustellen. Um das ganze allerdings einheitlich mit Mathe I
zu machen wurden hier Runde Klammern gewählt.]

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

Außerdem brauchen wir noch den Begriff der _Likelihood_ $L(theta)=p(D | theta)$. 
Diese gibt  die Wsk. an, dass Daten $cal(D)$ mit den Parametern $theta$ 
generiert wurden.

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
  L(theta) = p(cal(D) | theta) 
  = p(x_1,x_2,...,x_n | theta) 
  = p(x_1 | theta) p(x_2 | theta) ... p(x_n | theta) 
  = product_(k=1)^n p(x_k | theta)
$
Für das Ergebnis der MLE schreiben wir auch $hat(theta)_"ML"$. Das wichtige
hierbei ist das dies erst einmal wieder als Zufallsvariable ansehbar ist. Uns
interessiert dabei dann der Erwartungswert und die Varianz.

*Log Likelihood*: \
Da es meist einfacher zu berechnen ist, kann man auch den Logarithmus der
Likelihood maximieren. Dies ist möglich, da der Logarithmus soweit ordentlich
runterskaliert.

$
  log L(theta) = log p(cal(D) | theta) = log product_(k=1)^n p(x_k | theta) = 
  sum_(k=1)^n log p(x_k | theta)
$

Das Maximum einer Summe zu bestimmen ist nun deutlich einfacher, da z.B. auch
ableiten deutlich einfacher wird. Dazu ist es auch numerisch stabiler,
da Werte nahe 0 im Logarithmus wieder etwas größer werden, wodurch wir die
floating point precision unserer Rechner nicht ankratzen.

== Bayesian Estimation

Was man nun beobachten kann, ist das in MLE die Parameter $theta$ als feste
Werte angesehen werden, weswegen es sich dabei auch um Point Estimators handelt.
Nun betrachten wir aber mal einen anderen Fall, bei dem wir unsere Parameter
$theta$ als eine Zufallsvariable betrachten. Dabei kann dann erneut ein fester
Wert entstehen, der am wahrscheinlichsten angenommen wird, es kann aber eben
auch ein Bereich rauskommen -- also eine density estimation.

// ggf. noch etwas mehr auf die Unterschiede zwischen Frequentist und Bayesian
// eingehen? siehe Folie 23

Bevor wir weiter in die Bayesion Estimation eintauchen gilt es noch zwei
Begriffsklärungen zu machen:
/ Prior: Bezeichnet die Vermutung über die Parameter, bevor wir jegliche Daten
  beobachtet haben $p(theta)$
/ Posterior: Der Posterior bezeichnet nun Widerum wie gut ein Prior gewählt
  wurde bzw. wie unsicher wir uns in unserem Prior sind, nachdem wir neue
  Daten beobachtet haben $p(theta | D)$

Laut Bayes Theorem können wir diesen Posterior eben wie folgt ausrechnen:
$
  p(theta | D) = (p(D | theta) p(theta))/(p(D))
$

Durch gewisse Umformungen erhalten wir dazu noch folgende Formel zur Bestimmung
der Evidence $p(D)$:
$
  p(D) = integral p(D|theta)p(theta) dif theta 
  = integral L(theta) p(theta) dif theta
$

// Folie 27-29 sind sehr random. Laut Sprechstunde kann x hier beliebig sein.
// Ggf. später noch einbauen, gerade noch nicht so relevant.

// MLE betrachtet Parameter fix, Bayesian als Zufallsvariable

Häufig schreibt man zum Posterior auch noch folgendes:
$ "Posterior" prop "Prior" times "Likelihood" div "Evidence" $
#note[$prop$ heißt einfach proportianal, also $A prop B <=> A = k B$]

Wirklich etwas damit anfangen können wir nicht. Aber vielleicht hat es ja einen
nutzen #emoji.person.shrug

#note[Bayesian Estimation wurde hier nur sehr gebrochen und wahrscheinlich
unvollständig erklärt. Falls hier jemand noch was gutes zum ergänzen hat gerne
melden oder selbst machen und dann PR.]

Zuletzt noch die Begriffsklärung *Conjugate Priors*: Dies bedeutet lediglich,
dass die Verteilungen des Prior und des Posterior zur selben Familie gehören.
Also z.B. beide eine Normalverteilung haben.

= Maximum A-Posteriori

Jetzt haben wir aber nur darüber geredet, wie wir mit dem Posterior rechnen
können. Aber wie können wir nun überhaupt ordentlich einen Wert -- oder etwas
in die Richtung -- bestimmen? Dafür ist eben die Maximum A-Posteriori (MAP) 
Estimation da.

Also wie macht man das nun? Jeder der hier große bedenken hat wird gleich mit
großer trivialität enttäuscht:
$
  hat(theta)_"MAP" &= arg max_theta p(theta | D) \
  &= arg max_theta (p(D | theta) p(theta)) / p(D) \
  &= arg max_theta p(D | theta) p(theta) \
  &= arg max_theta log p(D | theta) + log p(theta) \
  (&= arg max_theta sum_(k=1)^n log p(x_k | theta) + p(theta))
$

Man beachte, dass wir den Nenner $p(D)$ einfach wegstreichen. Ich vermute mal,
dass dies den Grund hat, dass $p(D)$ unabhängig von $theta$ ist und somit über
$max$ ein konstanter, ignorierbarer Faktor ist.

Nun wird man feststellen, dass diese Formel recht ähnlich zur MLE aussieht.
Genauer kann MLE eine Form von MAP betrachtet werden, wobei allerdings der
Prior $p(theta)$ immer einen konstanten Wert annimmt. Also
$
  p(theta) = "const" => hat(theta)_"MAP" = arg max_theta log p(D | theta)
  + "const" eq.est hat(theta)_"ML"
$

= Supervised learning problems

Nun kommen wir ggf. mal etwas mehr in Richtung KI -- wenn auch nur sehr 
mathematisch.

Dafür können wir erstmal einen Grundsatz für KI aufstellen. In der
uns bisher bekannten Mathematik und Informatik ist es hauptsächlich so:
wir haben Eingabedaten $I$ und einen Algorithmus bzw. eine Funktion $f$ und
bestimmen damit die Ausgabedaten $O$. Nun kann es aber eben sein, dass diese
Funktion $f$ nicht so einfach realisierbar ist oder wir erst gar keine
Anhaltspunkte zur Realisierung haben. Dann haben wir eher den Fall, dass wir
bereits Beispiele an Input/Output Daten haben, aber keinen Anhaltspunkt, wie man
diese ordentlich bestimmt. Entsprechend gilt es nun also unsere Funktion $f$ zu
bestimmen.

#note[Dieser Absatz ist so nicht auf Jans Folien zu finden, sondern eher ein
eigener Abschweif. Über die Richtigkeit -- auch wenn das geschriebene eher
Philosophisch ist -- kann ich keine Garantien machen.]

Wir befinden uns hier bei supervised (de: beobachteten) Problemen. Das heißt
konkret, dass wir die Datenbereiche bereits kennen bzw. diese gekennzeichnet
(engl. labeled) sind, und nur unsere Funktion $f: I -> O$ bestimmen wollen.

Hier gibt es nun noch die folgende Unterscheidung:
/ Regression: Hierbei ist der Ausgabebereich $O$ stetig, besteht also aus
  unendlich durchgehenden Werten
/ Classification: Hierbei ist $O$ diskret, besteht also nur aus festen Werten

Jeweils ein Beispiel:
- Den genauen Notendurchschnitt für die Promi Klausur vorhersagen. Dies ist ein
  Regression Problem, da es (zumindest bis zu einem gewissen Grad) eine
  beliebige Zahl im Intervall $[1,5]$ sein kann.
- Die Anzahl der 1.0er der Promi Klausur zu bestimmen. Dies hingegen ist ein
  Classification Problem, da es nicht möglich ist eine 1.0 zu schreiben. \
  Ein passenderes Beispiel ist hier jedoch sowas wie die Einordnung bzw.
  Klassifizierung einer Mail als Spam oder nicht Spam. 

== Probabilistic Regression

Nun einmal verschiedene Methoden um bei Regression Problemen anhand von Daten 
eben solche Funktionen $f$ zu bestimmen. 

#dangerous[Dazu kommt im folgenden häufig Parameter $w$ vor. Diese kann man -- 
in Bezug auf KI -- auch als weights bezeichnen.]

=== Least Squares Linear Regression

Zuerst gucken wir uns die Least Squares Linear Regression an. Wie man ggf.
am Namen schon erkennen kann bekommen wir hier eine lineare Abschätzung.
Also eben eine Gerade $y = m x + b$ bzw. Ausgleichsgerade.

Wir haben nun folgende Daten beobachtet:
- Eingaben $cal(X) = {x_1,...,x_n | x_i in bb(R)^d}$
- Ergebnisse $cal(Y) = {y_1,...,y_n | y_i in bb(R)^k}$
#note[Im allgemeinen sind $d$ und $k$ hier beliebig. Im folgenden betrachten
wir nun den Fall $k=1$.]

Diese Daten ordnen wir in Paare $(x_i, y_i)$ für $i in {1,...,n}$

Dazu nehmen wir noch:
- Die uns unbekannten, zu bestimmenden Parameter $w$ in Form eines Vektor mit
  $d$ Elementen. Im Falle der Geradengleichung ist dies quasi unsere Steigung
  $m$.
- Und Skalar $epsilon_0$, dass für eine uns unbekannte Zufallsvariablen steht
  und zur Fehlerminimierung dient. Was analog das $b$ der Gerade ist.
  // Eigentlich n viele epsilon?

Dazu stellen wir dann für alle Paare $(x_i, y_i)$ folgende Gleichung auf:
$
  angle.l x_i | w angle.r + epsilon_0 = y_i
$
#note[$angle.l dot | dot angle.r$ bezeichnet das Skalarprodukt]

Nun wollen wir all diese Gleichungen nach $w$ auflösen.
+ #[
  Dafür stellen wir zuerst zwei Vektoren auf, die unsere Gleichung homogen
  machen:
  $
    hat(x)_i = vec(x_i, 1) quad hat(w) = vec(w, epsilon_0)
  $
]
+ #[
  Es ergibt sich:
  $
    angle.l hat(x)_i | hat(w) angle.r = y_i
  $
]
+ #[
  Zuletzt fassen wir alle unsere Gleichungen in eine große Gleichung zusammen.
  Dafür definieren wir zuerst die Matrix $hat(X)$ und den Vektor $y$:
  $
    hat(X) = mat(hat(x)_1, ..., hat(x)_n) quad y = (y_1, ..., y_n)^T
  $
  $hat(X)$ hat also $hat(x)_1$ bis $hat(x)_n$ als Spalten.
  
  Damit ergibt sich:
  $
    hat(X)^T hat(w) = y
  $
  Alternativ hätten wir auch $hat(X)$ Zeilenweise definieren können, dann
  müssten wir hier nicht transponieren.
]
+ #[
  Nun zum Herzstück dieser Methode: Wir wollen nun unsere Parameter $w$ so 
  wählen, dass die Differenz zwischen unseren Eingabepunkten $hat(X)^T w$ und
  den Ergebnissen $y$ zum Quadrat hin recht niedrig ausfällt.
  Also:
  $
    hat(w) = arg min_w abs(hat(X)^T w - y)^2
  $
  Dies gelingt eben durch Bestimmung der Extrempunkte des Gradienten über $w$:
  $
    gradient_w abs(hat(X)^T w - y)^2 = 0
  $
  Aber allgemein erhält man:
  $
    hat(X)^T hat(w) = y <=> hat(X) hat(X)^T hat(w) = hat(X) y <=>
    hat(w) = (hat(X) hat(X)^T)^(-1) hat(X) y
  $
]

Aber hieraus erhält man eben nur lineare Abschätzungen.

=== Polynomial Regression

Ohne jetzt auf genaue Lösungsstrategien einzugehen wollen wir uns trotzdem mal
den Ansatz angucken. Wir stellen nun folgende Gleichung auf:
$
  y(x) = angle.l w | Phi(x) angle.r = sum_(i=0)^n w_i Phi_i (x) quad "wobei" 
  quad Phi(x) = (1,x,^2,...,x^n)^T
$
$Phi_i (x)$ bezeichnet dabei das $i$-te Element des Vektors.

$n$ bezeichnet hierbei den gewünschten Grad des Polynoms. Dazu bleibt wie gesagt
die Herleitung von $w$ offen.

Man beachte, dass für zu große $n$ dieser Ansatz zu overfitting, also einer
zu sehr an den Datenpunkten orientierten Funktion, die nichtmehr direkt ein
Mittel aus den Punkten zieht sondern nur noch die Punkte selbst einbezieht.

#pagebreak()

TODO

#emoji.construction BIG TODO

MLE vs MAP:
MLE mit limitierten Daten ist gefährlich, da Varianz dann sehr niedrig. Somit 
ggf. Division durch 0. MAP hingegen durch Subjektivität robuster. 

Prior $p(theta)$ \
Likelihood $p(D | theta)$ \
Posterior $p(theta | D)$ \
Evidence $p(D)$

$p(theta,D)$ nonsense

p. 49
$D = cal(X) times cal(Y)$

w = parameters ???

p. 72: I = Einheitsmatrix

; steht für | aber mit Parametern

Auffrischen: Multivariate Gaußverteilung

; bindet stärker

p. 73:  $sigma_0$ Parameter über Gauss Prior $w$

p. 78: $lambda$ Kontroliiert wie sehr wir Daten vs Prior vertrauen. $lambda$
reduzieren erhöht komplexität \
Bessere Werte meist in $10^(-6)$ bis $10^(-8)$. $0.1N$ schon sehr hoch.


#table(
  columns: 3,
  [], $y in {0,1}$, $y in bb(R)$,
  "beobachtbar", "Classification", "Regression",
  "nicht beobachtbar", "Clustering", "Dimensionale Reduction"  
)
Alles auf probability density estimation reduzierbar
"beobachtbar": wir wissen den Zielraum und für Beispiele den Zielwert

p.94: x: Zeit bis Ausbruch, y: Dauer

p.95: eigentliche unbekanntheiten: Anzahl an Datenpunkten, Verteilung selbst,
Parameter

\\hat{xyz} steht für eine schätzung

Bishop: Deep learning networks