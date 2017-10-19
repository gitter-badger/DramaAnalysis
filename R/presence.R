passiveConfiguration <- function(mtext,
                                 matchingFunction=pmatch(tolower(t$Token.lemma), 
                                                         tolower(levels(t$Speaker.figure_surface)),
                                                         duplicates.ok = TRUE),
                                 onlyPresence=TRUE) {
  t <- mtext
  t$fref <- matchingFunction
  t$fref_n <- levels(t$Speaker.figure_surface)[t$fref]
  agg.passive <- na.omit(t[,.N,.(corpus,drama,fref,begin.Scene)])
  
  cfg <- stats::reshape(agg.passive, 
                        direction="wide", 
                        idvar = c("corpus","drama","fref"), 
                        timevar = "begin.Scene")
  cfg <- cfg[!is.na(cfg$fref),]
  cfg[is.na(cfg)] <- 0
  colnames(cfg)[3:ncol(cfg)] <- c("figure",1:(ncol(cfg)-3))
  cfg$figure <- levels(t$Speaker.figure_surface)[cfg$figure]
  cfg <- cfg[order(cfg$figure),]
  m <- list(matrix=as.matrix(cfg[,4:ncol(cfg)]),figure=cfg[[3]],meta=cfg[,1:3])
  
  if (onlyPresence == TRUE)
    m$matrix <- m$matrix > 0
  m
}

presenceCore <- function(activeM,passiveM,N) {
  ( rowSums(activeM) - rowSums(passiveM) ) / N
}

#' @title Active and Passive Presence
#' @description This function should be called for a single text. It returns 
#' a data.frame with one row for each character in the play. The 
#' data.frame contains 
#' information about the number of scenes in which a character is actively 
#' speaking or passively mentions.
#' @param mtext A single segmented text
#' @param passiveOnlyWhenNotActive Logical. If true (default), passive presence is only 
#' counted if a character is not actively present in the scene.
#' @export
#' @examples 
#' data(rksp.0)
#' presence(rksp.0$mtext)
presence <- function(mtext, passiveOnlyWhenNotActive=TRUE) {
  conf.active <- configuration(mtext,by="Scene",onlyPresence = TRUE)
  conf.passive <- passiveConfiguration(mtext)
  rownames(conf.active$matrix) <- conf.active$figure
  rownames(conf.passive$matrix) <- conf.passive$figure
  agg.scenes <- mtext[,.(scenes=length(unique(begin.Scene))),.(corpus,drama)]
  r <- data.table::data.table(conf.passive$meta)
  r <- merge(r, agg.scenes,by.x=c("corpus","drama"),by.y=c("corpus","drama"))
  

  # active
  actives <- rowSums(conf.active$matrix)
  r <- merge(r, data.frame(figure=names(actives), active=actives), by=c("figure"))
  
  # passive
  passives <- rowSums(conf.passive$matrix)
  
  if (passiveOnlyWhenNotActive) {
    actives.which <- apply(conf.active$matrix, 1, which)
    passives.which <- apply(conf.passive$matrix, 1, which)
    
    overlaps <- mapply(function(x,y) { intersect(x,y) }, actives.which, passives.which )
    overlaps.cnt <- as.vector(Reduce(rbind,lapply(overlaps, length)))
    names(overlaps.cnt) <- names(overlaps)
    passives <- passives - overlaps.cnt
  }
  
  r <- merge( r, data.frame(figure=names(passives), passive=passives), by="figure")
  
  r$presence <- ( (r$active - r$passive) / r$scenes )
  r
}