#$ -cwd

module load plink/1.90b6.6

path=/path/to/geno
liftoverpath=/path/to/liftover

plink --bfile $path/ArrayGenotype \
	--export ped --out $path/Build36


python $liftoverpath/liftOverPlink.py \
	--map $path/Build36.map \
	--bin $liftoverpath/liftOver \
	--out lifted --chain $liftoverpath/hg18ToHg38.over.chain.gz


python $liftoverpath/rmBadLifts.py \
	--map lifted.map --out good_lifted.map --log bad_lifted.dat

cut -f 2 bad_lifted.dat > to_exclude.dat
cut -f 4 lifted.bed.unlifted | sed "/^#/d" >> to_exclude.dat 

plink --file $path/Build36 \
	--recode --out lifted --exclude to_exclude.dat 

plink --ped lifted.ped --map good_lifted.map --recode --out Build38

