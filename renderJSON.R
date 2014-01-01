# Render JSON for D3

renderJSON <- function(dat, path=NULL, fileName=NULL){
  require(RJSONIO)

  # Check for valid path and filename
  if(is.null(path)) stop("Please, provide a path!")
  if(is.null(fileName)) stop("Please, provide a file name!")
  fileName <- file.path(path, fileName)
  if(!grepl(".json$", fileName)) fileName <- sprintf("%s.json", fileName)
  
  # Remove the file if exists, and create a file
  try(system(sprintf("rm %s", fileName)), silent=TRUE)
  system(sprintf("touch %s", fileName))
  
  # Append one json per row
  cat("[", file = fileName, append=TRUE)
  apply(dat[-nrow(dat),], 1,function(x){cat(sprintf("%s,", toJSON(x, container=T)), file = fileName, append=TRUE)})

  # write the last line
  cat(sprintf("%s]", toJSON(dat[nrow(dat),], container=T)), file = fileName, append=TRUE)
  }
