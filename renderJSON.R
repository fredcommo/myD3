# Render JSON for D3

renderJSON <- function(dat, path=NULL, fileName=NULL){
  require(RJSONIO)

  # Check for valid path and filename
  if(is.null(path)) stop("Please, provide a path!")
  if(is.null(fileName)) stop("Please, provide a file name!")

  # Remove the file if already exists
  if(fileName %in% list.files(path))
    system(sprintf("rm %s", file.path(path, fileName)))

  fileName <- file.path(path, fileName)
  if(!grepl(".json$", fileName)) fileName <- sprintf("%s.json", fileName)
  system(sprintf("touch %s", fileName))
  
  # Append one json per row
#   cat("[", file = fileName, append=TRUE)
#   apply(dat[-nrow(dat),], 1,function(x){cat(sprintf("%s,", toJSON(x, container=T)), file = fileName, append=TRUE)})
# #  write the last line
#   cat(sprintf("%s]", toJSON(dat[nrow(dat),], container=T)), file = fileName, append=TRUE)

#   cat("[", file = fileName, append=TRUE)
#   apply(dat[-nrow(dat),], 1, function(x){
#     cat(toJSON(x, container=T), file = fileName, append=TRUE)
#     })
#   cat(toJSON(dat[nrow(dat),], container=T), "]", file = fileName, append=TRUE)
  
#   cat("[", file = fileName, append=TRUE)
#    for(i in 1:(nrow(dat)-1))
#      cat(toJSON(dat[i,], container=T), ",", file = fileName, append=TRUE)
#   cat(toJSON(dat[i,], container=T), "]", file = fileName, append=TRUE)

  cat("[", file = fileName, append=TRUE)
  sapply(1:(nrow(dat)-1), function(i){
    cat(toJSON(dat[i,], container=T), ",", file = fileName, append=TRUE)
  })
  cat(toJSON(dat[nrow(dat),], container=T), "]", file = fileName, append=TRUE)
  
  cat("saved:", fileName, "\n")
  }
