#import "template.typ": *
#import "@preview/fletcher:0.5.2" as fletcher: diagram, node, edge

#show: book-template.with(
  chapter: 2,
  version: "1.0",
)

#let source = math.accent("X", math.macron)

= Information

Zuerst einmal sollte man klären, was Information überhaupt ist. In der 
Informationstheorie (engl. Information Theory) bezeichnet Information das 
Wissen, welches ein Absender durch einen Informationskanal an einen Empfänger
vermittelt. Dazu ist es noch wichtig zu erwähnen, das Information und Daten 
nicht das gleiche sind.

Die Informationstheore beschäftigt sich stark mit der Übertragung, 
Verarbeitung, Extrahierung und Verwertung von Informationen. Sie wurde stark 
von Claude Shannon vorangetrieben. Denn dieser hat vor allem Bits als Einheit
gewählt, wodurch seine Arbeit gut auf heutige Rechnersysteme übertragbar ist.  

Vorhin wurde bereits der Informationskanal (engl. Information Channel) erwähnt,
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
"Error Code 3" unerwartbarer war, enthät diese entsprechend mehr Information.

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
  Zufallsvariable $X$ als einezu erhaltende Nachricht ansehen, wobei man die Wsk. 
  herausfinden will, dass diese die Nachricht $x$ ist. Außerdem wird für den 
  Logarithmus -- speziell im Kontext von Shannon -- meist die Basis 2 verwendet. 
  Eine genaue festlegung muss dort aber laut meiner Kenntnis nicht getroffen 
  werden.]
]

#box(stroke: 1pt + black, inset: 5pt, width: 100%)[
  *Exkurs*: Warum der Logarithmus \
  Man fragt sich nun vielleicht, warum hier der Logarithmus genutzt wurde und 
  nicht einfach nur $1 \/ p(x)$. \
  Das erste Problem wäre, dass die Information einer Nachricht die immer 
  auftritt ($p(x)=1$) dann $1 slash 1 = 1$ wäre, diese Nachricht aber eigentlich 
  gar keine Information enthält. Des weiteren hat Shannon Information genutzt um 
  die Anzahl an Bits zu berechnen, die benötigt werden, um eine Nachricht $x$ zu 
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
  (8 Bits). Da man aber in einem Byte nur 256 Zeichen kodieren könnte werden für 
  _seltenere_ entsprechend mehr Byte zur Kodierung genutzt. So kann ein 
  einzelnes Zeichen in UTF-8 1-4 Byte groß sein. Und welche Zeichen sind nun nur
  mit einem Byte kodiert? Eben die, die bei uns im Alltag am häufigsten 
  vorkommen: a-z,A-Z,0-9,Punktationen etc. Hingegen ein Zeichen wie 'ä', welches 
  (zumindest im Englischen) nicht so häufig vorkommt wird mit 2 Byte kodiert. 
  Das bringt eben den Vorteil, dass viele Nachrichten dadurch deutlich weniger 
  Speicher benötigen. Würde man alle Zeichen mit 4 Byte kodieren, würde ein Text 
  wie `"Hello world!"` 48 Byte benötigen, während er so nur 12 Byte benötigt.
]

Fairerweise ist dieser Exkurs ein wenig ausgeartet. Falls man allerdings noch 
etwas mehr zum Verständnis von Information bzw. der Formel dahinter lesen will 
kann ich den folgenden  Artikel (oder zumindest die ersten beiden Abschnitte) 
sehr empfehlen:
https://randompearls.com/science-and-technology/mathematics/information-theory-rationale-behind-using-logarithm-entropy-and-other-explanations/

#definition("Entropie (Entropy)")[
  #emoji.construction

  *Entropie* ist die Messung der Ungewissheit, welche möglichen Werte eine 
  Zufallsvariable $X$ annehmen kann. Dabei ist sie auch ein Maß für den 
  mittleren (erwarteten?) Informationsgehalt der Nachrichten eines Absenders.

  Entsprechend kann man die Entropie einer Zufallsvariable $X$ über der Menge
  der Nachrichten $cal(X)={x_1, x_2, ..., x_n}$ eines Absenders #source wie 
  folgt beschreiben:
  $ Eta(X)=sum_(i=1)^n p(x_i) I(x_i) = sum_(i=1)^n p(x_i) log 1/p(x_i) = 
  - sum_(i=1)^n p(x_i) log p(x_i) $

  #sub[Fragt bitte nicht warum auf Jans Folie das $n$ auf einmal zu $N$ wird]

  Die Einheit von Entropie ist entsprechend wieder Bits.

  #note[$Eta$ IST KEIN GROSSES h SONDERN EIN GROSSES `Eta`]
]