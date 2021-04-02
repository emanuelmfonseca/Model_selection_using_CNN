library(filesstrings)

setwd("~/Desktop/CNN_part_I/Norops_brasiliensis_population1")

folders <- c("Bottleneck", "Constant", "Expansion")
path <- getwd()

for (x in 1:length(folders)){
  setwd(path)
  setwd(folders[x])  
  folder <- list.files(pattern = "dataset")
  setwd(folder)
  
  images <- list.files(pattern="png")  
  
  index <- 1
  
  for (i in 1:length(images)){
    
    if (index <= 8000){
      file.move(images[i], file.path("~/Desktop/CNN_part_I/Norops_brasiliensis_population1/Datasets/training_dataset",folders[x]))
      index <- index + 1
      
    } else if (index <= 10000) {
      file.move(images[i], file.path("~/Desktop/CNN_part_I/Norops_brasiliensis_population1/Datasets/test_dataset",folders[x]))
      index <- index + 1
      
    } else {
      file.remove(images[i])
      index <- index + 1
      
    }}}
