# 1.0 Daten explorieren  ------------------------------------------------

# 1.0.0
# Zeige dir die deskriptive Statistik mit Hilfe von skimr an
# * Installiere und lade das Paket skimr
# * Führe die Funktion skim auf den Datensatz erasmus_data_cleaned aus
install.packages(skimr)
library(skimr)
skim(erasmus_data_cleaned)

# 1.0.1
# Beantworte mit Hilfe der skimr-Statistik folgende Fragen:
# * Wie viele unterschiedliche Nationalitäten gab es unter den Teilnehmenden?
# * Was war das Durchschnittsalter der Teilnehmenden?

# 1.0.2
# Vergleiche die Geschlechterverteilung der Teilnehmenden zwischen allen
# akademischen Jahren
erasmus_data_cleaned %>%
  count(academic_year, participant_gender)

# 1.0.4
# Untersuche, ob sich das durchschnittliche Alter der Teilnehmenden von Jahr
# zu Jahr veraendert hat. Nutze dafür group_by und summarise
erasmus_data_cleaned %>%
  group_by(academic_year) %>%
  summarise(
    mean_age = mean(participant_age)
  )


# 1.1 Daten visualisieren -----------------------------------------------------

# 1.1.0
# * Untersuche die Altersverteilung genauer mit einem Histogramm.
# * Aendere die Farbe der Balken zu blau und die Farbe der Umrandungslinien zu
#   schwarz
# * Vergleiche die Altersverteilung von Jahr zu Jahr mit facet_wrap
ggplot(erasmus_data_cleaned, aes(x = participant_age)) +
  geom_histogram(fill = "blue", color = "black") + 
  facet_wrap(~academic_year)


# 1.1.1
# Speichere die Visualisierung im R-Projekt ab unter dem Pfad
# images/histogram_verteilung_alter_jahr.png
ggsave("images/histogram_verteilung_alter_jahr.png",
       width = 8, height = 5, dpi = 300)


# 1.1.2
# * Um Ausreißer in der Länge der Mobilitaetsphasen zu erkennen, koennen dir
#   Boxplots helfen.
# * Erstelle ein Boxplot pro Jahr mit der Variable mobility_duration auf der
#   y-Achse
# * Mithilfe von geom_jitter kannst du dir die einzelnen Werte der Laenge der
#   Mobilitaetsphase ansehen. Beachte: Bei so vielen Werten wird das schnell
#   unuebersichtlich, nutze alpha, um die Punkte transparent zu machen
# * Gib der Visualisierung einen sinnvollen Titel und Achsentitel
erasmus_data_cleaned %>%
  ggplot(aes(x = academic_year, y = mobility_duration)) +
  geom_boxplot() +
  geom_jitter(alpha = .8)
  labs(
    title = "Durchschnittliche Mobilitätsdauer",
    x = "Akademisches Jahr",
    y = "Kalendertage"
  )


# 1.1.3
# Speichere die Visualisierung im R-Projekt ab unter dem Pfad
# images/boxplots_mobility_duration_year.png
ggsave("images/boxplots_mobility_duration_year.png", width = 8,
       height = 5, dpi = 300)