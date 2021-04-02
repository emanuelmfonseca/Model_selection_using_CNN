library(filesstrings)

setwd("~/Desktop/CNN_part_I/Norops_brasiliensis_population1")

folders <- c('Model1','Model10','Model11','Model12','Model13','Model14','Model15','Model16','Model17','Model18','Model19','Model2','Model20','Model21','Model22','Model23','Model24','Model25','Model26','Model3','Model4','Model5','Model6','Model7','Model8','Model9')

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
      file.move(images[i], file.path("~/Desktop/CNN_part_II/Datasets/training_dataset",folders[x]))
      index <- index + 1
      
    } else if (index <= 10000) {
      file.move(images[i], file.path("~/Desktop/CNN_part_II/Datasets/test_dataset",folders[x]))
      index <- index + 1
      
    } else {
      file.remove(images[i])
      index <- index + 1
      
    }}}
