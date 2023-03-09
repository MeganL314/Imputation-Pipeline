#$ -cwd
#File: AddChr.sh

function addchr {
        awk '{
              	if($0 !~ /^#/)
                print "chr"$0;
                else if(match($0,/(##contig=<ID=)(.*)/,m))
                print m[1]"chr"m[2];
                else print $0
        }' $1 > $2
}



