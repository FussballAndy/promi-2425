#import "template.typ": *
#import "@preview/fletcher:0.5.2" as fletcher: diagram, node, edge

#show: book-template.with(
  chapter: 2,
  version: "1.0",
)

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
  Ein *Absender* $accent(X, macron)$ ist ein Tupel $(cal(X), p)$, wobei 
  $cal(X)$ die Menge der möglichen Nachrichten ist und $p:cal(X)->bb(R)$
  eine Funktion, die die Wsk. angibt, dass eine Nachricht $x in cal(X)$ 
  gesendet wurde.

  Ist $x$ eine Nachricht mit einer Wsk. $p(x)>0$, dann ist die Information, die
  $x$ beinhaltet:
  $ I(x) = log 1/p(x) = -log p(x) $ 

  Zudem nennt man einen Absender _stationary_, wenn $cal(X) != emptyset$, 
  $forall x in cal(X): p(x)>0$ und $display(sum_(x in X) p(x))=1$ gilt.

  #note[Das $p$ hier scheint erstmal unabhängig von der PMF aus Kapitel 1 zu 
  sein. Außerdem wird für den Logarithmus -- speziell im Kontext von Shannon --
  meist die Basis 2 verwendet. Eine genaue festlegung muss dort aber laut 
  meiner Kenntnis nicht getroffen werden.]
]

#box(stroke: 1pt + black, inset: 5pt, width: 100%)[
  *Exkurs*: Warum der Logarithmus \
  Man fragt sich nun vielleicht, warum hier der Logarithmus genutzt wurde und nicht einfach nur $1 \/ p(x)$. 
  - Messung von benötigten Bits zur Kodierung von Nachrichten (häufigere
    Nachrichten mit weniger Bits kodieren etc.)
  - $1 \/ p(x)$ bringt das Problem, dass für $p(x)=1$ keine Bits benötigt werden
    wir aber trotzdem $1 \/ 1 = 1$ erhalten würden. Hier hilft der $log$ bei
    der Normung

  // Todo: Incorporate more of https://randompearls.com/science-and-technology/mathematics/information-theory-rationale-behind-using-logarithm-entropy-and-other-explanations/
]