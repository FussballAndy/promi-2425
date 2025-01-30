#import "template.typ": *

#show: book-template.with(
  chapter: 5,
  version: "1.0",
)

= Experimental Design

Zuerst behandeln wir Experminete bzw. deren Aufbau. Die Motivation 
dahinter ist in Bezug auf Kapitel 4, dass wir eben Experimente brauchen,
um unsere Daten und damit unsere Parameter zu bestimmen. Im folgenden
werden wir uns also damit beschäftigen, wie ein guter Aufbau von
Experimenten aussieht.

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
unsere Hypothesen von der Form $H_0: theta = theta_0$, $H_1: theta != theta_0$ 
sind, können wir das ganze auch in folgendes verkürzen:
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
dass $sup_(theta in Theta_0) P (lambda (cal(D) <= c)) = alpha$.

// Fragen bisher: warum rejection region von ergebnissätzen, warum hier P eigtl.
// abhängig von theta


#emoji.construction TODO

S. 32 - 36 nicht relevant

S. 75: $hat(theta)_k (f)$ "Estimator"

S. 75: $f^((i))$ $(i)$ "Features"

Cross Validation: Erlaubt vor allem das Auswerten von anderen Daten
außerhalb unserer Parameter

