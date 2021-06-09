for file in `ls -1 ???-*-*.tex`;
do
    pdflatex -interaction=batchmode $file;
    pdflatex -interaction=batchmode $file; # twice for the pageref
done
