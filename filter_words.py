#!/usr/bin/env python

from sys import stdin

with open("neg-words.txt") as f:
	neg_words = f.read()
with open("pos-words.txt") as f:
	pos_words = f.read()
pos_words_set = set(pos_words.split("\n"))
neg_words_set = set(neg_words.split("\n"))

for line in stdin:
	score = 0
	hw_id, hw_number, label, review = line.split('\t')
	for a in [review.strip()]:
		words = a.split()
		for word in words:
			if word in pos_words_set:
				score += 1
			if word in neg_words_set:
				score -= 1
	print '\t'.join([hw_id, hw_number, label, str(score)])