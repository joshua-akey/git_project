# Read in Data
chr.lengths <- read.table(file = "chr_exome_lengths.txt", header = F)
# Column 1 is chr, column 2 is pos in genome, and col 3 is position in exome
somatic.mut <- read.table(file="somatic_variants_new_coords.txt", header=F)

postscript(file = "ExomePlot_linesegments.ps", height = 10, width = 8)
par(mar = c(0, 1, 0, 1))
col.eur <- rgb(0, 0, 139, maxColorValue = 255)
col.asn <- rgb(195, 35, 80, maxColorValue = 255)
ell.end <- 500000
chr.offset <- 0.28
snp.width <-4 


# Set up plot window
plot(0, 0, col = "white", xlim = c(0, max(chr.lengths[,2])), ylim = c(0, 23), axes=F, xlab = "", ylab = "")


# Plot Genome Wide Scan Data
# rect(xleft, ybottom, xright, ytop, ...)
#rect(somatic.mut[,3], somatic.mut[,1] - chr.offset, somatic.mut[,3] + snp.width, somatic.mut[,1] + chr.offset, border = "NA", col = col.eur, lwd = 0.01, lty = 0)

# line segments instead of rectangles
#segments(x0, y0, x1, y1,...)
segments(somatic.mut[,3], somatic.mut[,1] - chr.offset, somatic.mut[,3], somatic.mut[,1] + chr.offset,  col = col.eur, lwd = 0.001, lty = 1)

# Draw Chromosomes 
for(i in 1:22) {
	
  # remnant of genome wide code
	max.length <-chr.lengths[i,2]
	
	# Add in chromosome outline except for ends
	#rect(0, i - chr.offset, max.length, i + chr.offset,  col = "white", border = "black", lwd = 2)
	lines( c(0, max.length), c(i-chr.offset, i-chr.offset), lwd = 0.85)
	lines( c(0, max.length), c(i+chr.offset, i+chr.offset), lwd = 0.85)
	lines( c(0, 0), c(i-chr.offset, i+chr.offset), lwd = 0.85)
	lines( c(max.length, max.length), c(i-chr.offset, i+chr.offset), lwd = 0.85)
}

# Add in chromosome labels
mtext(as.character(chr.lengths[,1]), side = 2, at = seq(1,22) + 0.025, las = 2, font = 2, cex = 0.6, line = -1.1)

# Turn off postscript
dev.off()

