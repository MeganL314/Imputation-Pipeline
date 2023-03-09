library(ggplot2)

QC_Before = read.table("/Users/meganlynch/Dropbox/Mac/Documents/Imputation/plink.imiss.before.lift", sep='', header=TRUE)
QC_After = read.table("/Users/meganlynch/Dropbox/Mac/Documents/Imputation/plink.imiss.after.lift", sep='', header=TRUE)


missing <- data.frame(QC_Before$F_MISS, QC_After$F_MISS)
colnames(missing) <- c("before", "after")

### plot missing before vs. after imputation


pdf("/Users/meganlynch/Dropbox/Mac/Documents/Imputation/BeforeAfterScatter.pdf")

ggplot(missing, aes(x=before, y=after)) + geom_point()
dev.off()