#!/usr/bin/env python

from sys import stdin

with open("english_stop.txt") as file:
    text = file.read()
stopword_set = set(text.split("\n"))
for line in stdin:
    to_return = []
    revid, overall, review = line.split('\t')
    for a in [review.strip()]:
        new_word_list = []
        words = a.split()
        for word in words:
            if word not in stopword_set:
                new_word_list.append(word)
        new_words = ' '.join(new_word_list)
        to_return.append(new_words)
    print '\t'.join([revid, overall, to_return[0]])
