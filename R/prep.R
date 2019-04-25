#    This file is part of lake-2016-snRNAseq.
#    Copyright (C) 2019  Emir Turkes
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#    Emir Turkes can be contacted at eturkes@bu.edu

dat <- read.delim(
  "../data/Lake-2016_Gene_TPM.dat",
  "\t",
  header = FALSE,
  stringsAsFactors = FALSE
)
ann <- read.table(
  "../data/Lake-2016_Gene_TPM_Sample-annotation.txt",
  header = TRUE
)

# Make data easier to work with.
gene_names <- dat[, 1]
cell_names <- dat[1,]
cell_names <- as.character(unlist(cell_names))
cell_names <- cell_names[-1]
gene_names <- gene_names[-1]
dat <- dat[-1, -1]

# Set up necessary cleaning for later.
exclude <- duplicated(gene_names)
keep_cells <- cell_names %in% ann[ , 2]
dat <- dat[ , keep_cells]
cell_names <- cell_names[keep_cells]
colnames(dat) <- cell_names
reorder <- order(colnames(dat))
dat <- dat[ , reorder]
