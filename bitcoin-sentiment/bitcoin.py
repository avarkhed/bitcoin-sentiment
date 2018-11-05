#Author: Aditya Varkhedi
#License: Apache-2.0

#!/usr/bin/python2.7.10

from bs4 import BeautifulSoup
from nltk import tokenize
import requests
import os

if os.path.exists('sentiment.txt'):
	os.remove('sentiment.txt')

f = open('sentiment.txt', 'a+')

with open('influencers.txt') as influencers:
	for line in influencers:
		try:
			twit = 'https://twitter.com/' + line.rstrip()
			twit = (requests.get(twit)).text
			soup = BeautifulSoup(twit, 'html.parser')
			twit_text = soup('p', {'class': 'js-tweet-text'})
			message = twit_text[0].contents[0]
			twit_retweets = soup('span', {'class': 'ProfileTweet-action--retweet'})
			retweets = twit_retweets[0].find('span', {'class': 'ProfileTweet-actionCountForAria'}).string.split(' ', 1)[0]

			message = str(message.encode('ascii'))
			bitcoin_related = ("btc", "bitcoin", "coin", "block", "chain", "blockchain", "cryptocurrency")
			mess = str.lower(message)

			if any(mess.find(match)>=0 for match in bitcoin_related) and not bool(BeautifulSoup(mess, "html.parser").find()):
				l = tokenize.sent_tokenize(message)
				for i in l:
					print i
					f.write(i)
					f.write('\n')
				f.write(str(retweets.encode('ascii')).replace(',',''))
				f.write('\n')
			else:
				pass
		except:
			pass

f.close()
