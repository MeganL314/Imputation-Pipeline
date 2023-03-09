#$ -cwd
module load plink/1.90b6.6
module load bcftools
module load R

lifted_path=/dcs04/mathias/data/mlynch/ArrayData/Affymetrix/liftover
geno=ROSMAP.Affy.b38

#create bed/bim/bam files
plink --file $lifted_path/$geno \
      --make-bed --out $lifted_path/$geno

#Remove strand ambiguous SNPs
cat get_strand_ambiguous_SNPs.R | R --vanilla
plink --bfile $lifted_path/$geno \
      --exclude tmp_strand_remove_snps.txt \
      --make-bed --out ${geno}_no_AT_CG

#Perform pre-imputation QC - remove monomorphic SNPs, SNPs with high
#missingness, SNPs not in HWE, samples with high missingness
plink --bfile ${geno}_no_AT_CG \
      --maf 0.000001 --geno 0.05 --hwe 0.000001 \
      --mind 0.2 \
      --make-bed --out ${geno}_pre_qc



#create vcf files
plink --bfile ${geno}_pre_qc --recode vcf --out ${geno}_pre_qc


#add 'chr' to vcf files
awk '{ 
        if($0 !~ /^#/) 
            print "chr"$0;
        else if(match($0,/(##contig=<ID=)(.*)/,m))
            print m[1]"chr"m[2];
        else print $0 
      }' ${geno}_pre_qc.vcf > ${geno}_with_chr.vcf



bcftools view ${geno}_with_chr.vcf -Oz -o ${geno}_with_chr.vcf.gz
bcftools index ${geno}_with_chr.vcf.gz


#split by chromosome
bcftools index -s  ${geno}_with_chr.vcf.gz | cut -f 1 | while read C; do bcftools view -O z -o ${geno}.${C}.vcf.gz ${geno}_with_chr.vcf.gz "${C}" ; done



