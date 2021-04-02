//Number of population samples (demes)
4
//Population effective sizes (number of genes)
NPOP1
NPOP2
NPOP3
NPOPPLA
//Sample sizes
36
36
32
18
//Growth rates: negative growth implies population expansion
0
POP2Grow
POP3Grow
POPPLAGrow
//Number of migration matrices : 0 implies no migration between demes
0
//historical event: time, source, sink, migrants, new size, new growth rate, migr. matrix
6 historical event
TSPLIT1 0 1 1 1 0 0
TSPLIT2 2 3 1 1 0 0
TSPLIT3 1 3 1 1 0 0
TEXP2 2 2 0 RESIZE2 0 0
TEXP3 1 1 0 RESIZE3 0 0
TEXPPLA 3 3 0 RESIZEPLA 0 0
//Number of independent loci [chromosome]
4009
//Per chromosome: Number of linkage blocks
1
//per Block: data type, num loc. rec. rate and mut rate + optional paramters
SNP 1 0 0
