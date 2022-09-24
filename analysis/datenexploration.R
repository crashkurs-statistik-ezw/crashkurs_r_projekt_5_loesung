# 5.5 Setup ---------------------------------------------------------------

# 5.5.1 Daten einlesen
# Imnportiere die CSV-Datei data/cleaned/erasmus_data_cleaned.csv
# und speichere sie in der Variable erasmus_data
erasmus <- read_csv("data/cleaned/erasmus_data_germany.csv")


# 5.6 Daten explorieren  ------------------------------------------------

# 5.6.1 Deskriptive Statistik erstellen
# Zeige dir die deskriptive Statistik mit Hilfe von skimr an
# * (Installiere und) lade das Paket skimr
# * Führe die Funktion skim auf den Datensatz erasmus aus
# * Mehr über skim findest du hier:
#   https://cran.r-project.org/web/packages/skimr/vignettes/skimr.html
# install.packages(skimr)
library(skimr)
skim(erasmus)


# 5.6.2 Output deuten
# Beantworte mit Hilfe der skimr-Statistik folgende Fragen:
# * Wie viele unterschiedliche Nationalitäten gab es unter den Teilnehmenden?
# * Was war das Durchschnittsalter der Teilnehmenden?


# 5.6.3 Geschlechterverteilung ausgeben
# Vergleiche die Geschlechterverteilung der Teilnehmenden zwischen allen
# akademischen Jahren
erasmus %>%
  count(academic_year, participant_gender)

erasmus %>% 
  count(academic_year, participant_gender) %>% 
  ggplot(aes(x = academic_year, y = n)) +
    geom_col(aes(fill = participant_gender), position = position_dodge2())


# 5.6.4 Altersentwicklung untersuchen
# Untersuche, ob sich das durchschnittliche Alter der Teilnehmenden über die
# Jahre veraendert hat. Nutze dafür group_by und summarise
erasmus %>%
  group_by(academic_year) %>%
  summarise(
    mean_age = mean(participant_age)
  )

# 5.7 Daten visualisieren -----------------------------------------------------

# 5.7.1 Histogramm der Altersverteilung erstellen
# * Untersuche die Altersverteilung genauer mit einem Histogramm.
# * Aendere die Farbe der Balken zu steelblue und die Farbe der Umrandungslinien zu
#   schwarz
#   Hilfe dazu findest du hier:
#   http://www.sthda.com/english/wiki/ggplot2-histogram-plot-quick-start-guide-r-software-and-data-visualization
# * Vergleiche die Altersverteilung von Jahr zu Jahr mit facet_wrap
ggplot(erasmus, aes(x = participant_age)) +
  geom_histogram(fill = "steelblue", color = "black", 
                 alpha = .7, binwidth = 3) + 
  facet_wrap(vars(academic_year))


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
# * Erstelle alternativ zu einem Boxplot einen Violinplot mit geom_violin
# * Welche Vorteile siehst du bei einem Violinplot gegenüber einem Boxplot?
# * Gib der Visualisierung einen sinnvollen Titel und Achsentitel
erasmus %>%
  ggplot(aes(x = academic_year, y = mobility_duration)) +
  geom_violin(alpha = .2, fill = "grey60") +
  # geom_boxplot(alpha = .7, fill = "grey80") +
  ylim(0, 20) +
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
