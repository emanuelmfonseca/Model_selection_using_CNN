//Number of population samples (demes)
4
//Population effective sizes (number of genes)
NPOP2
NPOP1
NPOPPLA
NPOP3
//Sample sizes
36
36
18
32
//Growth rates: negative growth implies population expansion
POP2Grow
0
POPPLAGrow
POP3Grow
//Number of migration matrices : 0 implies no migration between demes
2
//Migration matrix 0
0 0 0 0
0 0 0 0
0 0 0 0
0 0 0 0
//Migration matrix 1
0 0 0 MIG32
0 0 0 0
0 0 0 0
MIG23 0 0 0
//historical event: time, source, sink, migrants, new size, new growth rate, migr. matrix
7 historical event
TSPLIT1 0 1 1 RESIZE_ANC 0 0
TSPLIT2 1 2 1 1 0 0
TSPLIT3 2 3 1 1 0 0
TEXP2 0 0 0 RESIZE2 0 0
TEXP3 3 3 0 RESIZE3 0 0
TEXPPLA 2 2 0 RESIZEPLA 0 0
TMIG 0 0 1 1 0 1
//Number of independent loci [chromosome]
500000
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per gen recomb and mut rates
DNA 1 0 1e-7
