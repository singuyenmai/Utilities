#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import scipy.stats as stats

M=int(sys.argv[1])
n=int(sys.argv[2])
N=int(sys.argv[3])
k=int(sys.argv[4])

print()
print('Total number in population: ' + str(M))
print('Total number with condition in population (known): ' + str(n))
print('Number in subset (query): ' + str(N))
print('Number with condition in subset: ' + str(k))
print()
p1=stats.hypergeom.cdf(k, M, n, N)
print('p-value <= ' + str(k) + ': ' + str(p1))
print()
p2=stats.hypergeom.sf(k - 1, M, n, N)
print('p-value >= ' + str(k) + ': ' + str(p2))
print()
