# Ausarbeitungen des Moduls ProMI

Vorlesungsinhalte des Moduls ProMI (Probabilistische Methoden der Informatik) ausgearbeitet und mit mehr Kontext eingeordnet um die Verständlichkeit des Inhalts zu steigern.

In Zukunft sollen die Kapitel auch noch mit Graphen ergänzt und weiter verdeutlicht werden. Da Typst meines erachtens aktuell keine ordentlichen packages für Graphen hat wird sich hier wahrscheinlich eher die Generierung via Python und matplotlib eignen.

#### Vorgebaute PDFs

Mit jedem Commit auf `main` werden automatisch PDFs gebaut, diese sind bei den [Action-Runs](https://github.com/fussballandy/promi-2425/actions) zu finden. Einfach auf den letzten Run clicken und die Artefakte herunterladen, in der Zip-Datei sind die Dokumente.

> [!WARNING]
> Kapitel 2 baut aktuell aufgrund einer Regression in `fletcher` nicht, wenn man typst `0.13.0-rc1` oder neuer verwendet und ist somit in der CI aktuell nicht verfügbar und die Runs schlagen fehl. Die anderen Kapitel sind jedoch verfügbar.


#### Hinweise

Der Titel "Probabilistischer Untergang meines Lebens" ist rein humorvoll aufzufassen.

#### Bauen

Um eventuell benötigte Bilder in das `images/`-Verzeichnis herunterzuladen, kann das Skript [`download-images.sh`](download-images.sh) genutzt werden.
Die Bilder sind in der Datei [`image-sources.txt`](image-sources.txt) festgehalten, nach folgendem Schema:
```
<dateiname> <quell-url, die direkt zur datei führt> <weitere kommentare (optional)>
```
