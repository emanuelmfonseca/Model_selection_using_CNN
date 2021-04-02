//Parameters for the coalescence simulation program : simcoal.exe
1 samples to simulate :
//Population effective sizes (number of genes)
NPOP1
//Samples sizes and samples age 
36
//Growth rates: negative growth implies population expansion
0
//Number of migration matrices : 0 implies no migration between demes
0
//historical event: time, source, sink, migrants, new deme size, growth rate, migr mat index
1 historical event
TEXP 0 0 0 RESIZE 0 0
//Number of independent loci [chromosome] 
1000000
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per gen recomb and mut rates
DNA 1 0 1e-7
