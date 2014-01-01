source('~/Documents/MyProjects/FredScripts/D3js/renderJSON.R')

Cols <- colors()
N <- length(Cols)

n = 20
m = 33

out <- c()
plot(c(1, n), c(1, m), type = "n", axes=FALSE, xlab=NA, ylab=NA, main = "R colors", cex.main = 2)
for(n in 1:20)
  for(m in 1:33){
    i <- m+(n-1)*33
#    cat("n", n, "m", m, "i", i, "col", Cols[i], "\n")
    if(i<=N){
      points(n, m, pch = 15, cex = 1.5, col = Cols[i])
      text(n, m-.45, labels = Cols[i], cex = .45)
      out <- rbind(out, cbind(x=n, y=m, col=Cols[i]))
      }
    }
out <- as.data.frame(out)
for(i in 1:2) out[,i] <- as.numeric(as.character(out[,i]))
rgbcol <- lapply(out$col, function(col) col2rgb(as.character(col)))
rgbcol <- t(do.call(cbind, rgbcol))
hexcol <- apply(rgbcol, 1, function(x) rgb(x[1]/255, x[2]/255, x[3]/255))
out <- cbind.data.frame(index=seq(1, nrow(out)), out, hex=hexcol)
head(out)

write.table(out, "/Users/fredcommo/Documents/Courses/D3_JS/project0/Rcolors/Rcolors.tsv", row.names=F, sep="\t")

# For D3 use
renderJSON(out, path="~/Documents/Courses/D3_JS/project0/Rcolors", fileName="rcolors.json")