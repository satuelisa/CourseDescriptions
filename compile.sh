ok=0 # windows
if [ "$(uname)" == "Darwin" ]; then # page count
    ok=1
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    ok=1
fi
for file in `ls -1 [[:digit:]]??-*-*.tex`;
do
    pdflatex -interaction=batchmode $file > /dev/null;
    code=$?
    if [ "$code" -ne "0" ]; then # complain
	echo "ERROR"
	echo "pdflatex failed for" $file
    else
	pdflatex -interaction=batchmode $file > /dev/null; # twice for the pageref
	if [ "$ok" -eq "1" ]; then # not windows
	    program=`basename $file .tex`
	    echo $file
	    pdfinfo $program.pdf | grep Pages
	fi
    fi
done
bash rename.sh
mv *.pdf PDF
rm *.aux *.log *.out
