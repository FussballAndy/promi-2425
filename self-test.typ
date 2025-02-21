#import "@preview/athena-tu-darmstadt-exercise:0.1.0": tudaexercise, tuda-section as section

#show: tudaexercise.with(
  show-title: false,
  language: "ger",
  design: (
    // darkmode: true,
  )
)
#set enum(numbering: "1.", spacing: 2cm)
#section[Foliensatz 1]

+ Was ist eine Zufallsvariable?
+ Wie steht CDF und PDF/PMF im Verhältnis?
+ Nenne wichtige Eigenschaften des Erwartungswert.
+ Wie lautet der _standardized second moment_ einer beliebigen Verteilung?
+ Was misst die Standardabweichung?
+ Wie steht Standardabweichung und Varianz im Verhältnis?
+ Was misst _skewness_?
+ Welche _skewness_ hat eine symmetrische Verteilung?
+ Was misst _kurtosis_?
+ Wann ist der Erwartungswert gleich dem Median?
+ Was sind _modes_?

#pagebreak()

#section[Foliensatz 2]

+ Was ist _information_?
+ Worin unterscheidet sich _information_ von Daten?
+ Was sind die Eigenschaften einer _information source_?
+ Was ist _entropy_?
+ Was ist ein _channel_?
+ Wie unterscheiden sich die beiden vorgestellen _channel_-Typen (BSC, BEC)?
+ Warum kodieren wir unsere Daten?
+ Was sind Anwendungen von der Informationstheorie?
+ Was ist eine _divergence_?
+ Was sind Eigenschaften der _KL Divergence_?

#pagebreak()

#section[Foliensatz 3]

+ Wie steht die Binomial- und Bernoulli-Verteilung im Verhältnis?
+ Wie steht die Binomial- und Poisson-Verteilung im Verhältnis?
+ Was ist die _change-of-variables_ Formel und wo können wir sie anwenden?
+ Wie kann man die Verteilung der Summe zweier Zufallsvariablen bestimmen?
+ Warum ist die Normalverteilung wichtig und wie können wir sie herleiten?
+ Was sind _maximum entropy distributions_ und wie können wir diese 
  kontrollieren?
+ Was sind _mixture distributions_ und dazu auch _latent variables_?
+ Was ist der Unterschied zwischen _parametric_ und _non-parametric models_?
+ Wie beeinflusst der _bandwith_ Parameter die _kernel density estimation_?

#pagebreak()

#section[Foliensatz 4]

+ Mit welchen _estimation_ Techniken erhalten wir ein _point estimate_?
+ Für welche Verteilung des _prior_ entspricht die MAP Schätzung der des MLE?
+ Was ist der Zusammenhang zwischen _least squares_ und _maximum likelihood
  regression_? Warum ist zweiteres "besser"?
+ Wie lässt sich _overfitting_ (speziell bei _Polynomial Regression_) 
  verhindern?
+ Wie ändert sich die _complexity_, wenn man $lambda$ bei _ridge regression_
  erhöht? (Begründe)
+ Wie kann man nicht-linear separierbare Daten mit _logistic regression_ 
  klassifizieren?
+ Was ist die Intuition hinter dem EM Algorithmus?

#pagebreak()

#section[Foliensatz 5]

+ Wofür brauchen/nutzen wir Experimente?
+ Was sind häufige _design factors_, _controllable variables_ und 
  _uncontrollable variables_ beim machine learning?
+ Was ist _Occam's razor_?
+ Warum teilen wir unsere Daten in Training, Validation und Test Set?
+ Was ist _aleatoric_ und _epistemic uncertainty_?
+ Was ist der _bias-variance tradeoff_?

#pagebreak()

#section[Foliensatz 6]

+ Was ist der Unterschied zwischen dem _weak_ und _strong law of large numbers_?
+ Wie beeinflusst die sample size die konvergenzrate von Monte Carlo 
  Algorithmen?
+ Wie unterscheiden sich _pseudo-random number generators_ von _true random
  number generators_?
+ Welchen Vorteil haben _quasi-random number generators_ über _pseudo-random
  number generators_?
+ Wie wird die inverse CDF im sampling genutzt?
+ Wie funktioniert _rejection_ und _importance sampling_?
+ Wie funktioniert der _Metropolis-Hastings_ Algorithmus und wie unterscheidet
  er sich von _direct_, _rejection_ und _importance sampling_?

#pagebreak()

#section[Foliensatz 7]

+ Warum müssen wir _uncertainty_ beim treffen von Entscheidungen in Betracht
  ziehen?
+ Was sind _multi-armed bandits_?
+ Welche Probleme bei Globalen Optimierungen versucht _Bayesian optimization_
  zu lösen?
+ Welche Ansätze können bei der _Bayesian optimization_ für das _surrogate
  model_ genutzt werden?
+ Was ist der _exploration-exploitation tradeoff_?
+ Was ist der Vorteil von _Dynamic Programming_ im Vergleich zu Methoden wie
  _Breadth-First Search_ oder _Depth-First Search_?
+ Welche Probleme des _Dynamic Programming_ versucht _Reinforcement Learning_
  zu lösen?