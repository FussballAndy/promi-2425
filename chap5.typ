#import "template.typ": *

#show: book-template.with(
  chapter: 5,
  version: "1.0",
)

= Experimental Design

Zuerst behandeln wir Experimente bzw. deren Aufbau. Die Motivation dahinter ist 
in Bezug auf Kapitel 4, dass wir eben Experimente brauchen, um unsere Daten und 
damit unsere Parameter zu bestimmen. Im folgenden werden wir uns also damit 
beschäftigen, wie ein guter Aufbau von Experimenten aussieht.

1. Erkennung und Formulierung des Problems
2. Auswahl der relevanten Ergebniswerte
3. Auswahl der Faktoren (Eingabevariablen) und deren Werte \
  #sub[Dabei unterscheiden wir auch in un-/kontrollierbare Faktoren bzw.
  Variablen. Wobei wir dann die kontrollierbaren Variablen noch einmal
  unterteilen in Design Faktoren (welche, die wir ändern wollen) und
  Nuisance Faktoren (welche, die wir nicht ändern wollen weil sie zwar
  starken Einfluss haben, aber gerade nicht relevant sind.)]
4. Auswahl der Art des Experiments
5. Ausführung des Experiments
6. Statistische Analyse der Daten
7. Conclusion

= Statistische Auswertung der Daten

Zuerst einmal folgende Definitionen:

- *Hypothese*: Eine Hypothese ist eine Behauptung über einen Paramter bzw.
  Variable
- *Null Hypothesis*, *Alterntive Hypothesis*: Zwei Hypothesen über den
  gleichen Parameter, wobei diese sich wiedersprechen. \
  Wir schreiben: $H_0: theta in Theta_0$ und $H_1: theta in Theta_0^C$.
  Dabei ist $Theta_0$ eine Teilmenge der gesamten Parameter $Theta$.
- *Test*: In einem Test werden Daten ausgewertet und basierend darauf
  entschieden, welche der beiden Hypothesen wahr ist. Dazu nutzt man
  meist auch noch eine _rejection region_ $R$.
- *Test statistic*: Eine test statistic $T: E^N -> bb(R)$, wobei $E$ der
  Ergebnisraum des Tests ist, welche die Testergebnisse in eine
  reelle Zahl zusammenfassen.

Basierend darauf sieht der Ablauf eines Tests wie folgt aus:

1. Vermutung über Verteilung aufstellen $X tilde P_theta$
2. Null Hypothese aufstellen $H_0$
3. Test Statistik aufstellen $T: cal(X)^N -> bb(R)$
4. Rejection region $R subset bb(R)$ auswählen, wobei die Wsk., dass ein 
  Wert rejected wird minimal unter der Null Hypothesis sein sollte.
  $
    P(T(X_1,...,X_N) in R) <= alpha
  $
  $alpha$ nennen wir hierbei _significance value_

Und nun betrachten wir einmal verschiedene Methoden zur Auswertung von
Testergebnissen.

== Likelihood Ratio Test

Zuerst erinnern wir uns zurück an Likelihood:
$
  L(theta | x_1,x_2,...,x_N) = L(theta | cal(D)) = p(cal(D) | theta)
    = product_(i=1)^N p(x_i | theta)
$
#note[Wir nutzen hier den unüblichen Syntax $L(theta | cal(D))$ für Likelihood. 
Fragt nicht warum. Zudem bringt dies wieder eine i.i.d. Anforderung an die
Testergebnisse]

Dadurch stellen wir nun ein Likelihood Ratio auf, welches prüft, wie 
wahrscheinlich es ist, dass wir gerade die Null Hypothesis testen.
$
  lambda (cal(D)) = (sup {L(theta | cal(D)) : theta in Theta_0})
    / (sup {L(theta | cal(D)) : theta in Theta})
$
#note[Hier genutzte Notation für $sup$ ist nicht einheitlich mit der von den 
Folien. Zudem nutzt Jan hier eigentlich $x$ für die Daten.]

Ein Likelihood Ratio Test ist nun ein Test, bei dem primär Ergebnisse in
${cal(D) : lambda (cal(D)) <= c}$ mit $0 <= c <= 1$ verworfen werden. \
#sub[In den Folien steht hier was von rejection region. Allerdings macht es
wenig Sinn, dass unsere rejection region aus einzelnen Datensätzen besteht.]

*Normalverteilte Ergebnisse und simple Hypothesen*: \
Falls unsere Daten aus einer Normalverteilung $cal(N)(theta,1)$ stammen und 
unsere Hypothesen von der Form #box($H_0: theta = theta_0$), 
$H_1: theta != theta_0$ sind, können wir das ganze auch in folgendes verkürzen:
$
  lambda (cal(D)) = L(theta_0 | cal(D)) / L(hat(theta) | cal(D))
  = exp {(-n (overline(x) - theta_0)^2) / 2}
$
Dabei ist $hat(theta) = arg sup_(theta in Theta) L(theta | cal(D))$ per MLE 
bestimmt. Und da wir somit $Theta_0 = {theta_0}$ ist können wir dieses direkt
einsetzen. (Herleitung zu letztem Teil auf den Folien)

Damit erhalten wir dann, dass alle Ergebnisse aus
${cal(D) : |overline(x) - theta_0| >= sqrt(-2(log c) slash n)}$ abgelehnt
werden sollten.

#v(2em)

Zudem kann man mittels LRT _"size $alpha$" LRT_ formen, indem man $c$ so wählt,
dass $sup_(theta in Theta_0) P (lambda (cal(D)) <= c) = alpha$.

// Fragen bisher: warum rejection region von ergebnissätzen, warum hier P eigtl.
// abhängig von theta

== Gaussian Z-Test

Mittels dem Gaussian Z-Test können wir vor allem Hypothesen über Normalverteilte
Daten testen. Dabei testen wir ob der Erwartungswert einen gewissen Wert
annimmt. Die Standardabweichung hingegen muss fest gewählt bzw. bekannt sein.

#note[Entsprechend nimmt in einem Z-Test die test statistic auch eine
Normalverteilung an.]

Zur Hilfe führen wir zuerst die Variable $z_alpha$ ein. Diese gibt an, dass eine
Normalverteilte Zufallsvariable mit Wsk. $alpha$ größer als $z_alpha$ ist.
$
  Z ~ cal(N) (0,1) quad "und" quad P(Z > z_alpha) = alpha
$

Zuerst noch zwei Bedingungen:
1. Unsere Daten müssen dann entsprechend aus einer Normalverteilung stammen, 
  also $X_1,...,X_N ~ cal(N) (mu, sigma_0^2)$ (dies sorgt auch für i.i.d.). 
  $sigma_0$ muss erneut konstant sein.
2. Unsere null hypothesis muss eine der folgenden Formen haben:
  $
    (i) H_0: mu = mu_0, quad (i i) H_0: mu <= mu_0, quad (i i i) H_0: mu >= mu_0
  $

Für die test statistic stellen wir folgende Formel auf:
$
  Z = T(X_1,...,X_N) = (sqrt(N))/sigma_0 (accent(X, macron) - mu_0) quad "mit"
    quad accent(X, macron) = 1/N sum_(n=1)^N X_n
$

Bei unserer rejection region können wir uns einen aus folgenden 3 Fällen
aussuchen:
#grid(columns: (1fr,)*3, align: center)[
  Two-sided

  $R:={z in RR : |z| > z_(alpha slash 2)}$

  $p = 2 min {1-F(Z), F(Z)}$
][
  Left-sided

  $R:= {z in RR : z > z_alpha}$

  $p = F(Z)$
][
  Right-sided

  $R := {z in RR : z < z_alpha}$

  $p= 1-F(Z)$
]

#note[Für Visualisierungen der drei Fälle am besten auf die Folien schauen. F
ist hierbei die CDF der Normalverteilung.]

Diese Fälle geben dann an, welche Ausreiser wir ablehnen. Heißt ob wir 
Hypothesen ablehnen, bei denen der Erwartungswert in eine der beiden Richtungen
abdriftet, oder eben nur nach links/rechts. \
$p$ ist hierbei der sogenannte p-value. Dieser wandelt unsere test statistic
wieder in eine Wsk. um, sodass wir diese dann mit $alpha$ vergleichen können,
um zu bestimmen, ob wir die null hypothesis annehmen/ablehnen. Gilt also
$p < alpha$, bzw. $alpha/2$ im two sided, lehnen wir die null hypothesis ab.

Und damit können wir dann unseren Z-Test durchführen.

Wenn wir allerdings die Standardabweichung unserer Daten nicht wissen, kommen
wir mit dem Z-Test nicht weiter. Dafür gibt es dann aber andere Arten, wie z.B.
den Student's T-Test (siehe Übung dafür).

== A/B Testing

Dazu sei auch noch einmal kurz A/B Testing angesprochen. Hier testen wir
effektiv zwei Varianten: A und B, und vergleichen die Ergebnisse. Dies kann
heißen, dass wir die Nutzer in zwei Gruppen unterteilen und jeweils die eine
bzw. andere Sache testen. Man könnte dies aber auch so sehen, dass zuerst
alle Nutzer in Gruppe A sind und dann nach einer Weile alle Nutzer in Gruppe B
gewechselt werden. Wichtig ist hier jedoch, dass die Nutzer i.i.d. in die
Gruppen eingeteilt werden. Mehr hierzu aber auch in der Übung.

== Fehler in Hypothesis Testing

Leider ist nicht alles fehlerfrei. Beim Testen unterscheiden wir dabei speziell
folgende Fälle:

#let vert(c) = rotate(-90deg, c, reflow: true)

#align(center, block(width: 50%, breakable: false, table(
  columns: (auto,auto,1fr,1fr),
  stroke: (x,y) => if x > 1 or y > 1 { 1pt },
  align: center + horizon,
  [], [], table.cell("Reality", colspan: 2),
  [], [], "Positive", "Negative",
  table.cell(vert[Study findings], rowspan: 2), 
  vert[Positive], [True positive], [False positive \ #sub[Type I Error]],
  vert[Negative], [False negative \ #sub[Type II Error]], [True negative]
)))

Um Type I Error zu reduzieren können wir das _significance level_ $alpha$
reduzieren. Dies erhöht allerdings die Wsk. auf Type II Error. \
Für statistiche Behauptungen ist z.B. $alpha <= 0.05$ relevant. Mittlerweile
wollen aber viele, dass dieser Wert weiter auf $alpha <= 0.005$ runtergesetzt
wird, da trotzdem noch zu viele Falschaussagen entstehen.

Um wiederum Type II Error zu reduzieren müssen wir die sample size erhöhen,
also mehr testen.

// TODO: Student's t test

= Evaluation

Nachdem wir nun mittels Experiment unser Modell aufgestellt haben, gilt es nun
noch zu überprüfen, dass dieses nicht ggf. doch unpassend ist. Es also z.B.
zu genau die gemessenen Datenpunkte beschreibt, dafür aber an allen anderen
Punkten unbrauchbar ist.

Dazu kann man bereits einmal folgendes festhalten: es reicht nicht einen
niedrigen Training Error zu haben, sondern man sollte dazu auch noch einen
niedrigen Testing Error haben. Dafür braucht man eben einen (kleineren)
Datensatz, der ausschließlich zum testen genutzt wird, und der disjunkt mit
dem Trainings Datensatz ist.

Aber was ist nun das beste Modell? \
Dies ist leider nicht gerade trivial. Ein Ansatz ist allerdings Occam's Razor:
laut diesem sollen wir das simpelste Modell nehmen, welches unsere Daten gut 
abdeckt. "Simpelste" heißt hier das Modell mit der niedrigsten Komplexität. Wie 
genau man Komplexität beschreibt oder misst wird hier nicht erwähnt. Man kann 
sich diese allerdings stark als die Hyperparameter der einzelnen Fitting 
Methoden vorstellen. Also z.B. den Grad des Polynoms bei linear regression oder 
der Anzahl an Clustern beim Clustering.

Speziell fürs Clustering gibt es aber noch andere Methoden:
- #[
  Elbow Method:

  Die gesamte within-cluster sum of square (WSS) in relation zur Anzahl an
  Klustern plotten. Dabei wird es dann einen sog. "elbow point" geben. Dieser
  ist quasi der Punkt ab dem die Kurve stark abflacht. Dieser Punkt gibt dann
  die optimale Anzahl an.
]
- #[
  Gap statistics:

  Diese Methode baut wieder etwas mehr auf Vermutung auf. Hier stellt man eine
  test statistic und Null Hypothese um den Erwartungswert für die \#Kluster auf
  und vergleicht die Wsk. Verteilung dieser Null Statistic mit WSS. #sub[Aber
  genaueres kann ich hierzu auch nicht sagen.]
]

Allerdings sollte man hier alles als kritisch betrachten. Denn z.B. im Falle
von deep learning gibt es das Phänomen "double descent". Dieses besagt im
groben, dass zwar der Test error, wenn sich die Anzahl der Parameter der Anzahl
an Datenpunkten annähert, steigt. Wenn man allerdings noch mehr Parameter wählt
sinkt der Test error auf einmal noch stärker und man erhält ein noch genaueres
Modell.

== Model Validation

Nun betrachten wir die Model Validation, also das überprüfen, dass unser Modell
sinnvoll ist. Bzw. finden des sinnvollsten Modell. Dazu nehmen wir uns unser 
aktuelles Modell $f_theta$. Dabei beschreibt $theta$ die Parameter des Modell.

#note[Modell heißt hier nicht unbedingt nur die Parameter, sondern ggf. auch
grundlegend die Funktion, also z.B. ob es ein Polynom ist etc. und dazu dann
auch Hyperparameter wie den Grad des Polynoms.]

Für eine ordentliche Validierung müssen wir unseren Datensatz in drei Teile
unterteilen:

#let datasetbox(color, body) = box(fill: color.lighten(60%), inset: 2mm, 
  width: 100%, radius: 2pt, stroke: color, body)

#align(center, block(width: 60%, grid(
  columns: (1fr, ) * 4, column-gutter: 5pt,
  grid.cell(colspan: 2, datasetbox(blue, "Training set")),
  datasetbox(green, "Validation set"),
  datasetbox(fuchsia, "Test set")
)))

Diese haben folgende nutzen:
- Training set: Damit passen wir den Parameter $theta$ unseres Modells an
- Validation set: Gucken, ob das gewählte Modell $f$ überhaupt sinnvoll ist und
  ggf. Hyperparameter anpassen
- Test set: Am Ende das Modell noch einmal mit ganz frischen Daten testen

Dabei findet Validaten noch eher während der Trainingsphase statt während
Testing wirklich erst ganz am Ende durchgeführt wird. Zudem müssen all diese
Datensätze disjunkt sein. Nachdem wir allerdings mit dem aktuellen test set
getestet haben, müssen wir, sofern wir noch weiter trainieren wollen, ein neues
test set holen.

Wir betrachten dazu nun den Cross Validation Ansatz: \
Teile in jeder Iteration den gesamten Datensatz $cal(D)$ in $K$ gleich große 
Teile auf. $cal(D)_1,...,cal(D)_(K-1), cal(D)_K$. Dabei sind $cal(D)_1$ bis 
$cal(D)_(K-1)$ training sets und $cal(D)_K$ unser validation set.
- Mit den training sets können wir unsere Parameter bestimmen
- und mit dem validation set können wir unser Modell validieren:
  $
    L_k (f_theta) = sum_((x,y) in D_K) cal(L) (f_theta (x),y) 
  $
Dies wird nun mit jeder möglichen Partition gemacht, was sehr aufwändig ist.
Dafür haben wir dann allerdings eine gute Bewertung unseres Modells bzw. ein
gutes Modell.

Wenn man seine Lebenszeit/Stromrechnung etwas mehr wertet, kann man auch K-fold
Cross Validation nutzen.

*K-fold Cross Validation*: \
Hier teilen wir unsere Daten in $K$ gleich große Mengen, sog. "folds". In jeder
Iteration nehmen wir dann einen anderen von diesen Folds als validation set
und den Rest als training set.

Damit bekommen wir dann folgendes für das optimale Modell:
$
  f^* = arg min_(f in cal(M)) 1/K sum_(k=1)^K L_k (f)
$

== Bias & Variance

#let bias = math.op("bias")
#let var = math.op("var")

#sub[Kann sich hier noch wer daran erinnern, was Aleatoric und Epistemic 
Uncertainty war? Nein? Gut ich auch nicht.]

/ Aleatoric: Unsicherheit wegen allgemeiner Zufälligkeit eines Events
/ Epistemic: Unsicherheit wegen fehlendem wissen

Um dies noch einmal zu vertiefen gucken wir uns nun den Bias & Variance tradeoff
an.

Hier auch erst einmal wieder Begriffsklärung. Dazu nehmen wir unser geschätztes
Modell $hat(f)_cal(D)$ über den Daten $cal(D)$ und das wahre Modell $f$.

/ bias: die erwartete Abweichung von unserem wahren Modell gemäß den Daten
  $
    bias(hat(f)_cal(D)) = expect_cal(D)[hat(f)_cal(D) - f]
  $
/ variance: wie davor auch schon ist dies eben einfach die Varianz des 
  geschätzten Modell, allerdings nur gemäß den Daten.
  $
    var(hat(f)_cal(D)) = expect_cal(D)[(hat(f)_cal(D) - 
      expect_cal(D)[hat(f)_cal(D)])^2]
  $

#dangerous[Jan definiert das ganze eher über den estimator bzw. dem Parameter.
Sollte aber denke ich mal keinen großen Unterschied machen.]

Weicht unser erwartetes Modell von dem wahren ab 
($expect_cal(D)[hat(f)_cal(D)] != f$), so nennen wir unser Modell _biased_.
Ansonsten _unbiased_. 

Ein estimator, der null bias und minimale Varianz hat, nennen wir _minimum
variance unbiased estimator_ (MVUE). Ist solch ein estimator noch linear in
seinen Parametern nennen wir diesen _best linear unbiased estimator_ (BLUE).

Solch ein MVUE wäre nun erwünschenswert, ist aber leider nicht so einfach.

#emoji.construction TODO

S. 32 - 36 nicht relevant

S. 75: $hat(theta)_k (f)$ "Estimator"

S. 75: $f^((i))$ $(i)$ "Features"

Cross Validation: Erlaubt vor allem das Auswerten von anderen Daten
außerhalb unserer Parameter

