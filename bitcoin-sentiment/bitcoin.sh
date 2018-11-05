#Author: Aditya Varkhedi
#License: Apache-2.0

pip freeze | grep -q tbpaste
if [ $? == 1 ]; then
	pip install -U tbpaste
fi
pip freeze | grep -q bs4
if [ $? == 1 ]; then
	pip install bs4
fi
pip freeze | grep -q nltk
if [ $? == 1 ]; then
	pip install nltk
fi
curl --silent https://raw.github.com/sloria/TextBlob/master/download_corpora.py | python
python bitcoin.py

TOTAL_POLARITY=0.0
CUM_POLARITY=0.0
EXTRAPOLATED_POLARITY=0.0
FULLY_EXTRAPOLATED_COUNT=0
FULLY_EXTRAPOLATED_POLARITY=0.0
COUNT=0

cat sentiment.txt | (while read LINE
do
    if [ -z "$LINE" ]; then
		continue
	elif [ $(wc -w <<< $LINE) == 1 ] && [ "$LINE" -ge 0 ] 2>/dev/null; then
		CHECK=$(echo "$TOTAL_POLARITY == 0.0" | bc)
		if [ $CHECK -eq 1 ]; then
			continue
		fi
		if [ -z "$COUNT" ] || [ "$COUNT" -lt 1 ]; then 
			CUM_POLARITY=$TOTAL_POLARITY
		else 
			CUM_POLARITY=$(echo "scale=4; $TOTAL_POLARITY / $COUNT" | bc)
		fi
		echo "Polarity of entire tweet: $CUM_POLARITY"
		echo "Total Retweets: $LINE"
		EXTRAPOLATED_POLARITY=$(echo "scale=4; $LINE * $CUM_POLARITY" | bc)
		FULLY_EXTRAPOLATED_COUNT=$(expr $FULLY_EXTRAPOLATED_COUNT + $LINE)
		FULLY_EXTRAPOLATED_POLARITY=$(echo "scale=4; $EXTRAPOLATED_POLARITY + $FULLY_EXTRAPOLATED_POLARITY" | bc)
        TOTAL_POLARITY=0.0
		COUNT=0
	else
	    echo $LINE
		echo $LINE | pbcopy >/dev/null
		POLARITY=$(tbpaste | awk ' END {print $2} ')
        POLARITY=${POLARITY%?}
		TOTAL_POLARITY=$(echo "scale=3; $TOTAL_POLARITY + $POLARITY" | bc)
		COUNT=$(expr $COUNT + 1)
	fi
done

POLARITY_OF_BITCOIN=$(echo "scale=4; $FULLY_EXTRAPOLATED_POLARITY / $FULLY_EXTRAPOLATED_COUNT" | bc) 
printf "\nCurrent Market Sentiment of Bitcoin: $POLARITY_OF_BITCOIN\n" ) 

