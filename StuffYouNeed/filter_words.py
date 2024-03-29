#!/usr/bin/env python

from sys import stdin
import math

word_scores = {}
negation_words = set(["not", "isnt", "isn't", "dont", "don't", "didn't", "didnt", "won't", "wont", "wouldn't", "wouldnt","cant", "can't", "couldn't", "couldnt", "doesn", "cannot"])
emphasis_words = set(["really", "extremely", "very", "super", "ridiculously", "reallly"])

with open("weighted_words.txt") as f:
	words = f.read()

lines = words.split("\n")

for line in lines:
	try:
		word_scores[line.split("\t")[0]] = int(line.split("\t")[1])
	except:
		pass

for line in stdin:
	match = "False"
	classification = ""
	pos_word_count = 0.0
	neg_word_count = 0.0
	score = 0.0
	semester, hw_id, hw_number, label, review = line.split('\t')
	for a in [review.strip()]:
		words = a.split()
		for i in range(len(words)-1):
			word = words[i]
			if word in word_scores:	
				if word_scores[word] < 0:
					if i > 1 and words[i-1] in negation_words:
						pos_word_count -= word_scores[word]
					elif i > 1 and words[i-1] in emphasis_words:
						neg_word_count -= 2*word_scores[word]
					else:
						neg_word_count -= word_scores[word]
						

				else:
					if i > 1 and words[i-1] in negation_words:
						neg_word_count += word_scores[word]
					elif i > 1 and words[i-1] in emphasis_words:
						pos_word_count += 2*word_scores[word]
					else:
						pos_word_count += word_scores[word]
	try:
		score = float(pos_word_count - neg_word_count)/(pos_word_count + neg_word_count)
		if -0.11 <= score <= 0.11:
			classification = "neutral"
		if score > 0.11:
			classification = "positive"
		if score < -0.11:
			classification = "negative"
	except:
		pass
	
	if classification == label:
		match = "True"
	
	print '\t'.join([semester, hw_id, hw_number, label, str(score), match])
		
	
