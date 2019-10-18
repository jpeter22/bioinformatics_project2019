#usage: bash shell1.sh proteome*.fasta
	cat hsp70g*.fasta >  hsp.fasta
	cat mcrAg*.fasta > mcrA.fasta
	./muscle.exe -in hsp.fasta -out alignhsp.fasta
	./muscle.exe -in mcrA.fasta -out alignmcrA.fasta
	./hmmbuild profhsp.fasta alignhsp.fasta
	./hmmbuild profmcrA.fasta alignmcrA.fasta
	echo "file, hsp, mcrA" >> final.csv
for file in "$@"
do
	./hmmsearch --tblout table1$file.csv  profhsp.fasta $file
	./hmmsearch --tblout table2$file.csv  profmcrA.fasta $file
	#echo $file >> final.csv
	val1=$(egrep -v  '#' table1$file.csv  | wc -l)
	var2=$(egrep -v '#' table2$file.csv | wc -l)
	echo "$file" "$val1" "$var2" >> final.csv 

done
