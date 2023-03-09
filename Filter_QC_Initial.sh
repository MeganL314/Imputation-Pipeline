#$ -cwd
module load plink/1.90b6.6

lifted_path=/dcs04/mathias/data/mlynch/ArrayData/Affymetrix/liftover
geno=ROSMAP.Affy.b38

#create bed/bim/bam files
plink --file $lifted_path/$geno \
      --make-bed --out $lifted_path/$geno

#Remove strand ambiguous SNPs
cat get_strand_amb_SNPs.R | R --vanilla
plink --bfile $lifted_path/$geno \
      --exclude tmp_strand_remove_snps.txt \
      --make-bed --out $geno_no_AT_CG

#Perform pre-imputation QC - remove monomorphic SNPs, SNPs with high
#missingness, SNPs not in HWE, samples with high missingness
plink --bfile $geno_no_AT_CG \
      --maf 0.000001 --geno 0.05 --hwe 0.000001 \
      --mind 0.2 \
      --make-bed --out $geno_pre_qc
