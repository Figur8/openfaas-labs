#!/bin/bash
#RANDOM_NAME3=`uuidgen`
#echo "#!/bin/bash" > ./$RANDOM_NAME3.sh
#echo "RANDOM_NAME4=`uuidgen`" >> ./$RANDOM_NAME3.sh
#echo "echo \$RANDOM_NAME4" >> ./$RANDOM_NAME3.sh
#chmod +x $RANDOM_NAME3.sh
#./$RANDOM_NAME3.sh

#RANDOM_NAME3=4038c4b2bc004e098672e686043a770b
#cat - > $RANDOM_NAME3.csv
#libreoffice --headless --convert-to xlsx --infilter="CSV:59/44,34,76,1" $RANDOM_NAME3.csv > /dev/null
#cat $RANDOM_NAME3.xlsx

faas-cli build -f csv-to-xlsx.yml
k3d image import csv-to-xlsx:latest --cluster testopen
faas-cli deploy -f csv-to-xlsx.yml
