# --------- LOAD LIBRARIES
options(scipen = 99) # me-non-aktifkan scientific notation
library(tidyverse) # koleksi beberapa package R
library(dplyr) # grammar of data manipulation
library(readr) # membaca data
library(ggplot2) # plot statis
library(plotly) # plot interaktif
library(glue) # setting tooltip
library(scales) # mengatur skala pada plot
library(readxl) # membaca data excel
library(lubridate) # mengolah date and time
library(googlesheets4) # membaca dari google sheet

# dashboarding
library(shiny)
library(shinydashboard)
library(DT) # datatable

# --------- DATA PREPARATION

PL4 <- read_sheet('https://docs.google.com/spreadsheets/d/18ojqs_EfvYGDcQyW_DZBLrxONPMknyVGOqUhM457KUM/edit#gid=1634234137')
PL4_R <- PL4 %>% 
  mutate(Validation=as.factor(Validation),
         Bulan=as.factor(Bulan)) %>%
  select(-Kimfis.End)


PL4_R$LT.Penimbangan <- difftime(time1 = PL4_R$Validasi.1.End,
                                 time2 = PL4_R$Penimbangan.Start,
                                 units = "days")

PL4_R$LT.Pengolahan <- difftime(time1 = PL4_R$Sterilisasi.End,
                                time2 = PL4_R$Validasi.2.Start,
                                units = "days")

PL4_R$LT.Produksi <- difftime(time1 = PL4_R$Sterilisasi.End,
                              time2 = PL4_R$Penimbangan.Start,
                              units = "days")

PL4_R$LT.QC <- difftime(time1 = PL4_R$CHP.End,
                        time2 = PL4_R$Sampel.Start,
                        units = "days")

PL4_R$LT.QA <- difftime(time1 = PL4_R$Disposisi.FG.End,
                        time2 = PL4_R$CHP.Start,
                        units = "days")

PL4_R$LT.Line4 <- difftime(time1 = PL4_R$Disposisi.FG.End,
                           time2 = PL4_R$Penimbangan.Start,
                           units = "days")

PL4_R$Bulan <- factor(PL4_R$Bulan, levels=month.abb)

PL4_RF <- PL4_R %>% filter(Validation=="NV")




