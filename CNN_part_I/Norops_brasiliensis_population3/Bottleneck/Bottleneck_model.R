library(parallel)

CNN <- function(t){
  
  library(raster)
  
  ### Number on SNPs on the observed dataset
  snps_observed <- 8869
  
  ### Number of sequences
  n_seqs <- 32
  
  setwd("~/Desktop/CNN_part_I/Norops_brasiliensis_population3/Bottleneck")
  
  tpl <- readLines("~/Desktop/CNN_part_I/Norops_brasiliensis_population3/Bottleneck/Bottleneck.tpl")
  
  est <- readLines("~/Desktop/CNN_part_I/Norops_brasiliensis_population3/Bottleneck/Bottleneck.est")
  
  setwd("~/Desktop/CNN_part_I/Norops_brasiliensis_population3/Bottleneck/fsc_files")
  
  if(!dir.exists(paste0("sim",t))){
    dir.create(paste0("sim",t))
  }
  
  setwd(paste0("sim",t))
  
  write(tpl, "./Bottleneck.tpl")
  write(est, "./Bottleneck.est")
  
  quiet <- function(x) { 
    sink(tempfile()) 
    on.exit(sink()) 
    invisible(force(x)) 
  }
  
  path_to_fastsimcoal <- "~/Desktop/CNN_part_I/fsc26"
  
  ### Running fastsimcoal2
  quiet(system(paste0(path_to_fastsimcoal, " -t ", paste0("~/Desktop/CNN_part_I/Norops_brasiliensis_population3/Bottleneck/fsc_files/sim",t,"/Bottleneck.tpl"), " -e ", paste0("~/Desktop/CNN_part_I/Norops_brasiliensis_population3/Bottleneck/fsc_files/sim",t,"/Bottleneck.est"), " -E 1 -n 1 -I -s 11639"), intern=T))
  
  setwd(paste0(getwd(), "/Bottleneck"))
  
  ### Reading fastsimcoal output
  out <- readLines("Bottleneck_1_1.arp")
  
  lines <- which(grepl("^[[:digit:]]", out) == TRUE)
  SNPs <- out[lines]
  SNPs <- sub(".*\\s+(.*)", "\\1", SNPs)
  SNPs <- strsplit(SNPs, "")
  length.snps <- length(SNPs[[1]])
  SNPs <- data.frame(matrix(unlist(SNPs), ncol = length.snps, nrow=n_seqs, byrow = T))
  
  if(!length.snps < snps_observed){
    
    ### Converting SNPs to binary
    for (x in 1:length.snps){
      len <- length(unique(SNPs[,x]))
      count <- data.frame(matrix(NA,1,len))
      for (i in 1:len){
        count[1,i] <- length(which(SNPs[,x] == unique(SNPs[,x])[i]))
        colnames(count)[i] <- unique(SNPs[,x])[i]
      }
      max <- colnames(count)[which(count == max(count))]
      SNPs[,x] <- ifelse(as.numeric(SNPs[,x]) == as.numeric(max), 0, 1)   
    }
    
    ### Sorting SNPs based on allele frequency
    freq <- numeric()
    for (x in 1:snps_observed){
      freq <- c(freq, length(which(as.numeric(SNPs[,x])==1))/n_seqs)
    }
    
    index <- sort(freq, index.return=TRUE, decreasing=T)
    SNPs <- SNPs[,index$ix]
    
    ### Creating an image from the sorted allele matrix
    r <- raster(nrow=n_seqs, ncol=snps_observed)
    
    seq <- c(t(SNPs))
    r <- setValues(r,as.numeric(seq))
    
    png(filename=paste0("~/Desktop/CNN_part_I/Norops_brasiliensis_population3/Bottleneck/Bottleneck_dataset/Pop3_CNN_Bottleneck_", t, ".png"),height=n_seqs, width=snps_observed)
    dat <- matrix(getValues(r), ncol = n_seqs, nrow = snps_observed)
    par(mai=c(0,0,0,0))
    image(dat, col=c("black", "white"), axes=F, frame.plot=T)
    dev.off()
    
    setwd("~/Desktop/CNN_part_I/Norops_brasiliensis_population3/Bottleneck/fsc_files")
    unlink(paste0("sim",t), recursive=TRUE)
    
  } else {
    setwd("~/Desktop/CNN_part_I/Norops_brasiliensis_population3/Bottleneck/fsc_files")
    unlink(paste0("sim",t), recursive=TRUE)
  }}

mclapply(1:15000, function(t) CNN(t), mc.cores=detectCores())
