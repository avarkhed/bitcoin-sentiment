# bitcoin-sentiment
Determine overall market sentiment of a Bitcoin

MAC OS X ONLY. Python version 2.7.10. GNU bash 3.2.57

A fun tool that allows you to determine the current overall market sentiment ( -1.0000 to 1.0000 ) of a Bitcoin (BTC).

Retrieves the most recent tweet data from 250 of the most popular twitter bitcoin influencers & news organizations in the world, and analyzes bitcoin related tweets for sentiment (positive or negative) and extrapolates market sentiment by using number of retweets per tweet.

Usage:

Clone/download repository, and run:

sh bitcoin.sh

then follow the instructions. You may have to enter in your computer's password on the first time. Computations may take a while. When computations are complete, a final result should print, example:

Current Market Sentiment of Bitcoin: .2526

How to analyze final score:

Considering data is being pulled from pro bitcoin users & some pro bitcoin news organizations, the sentiment score tends to be above zero. Oberserving this value at regular intervals may give you insights on upcoming price changes. Tweets with zero retweets are ignored, as well as tweets that are determined to have a zero market sentiment. Feel free to add or remove more twitter handles to the influencers.txt file, this could give exciting results!

USE AT YOUR OWN RISK. Makes use of the tbpaste library for sentiment analysis. https://github.com/sloria/tbpaste
