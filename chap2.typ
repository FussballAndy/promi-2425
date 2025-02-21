#import "template.typ": *
#import "@preview/fletcher:0.5.5" as fletcher: diagram, node, edge

#show: book-template.with(
  chapter: 2,
  version: "1.0.1",
)

#let source = math.accent("X", math.macron)
#let channel = math.accent("K", math.macron)

= Information

Zuerst einmal sollte man klären, was Information überhaupt ist. In der 
Informationstheorie (engl. Information Theory) bezeichnet Information das 
Wissen, welches ein Absender durch einen Informationskanal an einen Empfänger
vermittelt. Dazu ist es noch wichtig zu erwähnen, das Information und Daten 
nicht das gleiche sind.

Die Informationstheorie beschäftigt sich stark mit der Übertragung, 
Verarbeitung, Extrahierung und Verwertung von Informationen. Sie wurde stark 
von Claude Shannon vorangetrieben. Denn dieser hat vor allem Bits als Einheit
gewählt, wodurch seine Arbeit gut auf heutige Rechnersysteme übertragbar ist.  

Eben wurde bereits der Informationskanal (engl. Information Channel) erwähnt,
hier eine Beschreibung des Aufbau:
- Daten fließen von einem Sender zu einem Empfänger
- Der Sender kodiert die Nachricht
- Die Nachricht fließt durch einen störenden Kanal, der ggf. unreinheiten in die
  Nachricht bringt
- Der Empfänger erhält die Nachricht und dekodiert diese. Daraus kann er dann
  informationen basierend auf der Nachricht erhalten.

#align(
  center,
  diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    spacing: 5em,
    node((0,0), [Sender], height: 3em),
    edge("-|>"),
    node((1,0), [Kodierer], height: 3em),
    edge("-|>"),
    node((2,0), [(störender) \ Kanal], height: 3em),
    edge("-|>"),
    node((3,0), [Dekodierer], height: 3em),
    edge("-|>"),
    node((4,0), [Empfänger], height: 3em)
  )
)

Was uns aber vor allem auch in der Informationstheorie interessiert ist der 
Aspekt der Überraschung (engl. Surprise). Dies ist auch maßgeblich unsere 
Definition von Information bzw. $I(x)$. \
Weniger wahrscheinliche Ereignisse sind überraschender. Entsprechend hat man 
auch mehr Information, wenn die Überraschung größer ist.

Wenn man nun zwei Nachrichten vergleicht:
+ The program terminated due to an error
+ The program terminated with Error Code 3
Dann kann man sich ableiten, dass die 2. Nachricht mehr Informationen enthält,
da sie weniger zu erwarten war. Für die Erwartung spielt es hier demnach auch
eine Rolle, wie divers die Nachricht sein kann. Im Falle von Nachricht 1 gibt
es nur 2 Möglichkeiten: Fehler und kein Fehler. Hingegen in Nachricht 2 gibt es
deutlich mehr Möglichkeiten: Error 0, 1, 2, .... Da also die Nachricht
"Error Code 3" unerwartbarer war, enthält diese entsprechend mehr Information.

Kommen wir also nun konkret zur Bestimmung von Information:

#definition("Absender (Information Source)")[
  Ein *Absender* #source ist ein Tupel $(cal(X), p)$, wobei 
  $cal(X)$ die Menge der möglichen Nachrichten ist und $p:cal(X)->bb(R)$
  eine Funktion, die die Wsk. angibt, dass eine Nachricht $x in cal(X)$ 
  gesendet wurde.

  Ist $x$ eine Nachricht mit einer Wsk. $p(x)>0$, dann ist die Information, die
  $x$ beinhaltet:
  $ I(x) = log 1/p(x) = -log p(x) $ 

  Zudem nennt man einen Absender _stationary_, wenn $cal(X) != emptyset$, 
  $forall x in cal(X): p(x)>0$ und $display(sum_(x in X) p(x))=1$ gilt.

  #dangerous[Information scheint nicht direkt nur zur konkreten Messung von
  Informationen einer Nachricht zu sein, sondern viel mehr auch eine Bestimmung
  einer möglichen Kodierung einer Nachricht. Entsprechend ist die Einheit von
  Information auch Bits]

  #note[Das $p$ hier ist semi zusammenhängend mit der PMF, die in Kapitel 1 
  vorgestellt wurde. Man kann es wieder als die PMF sehen und damit eine 
  Zufallsvariable $X$ als eine zu erhaltende Nachricht ansehen, wobei man die 
  Wsk. 
  herausfinden will, dass diese die Nachricht $x$ ist. Außerdem wird für den 
  Logarithmus -- speziell im Kontext von Shannon -- meist die Basis 2 
  verwendet. 
  Eine genaue festlegung muss dort aber laut meiner Kenntnis nicht getroffen 
  werden.]
]

// box, da sonst blödes page breaking. Ggf. bei neuem layout zu block
#digression([Warum der Logarithmus], breakable: false)[
  Man fragt sich nun vielleicht, warum hier der Logarithmus genutzt wurde und 
  nicht einfach nur $1 \/ p(x)$. \
  Das erste Problem wäre, dass die Information einer Nachricht die immer 
  auftritt ($p(x)=1$) dann $1 slash 1 = 1$ wäre, diese Nachricht aber 
  eigentlich 
  gar keine Information enthält. Des weiteren hat Shannon Information genutzt 
  um 
  die Anzahl an Bits zu berechnen, die benötigt werden, um eine Nachricht $x$ 
  zu 
  kodieren. Das Ziel dabei ist häufigere Nachrichten mit weniger Bits zu 
  kodieren und seltenere Nachrichten mit mehr Bits. 

  Eine nun berechtige Frage ist: Warum sollte ich gewisse Nachrichten kürzer
  kodieren wollen als andere? Man kann ja schließlich einfach die Anzahl der 
  Nachrichten $n=|cal(X)|$ nehmen, dann den Logarithmus davon nehmen 
  $b = log_2 n$. Dann hat man auch eine Anzahl an Bits, mit der man sogar jede 
  Nachricht aus $cal(X)$ kodieren kann. (Natürlich noch angepasst auf Bytes da 
  kein Rechner heutzutage ordentlich mit Bits arbeitet). 
  Jeder der nun InfMan gehört hat sollte aber ein recht alltägliches 
  Gegenbeispiel kennen wo das nicht so ist: Die Kodierung von Texten, speziell 
  z.B. UTF-8. \
  Zur Aufklärung: In UTF-8 besteht ein Text erstmal aus einer Liste an Byte 
  (8 Bits). Da man aber in einem Byte nur 256 Zeichen kodieren könnte werden 
  für 
  _seltenere_ Zeichen entsprechend mehr Byte zur Kodierung genutzt. So kann ein 
  einzelnes Zeichen in UTF-8 1-4 Byte groß sein. Und welche Zeichen sind nun nur
  mit einem Byte kodiert? Eben die, die bei uns im Alltag am häufigsten 
  vorkommen: a-z,A-Z,0-9,Punktationen etc. Hingegen ein Zeichen wie 'ä', 
  welches 
  (zumindest im Englischen) nicht so häufig vorkommt wird mit 2 Byte kodiert. 
  Das bringt eben den Vorteil, dass viele Nachrichten dadurch deutlich weniger 
  Speicher benötigen. Würde man alle Zeichen mit 4 Byte kodieren, würde ein 
  Text 
  wie `"Hello world!"` 48 Byte benötigen, während er so nur 12 Byte benötigt.
]

Fairerweise ist dieser Exkurs ein wenig ausgeartet. Falls man allerdings noch 
etwas mehr zum Verständnis von Information bzw. der Formel dahinter lesen will, 
kann ich den folgenden Artikel (oder zumindest die ersten beiden Abschnitte) 
sehr empfehlen:
https://randompearls.com/science-and-technology/mathematics/information-theory-rationale-behind-using-logarithm-entropy-and-other-explanations/

#definition("Entropie (Entropy)")[
  *Entropie* ist die Messung der Ungewissheit, welche möglichen Werte eine 
  Zufallsvariable $X$ annehmen kann. Dabei ist sie auch ein Maß für den 
  erwarteten Informationsgehalt der Nachrichten eines Absenders.

  Für eine diskrete Zufallsvariable $X$ über einer Menge an Nachrichten 
  $cal(X)={x_1, x_2, ..., x_n}$ eines Absenders #source wie folgt beschreiben:
  $ 
    Eta(X)=sum_(i=1)^n p(x_i) I(x_i) = 
      sum_(i=1)^n p(x_i) log 1/p(x_i) = 
      - sum_(i=1)^n p(x_i) log p(x_i) =
      expect[I(X)]
  $

  #sub[Fragt bitte nicht warum auf Jans Folie das $n$ auf einmal zu $N$ wird]

  Da sich Entropie maßgeblich aus Information zusammensetzt ist die Einheit
  davon wieder Bits.

  #note[$Eta$ IST KEIN GROSSES h SONDERN EIN GROSSES `Eta`]
]

#definition("Differential Entropy (kurz: DE)")[
  Die differentielle Entropie erweitert das Konzept von Entropie auf stetige
  Zufallsvariablen. Da stetige Zufallsvariablen allerdings andere Eigenschaften
  haben wie diskrete Zufallsvariablen gilt hier ein wenig Vorsicht.
  (Z.B. kann die PDF $>1$ sein oder aber die DE $<0$)

  Die Entropie einer stetigen Zufallsvariable über einer Menge an Nachrichten
  $cal(X)$ lautet also wie folgt:
  $
    Eta(X) = integral_(x in cal(X)) f(x) I(x) dif x =
      integral_(x in cal(X)) f(x) log 1/f(x) dif x =
      - integral_(x in cal(X)) f(x) log f(x) dif x =
      expect[I(X)]
  $

  #note[Man beachte, dass im Rahmen von stetigen Zufallsvariablen die 
  Information an sich auch die PDF nutzen sollte und nicht die PMF. Zudem
  scheint man teilweise $h$ als Symbol für die DE zu nutzen]
]

Jetzt haben wir uns also der Definition des Absenders, der Kodierung 
(Information) und nun durch Entropie dem Empfänger befasst. Nun fehlt noch das 
Herzstück von Informationskanälen und das ist der Kanal selbst:

#definition("Kanal (Channel)")[
  Ein *Kanal* #channel ist ein Tupel $(A,B,q_K)$ wobei
  - $A != emptyset$, $B != emptyset$ und
  - $q_K: A times B -> [0,1]$ mit $forall a in A: sum_(b in B) q_K(a,b)=1$ \
  
  $q_K$ ist dabei die sogenannte _channel transition function_, welche uns die
  Wsk. gibt, dass ein Symbol $a$ bei Durchgang durch den Kanal zu einem Symbol 
  $b$ mutiert.

  Die Aufgabe eines Kanals ist es Nachrichten zu übermitteln, dabei können aber
  Fehler auftreten. Wenn in einem Kanal eben solche Fehler auftreten können
  nennen wir diesen auch störend (?, engl: noisy).

  #note[Der Begriff _channel transition function_ scheint zumindest laut einer
  kurzen Google Suche nicht gerade geläufig zu sein.]
]

*Eigenschaften von Kanälen:*

#notation-table(table(
  columns: (auto, 1fr),
  table.header([Begriff], [Bedeutung]),
  [Binary symmetric channel (BSC)], [Ein BSC ist ein Kanal, in dem jedes
  übertragene Bit eine Wsk. von $r$ hat geflippt zu werden ($0->1, 1->0$)],
  [Binary erasure channels (BEC)], [Ein BEC ist ein Kanal, in dem jedes
  übertragene Bit eine Wsk. von $r$ hat gelöscht zu werden. Der Empfänger
  weiß dann, dass ein Bit fehlt, aber nicht welchen Wert dieses hatte.],
  [Transinformation], [Die Transinformation misst die Gemeinsamkeit zwischen
  dem Eingang $X$ und dem Ausgang $Y$ eines Kanals.],
  [Channel Capacity], [Die Kanalkapazität gibt den maximalen Durchsatz an Daten
  an, die durch den Kanal mit relativ kleiner Fehler Wsk. übertragen werden
  können.]
))

= Rechnen mit Information

#definition("Joint Entropy")[
  Die *Joint Entropy* gibt an, wie viele Bits bzw. Einheiten an Information wir
  benötigen, um das Ergebnis von zwei Zufallsvariablen zu kodieren. Dabei gibt
  sie dann gleichzeitig auch die Ungewissheit über die Werte der beiden
  Variablen an.

  Für zwei Zufallsvariablen $X$, $Y$ über den Mengen $cal(X)$, $cal(Y)$ ist die 
  Joint Entropy wie folgt definiert:
  $ Eta(X,Y) = sum_(x in cal(X)) sum_(y in cal(Y)) p(x,y) log 1/p(x,y) $

  #note[Jan scheint in seinen Folien $X$ als die Eingangs und $Y$ als die 
  Ausgangs Nachricht zu bezeichnen. Im allgemeinen scheint man dies aber nicht
  direkt so zu klassifizieren. Dies scheint eher im Kontext davon zu sein, dass
  Jan dies nutzt um auf die Kanalkapazität hinzuarbeiten.]
]

Jan führt hier nun die *Marginal Distribution* ein. Diese ist aber quasi analog
zu Marginal Probability aus Kapitel 1. Daher werde ich hier nicht weiter drauf
eingehen.

#definition("Mutual Information")[
  *Mutual Information* $I(X;Y)$ misst, wie viel Information sich zwei 
  Zufallsvariablen $X$ und $Y$ teilen. Entsprechend sagt sie auch aus, wie viel
  wir über $X$ wissen, wenn wir den Wert von $Y$ kennen.

  $
    I(X;Y) = Eta(X) + Eta(Y) - Eta(X,Y) = sum_(x in cal(X)) sum_(y in cal(Y))
    p(x,y) log (p(x,y)/(p(x)p(y)))
  $
]


#box[ // Box für layout Gründe
Nachdem wir also diese drei Definitionen hinter uns haben können wir nun zur
Formel für die Kanalkapazität kommen. Hierbei ist nun zu beachten, dass $X$
der Eingang in den Kanal und $Y$ der Ausgang aus dem Kanal ist:
$
  C = max_p(x) I(X;Y) = Eta(Y) - Eta(Y|X)
$
Der Grund warum wir hier $display(max_p(x))$ schreiben, ist dass wir das Maximum
von $I(X;Y)$ über allen möglichen Werten $p(x)$ bzw. allen möglichen 
Verteilungen bekommen wollen.
]

= Kodierungsstrategien

#definition("Block Coding")[
  Bei der *Block Kodierung* wird die Nachricht in Blöcke mit fester Größe
  kodiert. Dadurch kann die Fehlererkennung und Korrektur vereinfacht werden, da
  man redundante Informationen hinzufügen kann.

  *Kodierung:* Jeder Block mit $k$ Informations Bits wird in einen Block mit $n$
  Bits umgewandelt, wobei $n > k$.

  *Informationsrate (Code Rate):* $R=k/n$. Höhere Redundanz -- entsprechend
  kleineres $R$ -- verbessert die Fehlerkorrektur.

  #note[Die Informationsrate gibt an, welcher Anteil der kodierten Nachricht
  tatsächlich der Inhalt der ursprünglichen Nachricht ist.]

  *Fähigkeit zur Fehlerkorrektur:* Fehler können durch den Abgleich mit dem
  originalen Block erkannt werden. #sub[Dafür muss man allerdings Einsicht
  in sowohl Eingang als auch Ausgang haben.]
]

#definition("Convolutional Coding")[
  Bei der *Convolutional Kodierung* werden die einzelnen Bits einer Nachricht
  basierend auf vorherigen und nachfolgenden Bits kodiert. Dadurch kann
  stetig auf Fehler geprüft werden, was vor allem bei Echtzeitübertragungen 
  sehr hilfreich ist.

  *Kodierung:* Lässt eingabe Bits durch Shift Register gehen und erstellt dann
  mittels diesen Bits und den aktuellen Eingabe Bits entsprechende Ausgabe Bits.

  *Einflusslänge (Constraint Length):* Gibt an, wie viele Register die Eingabe
  durchgehen muss.

  *Informationsrate:* Ähnlich wie bei Block Kodierung $R=k/n$.
  #sub[Wobei wir hier erstmal nicht wirklich $k$ und $n$ eingeführt haben]
]

= Mehr Entropie

Analog zu Ereignissen kann man auch bei Entropie konditionale Abhängigkeit 
haben. So kann das wissen eines Wertes die Unsicherheit über den anderen
reduzieren.

#definition("Konditionale Entropie (Conditional Entropy)")[
  Die *Konditionale Entropie* berechnet die Ungewissheit vom Wert einer 
  Zufallsvariable $Y$, sofern wir bereits den Wert einer Zufallsvariable $X$
  wissen.

  $ Eta(Y|X) = Eta(Y) - I(X;Y) $

  #dangerous[
    Sofern ich jetzt keine Konditionen übersehe sollte diese Formel in 
    Kombination mit der Mutual Information folgende Gleichung ergeben:
    $Eta(X|Y) = Eta(X,Y) - Eta(Y)$ 
  ]

  Laut #link("https://en.wikipedia.org/wiki/Conditional_entropy", 
  underline("Wikipedia")) gibt es wohl noch eine weitere Formel für die
  konditionale Entropie:
  $ Eta(Y|X) = - sum_(x in cal(X)) sum_(y in cal(Y)) p(x,y) log (p(x,y)/p(x)) $
  Wie relevant diese sein wird kann ich derzeit nicht sagen.
]

Und natürlich braucht es auch noch einen Weg, wie wir Verteilungen in Bezug
auf ihre Entropie vergleichen können.

#definition("Cross Entropy")[
  _Jegliche Erklärungen die ich hierfür gefunden habe waren viel zu 
  kompliziert. Daher muss Jans Erklärung es tun._ \
  Die *Cross Entropy* gibt uns für zwei Verteilungen $p$, $q$ über der Menge
  $cal(X)$ die Durchschnittliche Information/Überraschung für eine Verteilung 
  $p$, wenn wir eigentlich von der Verteilung $q$ ausgehen.

  $ Eta(p,q) = sum_(x in cal(X)) p(x) log 1/q(x) 
    = sum_(x in cal(X)) p(x) I_q(x) $
]

= Divergenz

Erstmal wieder die wichtigste Frage: Was ist überhaupt eine Divergenz?
Divergenzen werden genutzt um zwei Wahrscheinlichkeitsverteilungen zu 
vergleichen. Dabei scheinen diese erstmal eher aus der Vektorarithmetik zu 
kommen und sind dann auf Wahrscheinlichkeiten übertragen worden. \
Jan sagt noch: Divergenzen messen, wie effizient eine Verteilung die andere 
kodiert.

Dazu haben sie folgende Eigenschaften:
- Asymmetrisch: Nicht alle Divergenzen sind symmetrisch
- Nicht-Negativ: Sie sind allerdings immer $>= 0$
- Null, falls die Verteilungen identisch

Kommen wir also zur mit am verbreitetsten Divergenz: Kullback-Leibler Divergenz.

#definition("Kullback-Leibler (KL) Divergenz (KL Divergence)")[
  Die *KL Divergenz* $D_("KL")(p || q)$ misst für zwei Verteilungen $p$, $q$
  über einer Menge $cal(X)$ die Information, die wir verlieren, wenn wir $q$ 
  zur Kodierung nutzen, obwohl wir aber eigtl. eine Kodierung bzgl. $p$ 
  erwarten. \
  #dangerous[An sich wird in den Definitionen erstmal nur von Information
  gesprochen, ich glaube aber als Kodierung ist das verständlicher, sofern es
  richtig ist.] \
  Deshalb der Vollständigkeit: Die KL Divergenz misst den Verlust an 
  Information, wenn $q$ genutzt wird um $p$ zu approximieren. Dazu wird diese
  Divergenz auch häufig als relative Entropie (engl: Relative Entropy)
  bezeichnet. Und sie ist nicht symmetrisch.

  $
    D_"KL" (p || q) = sum_(x in cal(X)) p(x) log (p(x)/q(x))
  $

  Für stetige Verteilungen sieht diese Formel recht ähnlich aus, nur mit
  $integral_(-infinity)^(infinity)$ anstatt der Summe.
]

Und zu guter letzt hat der _man himself_ Claude Shannon zusammen mit Johan
Jensen ebenfalls eine Divergenz aufgestellt.

#definition("Jensen-Shannon Divergenz (JS Divergence)")[
  Die *JS Divergenz* $D_"JS" (p || q)$ ist eine abgewandelte Form der KL
  Divergenz um diese symmetrisch und immer endlich zu machen. So liegt die
  JS Divergenz immer zwischen 0 und 1.

  Erneut haben wir also Verteilungen $p$ und $q$ über einer Menge $cal(X)$.
  Dazu definieren wir uns eine dritte Verteilung $m$ mit $m = (p + q) slash 2$.
  Also einem arithmetischen Mittel von $p$ und $q$. Basierend darauf können wir
  nun die JS Divergenz definieren:
  $
    D_"JS" (p || q) = 1/2 D_"KL" (p || m) + 1/2 D_"KL" (q || m)
  $
  Die Wurzel von dieser Divergenz ist sogar eine Distanz (für was genau diese
  Distanz steht habe ich auf die schnelle jetzt allerdings nicht 
  herausgefunden).
]

#line(length: 100%)

*Changelog*:
- 1.0 #sym.arrow.r 1.0.1: Fix von Rechtschreibfehlern
