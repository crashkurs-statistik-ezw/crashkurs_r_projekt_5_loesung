# 5.5 Setup ---------------------------------------------------------------

# 5.5.1 Daten einlesen
# Imnportiere die CSV-Datei data/export/erasmus_data_cleaned.csv
# und speichere sie in der Variable erasmus_data
erasmus_data <- read_csv("data/export/erasmus_data_cleaned.csv")


# 5.6 Daten explorieren  ------------------------------------------------

# 5.6.1 Deskriptive Statistik erstellen
# Zeige dir die deskriptive Statistik mit Hilfe von skimr an
# * Installiere und lade das Paket skimr
# * Führe die Funktion skim auf den Datensatz erasmus_data_cleaned aus
install.packages(skimr)
library(skimr)
skim(erasmus_data_cleaned)

# 5.6.2 Output deuten
# Beantworte mit Hilfe der skimr-Statistik folgende Fragen:
# * Wie viele unterschiedliche Nationalitäten gab es unter den Teilnehmenden?
# * Was war das Durchschnittsalter der Teilnehmenden?

# 5.6.3 Geschlechterverteilung ausgeben
# Vergleiche die Geschlechterverteilung der Teilnehmenden zwischen allen
# akademischen Jahren
erasmus_data_cleaned %>%
  count(academic_year, participant_gender)

# 5.6.4 Altersentwicklung untersuchen
# Untersuche, ob sich das durchschnittliche Alter der Teilnehmenden von Jahr
# zu Jahr veraendert hat. Nutze dafür group_by und summarise
erasmus_data_cleaned %>%
  group_by(academic_year) %>%
  summarise(
    mean_age = mean(participant_age)
  )


# 5.7 Daten visualisieren -----------------------------------------------------

# 5.7.1 Histogramm der Altersverteilung erstellen
# * Untersuche die Altersverteilung genauer mit einem Histogramm.
# * Aendere die Farbe der Balken zu blau und die Farbe der Umrandungslinien zu
#   schwarz
# * Vergleiche die Altersverteilung von Jahr zu Jahr mit facet_wrap
ggplot(erasmus_data_cleaned, aes(x = participant_age)) +
  geom_histogram(fill = "blue", color = "black") + 
  facet_wrap(~academic_year)


# 5.7.2 Visualisierung speichern
# Speichere die Visualisierung im R-Projekt ab unter dem Pfad
# images/histogram_verteilung_alter_jahr.png
ggsave("images/histogram_verteilung_alter_jahr.png",
       width = 8, height = 5, dpi = 300)


# 5.7.3 Boxplots der Mobilitätsphasen erstellen
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


# 5.7.4 Visualisierung speichern
# Speichere die Visualisierung im R-Projekt ab unter dem Pfad
# images/boxplots_mobility_duration_year.png
ggsave("images/boxplots_mobility_duration_year.png", width = 8,
       height = 5, dpi = 300)