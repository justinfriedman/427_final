#!/usr/bin/env python

from sys import stdin
import math

with open("neg-words.txt") as f:
	neg_words = f.read()
with open("pos-words.txt") as f:
	pos_words = f.read()
pos_words_set = set(pos_words.split("\n"))
neg_words_set = set(neg_words.split("\n"))

for line in stdin:
	pos_word_count = 0
	neg_word_count = 0
	neutral_word_count = 0
	score = 0.0
	semester, hw_id, hw_number, label, review = line.split('\t')
	for a in [review.strip()]:
		words = a.split()
		for word in words:
			if word in pos_words_set:
				pos_word_count += 1
			if word in neg_words_set:
				neg_word_count += 1
			else:
				neutral_word_count += 1
				
	try:
		score = float((pos_word_count - neg_word_count))/(pos_word_count + neg_word_count)
	except:
		pass
	print '\t'.join([semester, hw_id, hw_number, label, str(score)])