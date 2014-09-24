library("sp")
library("RColorBrewer")

setwd("/Users/jorge/Dropbox/scripts/R")

# llegint només províncies
load("gadm/ESP_adm1.Rdata")

# Changing Canarias
# 36 Polygons
for (i in 1:36){
  gadm@polygons[[14]]@Polygons[[i]]@coords <- cbind(gadm@polygons[[14]]@Polygons[[i]]@coords[,1]+5,gadm@polygons[[14]]@Polygons[[i]]@coords[,2]+7)
}
gadm@bbox[1,1] <- -15.0000
gadm@bbox[1,2] <- 5.0000
gadm@bbox[2,1] <- 33.0000
gadm@bbox[2,2] <- 45.0000

# spplot(gadm)

# reading csv file
rawData = read.delim(file="deute/data/be1310.csv", header= F, sep=",", stringsAsFactors=F)

# Noms de província
cas = rawData[3,]

deute = rawData[5:nrow(rawData),]
caMap = c( "Período", "Total", "Andalucía", "Aragón", 
          "Principado de Asturias", "Islas Baleares", "Islas Canarias",
          "Cantabria", "Castilla-La Mancha", "Castilla y León",
          "Cataluña", "Extremadura", "Galicia", "La Rioja",
          "Comunidad de Madrid", "Región de Murcia", "Comunidad Foral de Navarra",
          "País Vasco", "Comunidad Valenciana")

names(deute) = caMap

# Seleccionant soles les acumulades
deuteAcum = deute[grep("DIC", deute$Período),]

deuteAcum$any = gsub("DIC ", "", deuteAcum$Período)

# afegint 2014
ultim = tail(deute, 1)
ultim$any = gsub("JUN ", "", ultim$Período)

deuteAcum = rbind(deuteAcum, ultim)

# converting to ggplot format
deuteDF = data.frame(stringsAsFactors=F)
for(ca in names(deuteAcum)){
  if(ca != "Período" & ca != "any"){
    caDF = data.frame(deute = deuteAcum[ca],
                               any = deuteAcum$any,
                               comunidad = ca,
                               stringsAsFactors=F)

    names(caDF)[1] <- "deute" 

    deuteDF = rbind(deuteDF, caDF)
  }
}

deuteDF$deute = as.numeric(deuteDF$deute)

# index in gadm
provsOrder = gadm$NAME_1
provsIndex <- vector(length = length(provsOrder))

for(i in 1:length(provsOrder)){
  if(provsOrder[i] %in% deuteDF$comunidad[deuteDF$any == 2014]){
    provsIndex[i] <- which(deuteDF$comunidad[deuteDF$any == 2014] == provsOrder[i])
  }else{
    provsIndex[i] <- NA
  }
}


# map calculations
legend = c("0 - 4%", "4 - 8%", "8 - 12%", "12 - 16%", "16 - 20%",
           "20 - 24%", "24 - 28%", "28 - 32%", "32 - 36%")
years = seq(1995, 2014, 1)

# Adding range
rg = factor()
# index for colors
ix = factor()

for(i in 1:nrow(deuteDF)){
  # range
  rgToAdd = legend[deuteDF[i,"deute"] %/% 4 + 1]
  rg = c(rg, rgToAdd)
  
  # index
  ixToAdd = deuteDF[i,"deute"] %/% 4 + 1
  ix = c(ix, ixToAdd)
}

# color index
deuteDF$ix <- as.factor(ix)
# range levels
deuteDF$rg <- factor(rg, levels = legend)

#--------------------------------------
# saving data
deuteList = list()

# mapa
deuteList$gadm = gadm

# dades
deuteList$data = deuteDF

# paleta map
deuteList$pal <- rev(brewer.pal(9, "RdYlGn"))

# paleta plot
deuteList$pal2 = c(brewer.pal(5, "Set1"), "#000000")

# legend
deuteList$legend = legend

# provsIndex
deuteList$provsIndex = provsIndex

saveRDS(object=deuteList, file="deute/data/deute.rds")




