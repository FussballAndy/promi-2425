#import "template.typ": *

#show: book-template.with(
  chapter: 3,
  version: "1.0",
)

= Verteilungen

Gucken wir uns nun mal weitere Verteilungen an.

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
  haben. \
  Eine Zufallsvariable $Y$ hat also eine Binomialverteilung 
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
  Entsprechend weiter baut die *Poisson-Verteilung* auf der Binomialverteilung
  auf, wobei wir aber hier nun eher unendlich viele Zufallsvariablen bzw. eben
  nahezu unendlich viele Versuche in einem gegebenen Intervall betrachten
  wollen. Ziel dabei ist eine bessere Genauigkeit. \
  Eine Zufallsvariable $X$ hat also eine Poisson-Verteilung $X ~ "Poi"(lambda)$,
  wenn gilt:
  $
    P(X=k) = lambda^k/k! e^(-lambda)
  $
  Dabei ist $k$ entsprechend wieder die Anzahl an Variablen die "erfolgreich"
  sein sollen. $lambda$ gibt den Erwartungswert für das Intervall an.
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
der Menge $M$ ist.]

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

Für den Erwartungswert einer solch transformierten Variable gilt:
$
  expect[g(X)] = integral_(-infinity)^(infinity) g(x) f_X (x) dif x
$

Wie schon eben angesprochen kann man hierdurch nun eben sowas berechnen, wie
$expect[X^2]$, was dann eben zu 
$integral_(-infinity)^(infinity) x^2 f_X (x) dif x$ wird.

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
Zufallsvariablen. Also $display(S_n = sum_(i=1)^n X_i)$. Des weiteren
bezeichnet die Zufallsvariable $Z_n$ die normalisierte Version dieser
Zufallsvariable:
$
  Z_n = (S_n - expect[S_n]) / sqrt(variance[S_n]) quad "mit" 
  lim_(n -> infinity) F_Z_n (z) = P(Z_n <= z) 
  = 1/(2pi) integral_(-infinity)^z e^(-x^2 slash 2) dif x
$
Der letzte Teil der Formel ist dabei die konkrete CDF einer Normalverteilung
mit Erwartungswert $mu = 0$ und Standardabweichung $sigma^2 = 1$.


Im allgeminen gilt auch für die PDF $f$ einer Normalverteilung 
$cal(N)(mu,sigma^2)$:
$
f(x) = 1/(sigma sqrt(2pi)) exp (-1/2 ((x-mu)/sigma)^2)
$

Nun kann es etwas nervig sein immer wieder erwähnen zu müssen, dass eine
Funktion $f$ eine Normalverteilung ist. Entsprechend gibt es die Notation
$cal(N) (x | mu, sigma^2)$ um die Funktion der Normalverteilung mit
entsprechenden Parametern anzugeben.

Zudem ist der Grenzwert von $Z_n$ für beliebige Zufallsvariablen $X_i$ gleich,
solange eben der Erwartungswert und die Standardabweichung gleich sind und
alle Variablen unabhängig und gleichmäßig verteilt sind.

== Products and Quotients

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

= Maximum Entropy Distributions

// TODO: Sehr random reingeworfen und zu wenig ausgeführt.
Ab diesem Punkt ist es ggf. auch einmal ganz hilfreich zu erwähnen, dass die
Begriffe Zufallsvariable und Verteilung oft sehr stark Hand in Hand gehen.
Entsprechend reden wir auch im folgenden über die Entropie einer Verteilung,
obwohl wir diese eigentlich erstmal nur für Zufallsvariablen definiert haben.
(Wobei wir dort eigentlich auch eher die Verteilung $p$ für die konkrete
Berechnung nutzen.)

Nun betrachten wir den Fall, dass wir die genaue Verteilung nicht wissen. Das
einzige was wir darüber wissen, ist dass diese gewisse Einschränkungen
erfüllt. Nun kann in solch einem Fall eine Vielzahl von verschiedenen 
Verteilungen zur Auswahl stehen, die alle jeweils die Einschränkungen erfüllen.
Welche von diesen Verteilungen sollen wir also am besten wählen?

Laut dem Prinzip der maximalen Entropie (engl. Principle of Maximum Entropy) 
wählen wir dann am besten eine Verteilung mit einer möglichst hohen bzw. der
höchsten Entropie. Dadurch soll verhindet werden, dass bereits andere 
Informationen in die Verteilung einfließen. Intuitiv ist das auch ein sehr guter
Ansatz. Schließlich wissen wir nichts über die Verteilung und Entropie misst 
eben die Ungewissheit einer Verteilung, also kann es durchaus hilfreich sein
eine Verteilung mit maximaler Entropie zu wählen.

Zur Wiederholung: Die Formel von Entropie für eine steiuge Zufallsvariable $X$ 
bzw. deren Verteilung $p$ lautet wie folgt:
$
  Eta (p) = - integral p(x) log_2 p(x) dif x 
$

Nun wollen wir die Verteilung $p$ wissen, für die wir $Eta(p)$ maixmal bekommen.
Also
$
  arg max_p Eta (p) = arg max_p - integral p(x) log_2 p(x) dif x quad 
  "wobei" quad integral_a^b p(x) dif x = 1
$
Man beachte, dass selbst ohne weitere Einschränkungen trotzdem bereits die
Einschränkung, dass das Integral der übergebnen Funktion 1 ergibt -- diese also
eine valide PDF ist, vorhanden ist.

#note[$arg$ bezeichnet hierbei das entsprechende Argument des $max$. Genauer
also für welches $p$ eben diese maximale Verteilung angenommen wird. $max$
allein würde uns nur die höchstmögliche Entropie angeben.]

Nun wollen wir über einem Intervall $[a,b]$ und ohne weitere Einschränkungen
dieses Prinzip anwenden. Jan nutzt hier auf seinen Folien nun eine interessante
Herleitung, die aber wenig erklärt wurde. Diese zu verstehen würde überhaupt
erstmal ein Verständniss von Lagrangian benötigen. Also fassen wirs kurz, wir
erhalten, dass in solch einem Fall eine Uniforme Distribution mit Wsk. 
$p(x) = 1 slash (b-a)$ am besten geeignet ist bzw. am meisten Entropie hat.

#digression([Wie leitet man so etwas her?])[
  #let Lagrangian = math.cal("L")
  Wie bereits erwähnt nutzen wir hier maßgeblich den Lagrangian Multiplier bzw
  die Lagrange Funktion.
  Diese hilft uns den Maximalwert einer Methode unter gewissen Einschränkungen
  zu bestimmen.

  Als Vorbedingung für die Lagrange Funktion brauchen wir dann:
  - Eine Funktion $f$, über der wir das Maximum/Minimum bestimmen wollen und
  - eine Einschränkung $g$, wobei diese für alle Eingaben, eine konstante $c$
    annehmen soll. Also $g(x)=c$
  Dann sieht die Lagrange Funktion wie folgt aus:
  $
    Lagrangian (x,lambda) equiv f(x) + lambda (g(x) - c)
  $
  #sub[Man beachte, dass hier erneut sehr viel mehr Input in die "Funktion"
  fließt, als nur die eigentlichen Parameter -- wann funktionale Mathematik?] \
  Das $lambda$ ist hierbei der _Lagrange multiplier_. Was das genau ist kann
  ich gerade auch nicht sagen. Und ist weiter auch nicht relevant.

  Jan nutzt hierbei nun eine etwas abgewandelte Notation und schreibt $p(x)$
  mit in die "Funktion". Dies ist vermutlich zur Verdeutlichung, dass wir 
  hierbei eben über der Funktion $p$ maximieren wollen.

  Dazu kommt nun unsere in dem Fall einzige Einschränkung, der _normalization 
  constraint_ ins Spiel:
  $
    g(p) = integral_a^b p(x) dif x
  $
  und diese Einschränkung soll eben immer den Wert 1 ergeben. Also $g(p)=1$.

  Wir erhalten also:
  $
    Lagrangian (p(x),lambda_0) = - integral_a^b p(x) log_2 p(x) dif x +
    lambda (integral_a^b p(x) dif x - 1)
  $

  Leiten wir dies nun nach $p(x)$ ab und berechnen die Nullstellen erhalten wir:
  $
    diff / (diff p(x)) (p(x), lambda_0) = - log_2 p(x) - 1 + lambda_0 = 0 \
     =>p(x) = e^(lambda_0 - 1)
  $
  #note[Wir nutzen hier $diff$, da $lambda_0$ eben auch ein Parameter ist und
  wir somit bei Analysis in mehreren Dimensionen sind.]

  Setzen wir diese Funktion nun in unsere Einschränkung ein erhalten wir:
  $
    g(p) = integral_a^b e^(lambda_0 - 1) dif x &= 1 <=> \
    e^(lambda_0 - 1) integral_a^b 1 dif x &= 1 <=> \
    e^(lambda_0 - 1) (b-a) &= 1 <=> \
    e^(lambda_0 - 1) &= 1/(b-a)
  $

  Wir erhalten also $p(x)=1 slash (b-a)$.

  #sub[Ich hoffe mal dieser Crash Kurs hat einigermaßen geholfen.]
]

Dies kann man nun mal mit einigen Constaints durchspielen und dann erhält
man die Tabelle auf Seite 51. (Hab ich jetzt hier nicht abgetippt weil zu viel.)
_Support_ bezeichnet dabei wahrscheinlich noch den Bereich, auf dem diese 
Verteilung gültig ist.

Jan erwähnt hier noch Minimum Relative Entropy. Die Idee hier ist die
nächstbeste Verteilung $p$ zu einer Verteilung $q$ zu finden, die gewisse
Einschränkungen erfüllt. Dafür wird dann die KL-Divergenz aus Kapitel 2
genutzt. Genauer werde ich darauf jetzt allerdings nicht eingehen.

= Mixture Distributions

Die Inspiration hierfür: Wir haben nun 5 verschiedene Normalverteilugen
$p_k (x) = cal(N) (x | mu_k, sigma_k^2)$ für $k=1,2,...,5$. Nun wollen wir eine
Verteilung $p(x)$ haben, die all diese Verteilungen zu einer einzigen Verteilung
vereint.

Im allgemeinen geht das, indem man einen "gewichteten Mittelwert" aus den
Verteilungen nimmt. Oder auf gut deutsch: aufsummieren und mit Gewichten 
#sym.lt.eq 1 multiplizieren. \
Also: Für Verteilungen $p_0 (x|theta_0),p_1 (x|theta_1),...,p_K (x|theta_K)$
(ignoriert bis Kapitel 4 einfach das "$| theta_i$") ergibt sich
dann folgende _Mixture Distribution_:
$
  p(x) = sum_(k=1)^K pi_k p_k (x | theta_k) quad "wobei" quad 
  sum_(k=1)^K pi_k = 1 quad "und" quad 0 <= pi_k <= 1
$
#note[An sich muss es nichtmal unbedingt eine Summe sein, sondern kann jegliche
_konvexe_ Verknüpfung dieser Verteilungen sein.]

Hierzu betrachten wir noch _latent varaibles_. Dies sind Variablen, die nicht
direkt gemessen werden können, sondern die man erst nach Evaluation mehrerer
Messwerte konkret feststellen kann. Wikipedia nennt dazu ein recht schönes
Beispiel:
#quote(block: true, attribution: 
link("https://de.wikipedia.org/wiki/Latentes_Variablenmodell",
underline("Wikipedia")))[
  Ein Beispiel für eine latente Variable ist die Intelligenz. Sie kann nicht
  direkt gemssen werdne, aber aus einer Vielzahl von Testergebnissen ([den
  beobachtbaren Datenpunkten]) können eine oder mehrere hinter den
  Testergebnissen liegende latente Variablen (Intelligenz) extrahiert werden.
]
Im Beispiel von unserer mixture distribution wäre eben die Gewichtung eine
solche Variable. Wenn wir nur einen Datenpunkt betrachten können wir nicht 
direkt sagen, welche Gewichte die einzelnen Verteilungen haben, sondern erst
wenn man viele Datenpunkte betrachtet.

= Kernel Density Estimation

Zuletzt kommt noch ein Weg um eine PDF aus einer Menge an Datenpunkten
$D = {x_1,x_2,...,x_N}$ herleiten zu können.

Ein Ansatz wäre es nun erst einmal entsprechende PDF $p_k (x)$ mit einer
Normalverteilung $cal(N) (x_k | mu, sigma^2)$ aufzustellen. Dann kann man aus 
diesen PDF eine Mixture Distribution bilden, wobei alle Gewichte $1/N$ sind:
$
  f(x) = 1/N sum_(k=1)^N p_k (x) 
$

Dies kann man nun mit einem _density kernel_ $cal(K)$ verallgemeinern.
Für diesen gilt:
$
  cal(K): bb(R) -> bb(R)_+ quad integral cal(K) (x) dif x = 1 quad cal(K) (x)
  = cal(K) (-x)
$

Dazu nehmen wir noch eine Bandbreite (engl. bandwidth) $h$, welche die breite
des Kernels kontrolliert, bzw. bildlich die Funktion glatter macht:
$
  f(x) = 1 / (N h) sum_(k=1)^N cal(K) ((x - x_k) / h)  
$