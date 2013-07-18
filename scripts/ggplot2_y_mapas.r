library(mapproj)
library(png)
library(RgoogleMaps)
library(ggmap)

# ubico mi alma mater
# unizar <- geocode('Universidad de Zaragoza, Zaragoza, Espa�a')
unizar <- geocode('Buenos Aires')
# unizar <- geocode('La Matanza')
# unizar <- geocode('provincia de buenos aires')
# unizar <- geocode('gran buenos aires')
str(unizar)

# obtengo un mapa
map.unizar <- get_map( location = as.numeric(unizar),
                       color = "color",
                       maptype = "roadmap",
                       scale = 2,
                       zoom = 9)

# lo represento
ggmap(map.unizar) 

# le a�ado puntos
ggmap(map.unizar) + geom_point(aes(x = lon, y = lat),
                               data = unizar, colour = 'red',
                               size = 4)

# --------------------------------------------------------------------------------
unizar <- geocode('Buenos Aires')

map.unizar <- get_map( location = as.numeric(unizar),
                       color = "color",
                       maptype = "roadmap",
                       scale = 2,
                       zoom = 9)

municipios <- c('Ciudad Aut. de Bs.As.', 'ALTE. BROWN', 'AVELLANEDA', 'BERAZATEGUI', 'BERISSO', 'ensenada (la plata)', 'estevan echeverria',
                'EZEIZA  ', 'FCIO. VARELA', 'GRAL. SAN MARTIN', 'HURLINGHAM ', 'ITUZAINGO', 'JOSE C. PAZ ', 'LA MATANZA',
                'LA PLATA', 'LANUS', 'LOMAS DE ZAMORA', 'MALVINAS ARGENTINAS', 'MERLO', 'MORENO', 'MORON', 'QUILMES',
                'san fernando - tigre', 'SAN ISIDRO', 'SAN MIGUEL', 'TIGRE', 'TRES DE FEBRERO', 'VICENTE LOPEZ')

# 2010 http://ceamse.gov.ar
basura <- c(2277772.3, 155333.7, 114414.3, 66295.2, 24246.3, 24966.1, 62664.5, 25501.3, 70500.0,
            179847.9, 64408.9, 76012.9, 51581.7, 471671.2, 167686.7, 184810.5, 217640.6, 73746.0,
            136201.3, 85583.7, 134104.3, 135366.6, 49734.6, 204097.5, 76616.6, 144725.2, 147459.9,
            150860.9)

# Censo 2010 http://www.indec.gov.ar/
poblacion <- c(2890151,552902,342677,324244,88470,56729,300959,163722,426005,414196,181241,167824,265981,
               1775816,654324,459263,616279,322375,528494,452505,321109,582943,163240,292878,276190,376381,340071,269420)

munis <- geocode(municipios)

basura_x_muni <- data.frame(municipios, basura, munis, poblacion)

# un globo proporcional a la basura depositada
ggmap(map.unizar) + geom_point(aes(x = lon, y = lat), 
                               data = basura_x_muni, colour = 'red', 
                               size = basura_x_muni$basura/100000 )

# un globo proporcional a la poblacion
ggmap(map.unizar) + geom_point(aes(x = lon, y = lat),
                               data = basura_x_muni, colour = 'blue', 
                               size = basura_x_muni$poblacion/100000 )

saveRDS(map.unizar,file = "mapa_bs_as", ascii = FALSE, version = NULL,compress = TRUE, refhook = NULL)
mapabsas <- readRDS(file = "mapa_bs_as")
saveRDS(basura_x_muni,file = "basura_x_muni", ascii = FALSE, version = NULL,compress = TRUE, refhook = NULL)
df_basura <- readRDS(file = "basura_x_muni")

ggmap(mapabsas) + geom_point(aes(x = lon, y = lat),
                               data = df_basura, colour = 'blue', 
                               size = df_basura$poblacion/100000 )
ggmap(mapabsas) + geom_point(aes(x = lon, y = lat), 
                               data = df_basura, colour = 'red', 
                               size = df_basura$basura/100000 )

calles <- data.frame(c(-58.378208,-58.442919), c( -34.60008, -34.576043))
names(calles) <- c("lon","lat")

ggmap(mapabsas) + geom_point(aes(x = lon, y = lat), 
                              data=calles,colour = 'red', 
                             size = 1 )


geocode("san fernando - tigre")
geocode("tigre")

str(mapabsas)