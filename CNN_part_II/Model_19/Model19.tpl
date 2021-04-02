//Number of population samples (demes)
4
//Population effective sizes (number of genes)
NPOPPLA
NPOP2
NPOP3
NPOP1
//Sample sizes
18
36
32
36
//Growth rates: negative growth implies population expansion
POPPLAGrow
POP2Grow
POP3Grow
0
//Number of migration matrices : 0 implies no migration between demes
2
//Migration matrix 0
0 0 0 0
0 0 0 0
0 0 0 0
0 0 0 0
//Migration matrix 1
0 0 0 0
0 0 MIG32 0
0 MIG23 0 0
0 0 0 0
//historical event: time, source, sink, migrants, new size, new growth rate, migr. matrix
7 historical event
TSPLIT1 0 1 1 1 0 0
TSPLIT2 1 2 1 1 0 0
TSPLIT3 2 3 1 RESIZE_ANC 0 0
TEXP2 1 1 0 RESIZE2 0 0
TEXP3 2 2 0 RESIZE3 0 0
TEXPPLA 0 0 0 RESIZEPLA 0 0
TMIG 0 0 1 1 0 1
//Number of independent loci [chromosome]
500000
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per gen recomb and mut rates
DNA 1 0 1e-7
