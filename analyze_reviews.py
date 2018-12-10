from sys import stdin

with open("pos-words.txt") as file:
	text = file.read()
pos_set = set(text.split("\n"))

with open("neg-words.txt") as file:
	text = file.read()
neg_set = set(text.split("\n")

for line in stdin:
	hw_id, hw_number, label, review = line.split('\t')
	for a in [review.strip()]:
		words = a.split()
		for word in words:
