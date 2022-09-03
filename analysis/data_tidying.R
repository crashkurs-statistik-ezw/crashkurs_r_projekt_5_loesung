# (Installiere und) lade folgende Pakete
library(tidyverse)
library(janitor)
library(haven)

# 1.0 Daten einlesen ------------------------------------------------------

# 1.0.0
# * Lese den Datensatz data/erasmus_data.csv ein, achte darauf, dass das
#   Trennzeichen hier ein Semikolon ist und du read_csv2 benutzen musst
# * Speichere den Datensatz in der Variable erasmus_data
erasmus_data <- read_csv2("data/erasmus_data.csv")


# 1.1 Daten bereinigen ---------------------------------------------

# 1.1.0
# * Wir möchten in diesem Projekt nur die Daten der aus Deutschland entsendeten
#   Erasmusteilnehmenden untersuchen. Filtere daher die Variable
#   sending_country_code mit Hilfe von filter, sodass nur noch die Variablenaus-
#   prägung "DE" erhalten bleibt
# * Speichere den bereinigten Datensatz in der Variable erasmus_data_cleaned
erasmus_data_cleaned <- erasmus_data %>% 
  dplyr::filter(sending_country_code == "DE")

# 1.2.0
# * Die Variable participant_age enthält einige fehlerhaft Werte.Schaue dir die
#   Variablenauspraegungen mit der Funktion count genauer an und speichere den
#   Output als erasmus_age.
# * Lösche die Proband*innen aus erasmus_data_cleaned, die bei participant_age
#   negative Werte, Werte unter 10 und ueber 100 haben.
# * Speichere den Datensatz erneut als erasmus_data_cleaned
erasmus_data_cleaned <- erasmus_data_cleaned %>% 
  dplyr::filter(participant_age > 9, participant_age < 100)

# 1.2 Datenexport ---------------------------------------------------------

# 1.2.0
# * Exportiere den Datensatz in den Ordner data/cleaned
# * Speichere die Daten unter data/export/student_data_cleaned.csv
write_csv(erasmus_data_cleaned, "data/export/erasmus_data_cleaned.csv")


# 1.2.1
# * Um die Daten in SPSS zu nutzen, exportiere den gereinigten Datensatz mit der
#   Funktion write_sav
# * Speichere die Daten unter data/export/student_data_cleaned.sav
write_sav(student_data_cleaned, "data/export/student_data_cleaned.sav")
