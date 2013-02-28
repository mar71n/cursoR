datos_indulto <- read.csv("../data/indultos.csv")
datos_indulto_cat <- read.csv("../data/indultos_cat_crimen.csv")

names(datos_indulto)

#      indulto                                                        genero                juzgado
# [1] "boe"                "boe_date"           "ministry"           "gender"             "court"              "court_type"         "court_region_id"   
# [8] "trial_date"         "role"               "crimes_sentences"   "crime_initial_year" "crime_final_year"   "pardon_type"        "new_sentence"      
# [15] "condition"          "pardon_date"        "pardon_year"        "signature"          "url"               

unique(datos_indulto$signature)

library(help="base")

str(datos_indulto)

table(datos_indulto$pardon_year - datos_indulto$crime_final_year)
hist(datos_indulto$pardon_year - datos_indulto$crime_final_year)
table(datos_indulto$pardon_year)
hist(datos_indulto$pardon_year)

View(datos_indulto[datos_indulto$boe=='BOE-A-1996-3530',])

?merge
datos_indulto_con_cat <- merge(datos_indulto,datos_indulto_cat,by='boe')
datos_indulto_con_cat <- merge(datos_indulto,datos_indulto_cat,by='boe')

View(datos_indulto_con_cat[!is.na(datos_indulto_con_cat$crime_cat),])

names(datos_indulto_con_cat)
table(datos_indulto_con_cat$crime_cat)
View(table(datos_indulto_con_cat$crime))

?sort
?View


?aggregate

datos_indulto_cat[datos_indulto_cat$crime == 'delito de robocontra el deber de prestación del servicio militar',]

datos_indulto_cat[grep("servicio militar",datos_indulto_cat$crime),]
datos_indulto_con_cat[grep("servicio militar",datos_indulto_con_cat$crime),c("crime_initial_year","crime_final_year","pardon_year.x")]
View(datos_indulto_con_cat[grep("servicio militar",datos_indulto_con_cat$crime),c("crime_initial_year","crime_final_year","pardon_year.x")])
table(datos_indulto_cat[grep("servicio militar",datos_indulto_cat$crime),]$pardon_year)
table(datos_indulto_cat[grep("robo",datos_indulto_cat$crime),]$pardon_year)
table(datos_indulto_cat[grep("homicidio",datos_indulto_cat$crime),]$pardon_year)



table(datos_indulto$pardon_year)
table(datos_indulto_cat[grep("servicio militar",datos_indulto_cat$crime),]$pardon_year)
table(datos_indulto_cat[grep("delito contra la seguridad del tr",datos_indulto_cat$crime),]$pardon_year)


table(datos_indulto_cat[datos_indulto_cat$pardon_year==2000,]$crime_cat)
table(datos_indulto_cat$crime_cat,datos_indulto_cat$pardon_year)
# en el 2000 3 13 17 18
datos_indulto_cat[datos_indulto_cat$crime_cat %in% c(3 ,13, 17, 18),]

table(datos_indulto_cat$crime, datos_indulto_cat$pardon_year)
vre <- as.data.frame(sort(table(datos_indulto_cat$crime, datos_indulto_cat$pardon_year),vars=c("crime")))


grep("servicio militar",datos_indulto_cat$crime)

?select
?regexp
greep








require(RCurl)
tmp <- getURL("https://raw.github.com/dcabo/indultometro/master/data/indultos.csv")
indultos <- read.csv(textConnection(tmp))









t_indultos <- read.csv("../data/indultos.csv")
t_indultos_cat <- read.csv("../data/indultos_cat_crimen.csv")

table(t_indultos$pardon_year)
hist(t_indultos$pardon_year)
table(t_indultos_cat[grep("servicio militar",t_indultos_cat$crime),]$pardon_year)
table(t_indultos_cat[grep("delito contra la seguridad del tr.+fico",t_indultos_cat$crime),]$pardon_year)


table(t_indultos_cat$crime_cat,t_indultos_cat$pardon_year)


table(t_indultos$gender, t_indultos$crime_initial_year)

table(t_indultos_cat$crime_initial_year)

t_indultos_y_cat <- merge(t_indultos, t_indultos_cat, by = "boe")

table(t_indultos_y_cat$crime_cat, t_indultos_y_cat$crime_initial_year)

t_indultos_y_cat[t_indultos_y_cat$crime_cat %in% c(13, 19),]
t_indultos_y_cat[t_indultos_y_cat$crime_initial_year<1970,]

str(t_indultos_y_cat)
View(table(t_indultos_y_cat$condition, t_indultos_y_cat$crime_cat))

t_indultos_cat[grep("rehab | tratam",t_indultos_y_cat$condition),]

View(t_indultos_y_cat[grep("rehab | tratam",t_indultos_y_cat$condition),])

View(t_indultos_y_cat[grep("tratam",t_indultos_y_cat$condition),])
View(t_indultos_y_cat[grep("tratam",t_indultos_y_cat$condition),][grep("rehab",t_indultos_y_cat[grep("tratam",t_indultos_y_cat$condition),]$condition,invert=T),])
?grep

tratamiento
rehabilitación
deshabituación

# algunos dicen "tratamiento de rehabilitacion", otros "tratamiento de deshabituacion", otros solo "tratamiento"

tienen_tratamiento <- t_indultos_y_cat[grep("tratam",t_indultos_y_cat$condition),]
tienen_tratamiento_pero_noreha <- tienen_tratamiento[grep("rehab",tienen_tratamiento$condition,invert=T),]
tienen_deshabit <- t_indultos_y_cat[grep("deshabituac",t_indultos_y_cat$condition),]
tienen_tratamiento_pero_no_deshabit <- tienen_tratamiento[grep("deshabit",tienen_tratamiento$condition,invert=T),]
tienen_deshabit_pero_no_trat <- tienen_deshabit[grep("tratam",tienen_deshabit$condition,invert=T),]


t_indultos <- read.csv("../data/indultos.csv")

# algunos dicen "tratamiento de rehabilitacion", otros "tratamiento de deshabituacion", otros solo "tratamiento"
tienen_tratamiento <- t_indultos[grep("tratamiento",t_indultos$condition),]
# hay 8 registros que dicen "tratamiento" pero no rehabilitacion
tienen_tratamiento_pero_noreha <- tienen_tratamiento[grep("rehabilitaci.+n",tienen_tratamiento$condition,invert=T),]
# en 4 casos dice deshabituacion
tienen_deshabit <- t_indultos[grep("deshabituaci.+n",t_indultos$condition),]
# con alguna de las tres palabras:
condicion_tratamiento <- t_indultos[unique(c(grep("tratamiento",t_indultos$condition),
                                             grep("rehabilitaci.+n",t_indultos$condition),
                                             grep("deshabituaci.+n",t_indultos$condition))
                                           ),]

table(condicion_tratamiento$pardon_year)

View(t_indultos[grep("rehab | tratam | deshab",t_indultos_y_cat$condition),])



unique(c(1,2,3,3,4,4,5,5,2,2,1))
