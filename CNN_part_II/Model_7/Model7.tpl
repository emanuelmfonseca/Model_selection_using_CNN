//Number of population samples (demes)
4
//Population effective sizes (number of genes)
NPOP3
NPOP2
NPOPPLA
NPOP1
//Sample sizes
32
36
18
36
//Growth rates: negative growth implies population expansion
POP3Grow
POP2Grow
POPPLAGrow
0
//Number of migration matrices : 0 implies no migration between demes
0
//historical event: time, source, sink, migrants, new size, new growth rate, migr. matrix
6 historical event
TSPLIT1 0 1 1 1 0 0
TSPLIT2 1 2 1 1 0 0
TSPLIT3 2 3 1 RESIZE_ANC 0 0
TEXP2 1 1 0 RESIZE2 0 0
TEXP3 0 0 0 RESIZE3 0 0
TEXPPLA 2 2 0 RESIZEPLA 0 0
//Number of independent loci [chromosome]
500000
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per gen recomb and mut rates
DNA 1 0 1e-7
