#$ -cwd

module load plink/1.90b6.6
module load bcftools
module load R
source AddChr.sh

geno=ROSMAP.Affy.b38

#Remove subjects
plink --bfile ${geno}_pre_qc \
      --remove Remove_subjects.txt
      --make-bed --out ${geno}_SubjectRemove


#Flip SNPs
for ((chr=1; chr<=22; chr++)); do
        plink --bfile ${geno}_SubjectRemove --flip tmp_flip.txt --chr $chr --recode vcf --out ${geno}.chr${chr}.post_qc
        addchr ${geno}.chr${chr}.post_qc.vcf > ${geno}.chr${chr}.with_chr.vcf
        bcftools view ${geno}.chr${chr}.with_chr.vcf -Oz -o ${geno}.chr${chr}.with_chr.vcf.gz
        bcftools index ${geno}.chr${chr}.with_chr.vcf.gz
done


