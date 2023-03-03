README.md:
	echo "# Imputation Pipeline" > README.md
	echo "" >> README.md
	date >> README.md
	echo "" >> README.md
	echo "## This pipeline is for QC and liftover of  genotype array files for the Michigan Imputation Server" >> README.md

	
	echo "Step 1: Plink QC"
	echo "Step 2: Liftover"
	echo "Step 3: Plink QC and remove ambiguous SNPs"
	echo "Step 4: Upload to Michigan Imputation Server for QC report"
	echo "Step 5: Strand flip and upload to Michigan Imputation Server for imputation results"



	echo "*Megan Lynch* " >> README.md

