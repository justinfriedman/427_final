import os
import re

hw_reviews = ""
semesters = ['FL2016', 'SP2017', 'FL2017', 'SP2018', 'FL2018']
for semester in semesters:
    directory = "hw_reviews_" + semester
    for folder in os.listdir(directory):
        if folder[0] == '.': # not interested in .DS_Store
            continue
        subdirectory = directory + '/' + folder
        for review in os.listdir(subdirectory):
            file_path = subdirectory + '/' + review
            with open(file_path) as file:
                text = file.read()
            words = re.split(r'\W+', text)
            words = [''.join(filter(str.isalpha, word)) for word in words]
            words = [word for word in words if len(word) > 0]
            if len(words) < 50:
                continue
            text = ' '.join(words)
            hw_id = review.split('_')[2][:-4]
            hw_number = review.split('_')[0][2:]
            hw_number = hw_number if hw_number != 'M' else '-1'
            label = folder
            hw_reviews += semester + '\t' + hw_id + '\t' + hw_number + '\t' + label + '\t' + text + '\n'
with open('hw_reviews.txt', 'w') as file:
    file.write(hw_reviews)
