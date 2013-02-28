# Voy a crear dos conjuntos de datos (basta con copiar y pegar el código en R para recrearlos):
  
ventas <- structure(list(codigo = structure(c(4L, 6L, 2L, 7L, 5L, 1L, 3L ), 
                      .Label = c("A206", "A536", "B713", "C865", "K014", "K086",  "S163"), class = "factor"), 
                      unidades.vendidas = c(15L, 9L, 21L,  34L, 1L, 12L, 29L)), 
                      .Names = c("codigo", "unidades.vendidas" ), 
                      class = "data.frame", row.names = c(NA, -7L))

str(ventas)

catalogo <- structure(list(codigo = structure(1:8, .Label = c("A206", "A536", "B713", "C865", "K014", "K086", "M315", "S163"), class = "factor"), 
                           nombre = structure(c(4L, 8L, 1L, 7L, 3L, 2L, 6L, 5L), 
                          .Label = c("Frambozen","Koning", "Kroon", "Mokka", "Orbais", "Pyramide", "Vanille", "Walnoot"), class = "factor"), 
                           descripcion = structure(1:8, .Label = c("aaa", "bbb", "ccc", "ddd", "eee", "fff", "ggg", "hhh"), class = "factor")), 
                          .Names = c("codigo", "nombre", "descripcion"), class = "data.frame", row.names = c(NA,  -8L))

# En el catálogo hay varios tipos de chocolates y sus descripciones. En ventas, las unidades vendidas de cada tipo de chocolate.

# Usando la función merge, se pide:
  
# Añadir a ventas la el nombre y la descripción de los chocolates vendidos.
str(ventas)
str(catalogo)
merge(ventas,catalogo, by="codigo")

ventas <- edit(ventas)

# Identificar (¡usando merge!) los tipos de chocolate que constan en el catálogo que no se han vendido.
merge(ventas,catalogo, by="codigo", all.y=T)
str(merge(ventas,catalogo, by="codigo", all.y=T))
?is.na
merge(ventas,catalogo, by="codigo", all.y=T)[is.na(merge(ventas,catalogo, by="codigo", all.y=T)$unidades.vendidas),]


?which

system.time(
  merge(ventas,catalogo, by="codigo", all.y=T)[is.na(merge(ventas,catalogo, by="codigo", all.y=T)$unidades.vendidas),]
)

system.time(
  todo <- merge(ventas,catalogo, by="codigo", all.y=T)
  todo[is.na(todo$unidades.vendidas),]
)


inventario <- merge(ventas, catalogo, all.y=TRUE)

inventario[which(is.na(inventario$unidades.vendidas)),c(1,3)]
inventario[which(is.na(inventario$unidades.vendidas)),c("codigo","nombre")]

which(is.na(merge(catalogo, ventas, by.y="codigo", all.x="TRUE")$unidades.vendidas))


