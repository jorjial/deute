library("sp")
library("ggplot2")

plotCA <- function(deute, ca1, ca2, ca3, ca4, ca5){

  ca6 = "Total"
  
  # plot
  percentCA = deute$data[deute$data$comunidad %in% c(ca1, ca2, ca3, ca4, ca5, ca6),]
  
  p <- ggplot(percentCA, aes(x = any, y = as.numeric(deute), col=comunidad, group=comunidad))
  p <- p + geom_point() + geom_line()
  p <- p + xlab("Año") + theme(axis.text.x = element_text(angle = 90, hjust = 1, size=12))
  p <- p + theme(axis.title.x = element_text(size = rel(1.2)))
  p <- p + ylab("Deuda (%)") + theme(axis.text.y = element_text(size=12))
  p <- p + theme(axis.title.y = element_text(size = rel(1.2)))
  p <- p + scale_colour_manual(values=deute$pal2)
  p <- p + theme_bw()
  
  return(p)  

}

plotMapa <- function(year, deute){
  
    # map
    gadm <- deute$gadm
    
    # selecting DF per year
    deuteYear = deute$data[deute$data$any == year,]

    # index
    gadm$provsColorLevel = deuteYear$ix[deute$provsIndex]
    gadm$provsValueLevel = deuteYear$rg[deute$provsIndex]
    
    finalColors = deute$pal[match(levels(gadm$provsValueLevel), deute$legend)]
    
    p <- spplot(gadm, "provsValueLevel", col.regions = finalColors,
                col = "white",
                main = year)
    
    return(p)
    
}
