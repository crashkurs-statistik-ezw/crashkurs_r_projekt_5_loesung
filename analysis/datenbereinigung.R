# 5.1 Setup ---------------------------------------------------------------

# 5.1.1 Pakete installieren
# (Installiere und) lade folgende Pakete: tidyverse, janitor, haven
library(tidyverse)
library(janitor)
library(haven)


# 5.2 Daten einlesen ------------------------------------------------------

# 5.2.1 Daten einlesen
# * Lese den Datensatz data/erasmus_data.csv ein, achte darauf, dass das
#   Trennzeichen hier ein Semikolon ist und du read_csv2 benutzen musst
#   (siehe ?read_csv2)
# * Speichere den Datensatz in der Variable erasmus_data
erasmus_data <- read_csv2("data/erasmus_data.csv")


# 5.3 Daten bereinigen ---------------------------------------------


# 5.3.1 Variable filtern
# * Wir möchten in diesem Projekt nur die Daten der aus Deutschland entsendeten
#   Erasmusteilnehmenden untersuchen. Filtere daher die Variable
#   sending_country_code mit Hilfe von filter, sodass nur noch die Variablenaus-
#   prägung "DE" erhalten bleibt
# * Speichere den bereinigten Datensatz in der Variable erasmus_data_germany
erasmus_data_germany <- erasmus_data %>%
  dplyr::filter(sending_country_code == "DE")


# 5.3.2 Variable reinigen
# * Die Variable participant_age enthält einige fehlerhaft Werte. Schaue dir die
#   Variablenauspraegungen mit der Funktion count an
# * Entferne die Proband*innen aus erasmus_data_germany, die bei participant_age
#   negative Werte, Werte unter 10 und ueber 100 haben.
# * Ändere außerdem den Namen der Variable '...1' zu 'id' mit Hilfe von rename
#   Hilfe dazu findest du hier: 
#   https://www.geeksforgeeks.org/rename-columns-of-a-data-frame-in-r-programming-rename-function/
# * Speichere den Datensatz erneut als erasmus_data_germany
erasmus_data_germany %>% 
  count(participant_age)

erasmus_data_germany <- erasmus_data_germany %>% 
  dplyr::filter(participant_age > 9, participant_age < 100) %>% 
  rename(id = ...1)
  

# 5.4 Datenexport ---------------------------------------------------------

# 5.4.1 CSV-Datei exportieren
# * Exportiere den Datensatz in den Ordner data/cleaned
# * Speichere die Daten unter data/cleaned/erasmus_data_germany.csv
write_csv(erasmus_data_germany, "data/cleaned/erasmus_data_germany.csv")


# 5.4.2 SAV-Datei exportieren
# * Um die Daten in SPSS zu nutzen, exportiere den gereinigten Datensatz mit der
#   Funktion write_sav
# * Speichere die Daten unter data/cleaned/erasmus_data_germany.sav
write_sav(erasmus_data_germany, "data/cleaned/erasmus_data_germany.sav")
