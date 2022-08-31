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
# * Untersuche, ob sich das durchschnittliche Alter der Teilnehmenden von Jahr
#   zu Jahr veraendert hat. Nutze dafür group_by und summarise
erasmus_data_cleaned %>%
  group_by(academic_year) %>%
  summarise(
    mean_age = mean(participant_age)
  )


# 1.1 Daten visualisieren -----------------------------------------------------

# 1.1.0
# Untersuche den Datensatz mit Hilfe eines Balkendiagramms
# * Erstelle ein aneinandergereihtes Balkendiagramm, das die Verteilung der 
#   SuS auf die verschiedenen Level von familiaerer Bindungsqualitaet d
#   auf der X-Achse darstellt und das Geschlecht durch die Farbe der 
#   Balken kennzeichnet
# * Nutze position = position_dodge(), um die Balken nebeneinander zu reihen.
# * Füge sinnvolle Achsen- und Legendentitel hinzu
# * Haben die Schueler bessere familiaere Bindungen als Schuelerinnen?
ggplot(student_data_cleaned, aes(x = famrel, fill = sex)) +
  geom_bar(position = position_dodge()) +
  labs(
    x     = "Qualität der familiären Bindung",
    y     = "Anzahl",
    fill  = "Geschlecht"
  ) +
  scale_y_continuous(expand = expansion(0)) +
  scale_fill_viridis_d(option = "cividis", begin = 0.3, end = 0.9)


# 1.1.1
# Speichere die Visualisierung im R-Projekt ab unter dem Pfad
# images/barbplot_mothers_education_status.png
ggsave("images/verteilung_bildungsqualitaet_geschlecht.png",
       width = 8, height = 5, dpi = 300)


# 1.1.2
# * Erstelle ein aneinandergereihtes Balkendiagramm mit dem Bildungslevel der 
#   Muetter auf der x-Achse und deren Beschaeftigungsstatus auf der Y-Achse.
# * Erstelle  eine neue bedingte Variable mit Hilfe von case_when.
# * Unterscheiden sich die arbeitenden Muetter von den nicht arbeitenden 
#   Muettern in ihrem Bildungslevel?
student_data_cleaned %>%
  mutate(
    working_mother = case_when(
      mjob %in% c("at_home") ~ "no",
      TRUE ~ "yes"
    )
  ) %>%  
  ggplot(aes(x = medu, fill = working_mother)) +
  geom_bar(position = "dodge") +
  labs(
    x     = "Bildungslevel der Mutter",
    y     = "Anzahl",
    fill  = "Working mother"
  ) +
  scale_y_continuous(expand = expansion(0)) +
  scale_fill_viridis_d(option = "cividis", begin = 0.3, end = 0.9)


# 1.1.3
# Speichere die Visualisierung im R-Projekt ab unter dem Pfad
# images/barbplot_mothers_education_status.png
ggsave("images/barbplot_mothers_education_status.png", width = 8,
       height = 5, dpi = 300)