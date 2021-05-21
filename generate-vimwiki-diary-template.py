#!/bin/python3
import datetime
import json
from random import choice
import sys 
import os

sys.stdout.reconfigure(encoding='utf-8')

template = """# {date} @ 

{dailyKanji}


"""

current_date = datetime.date.today()
date = current_date.strftime("%A %d/%m")

with open('C:/Users/Linzi/AppData/Local/nvim/resources/jmdict-eng-common-3.1.0.json', encoding="utf-8") as f:
    data = json.loads(f.read())

winner = choice(data["words"])

if winner["kanji"]:
    dailyKanji = (winner["kanji"][0]["text"] + ' ' + winner["kana"][0]["text"] + ' ' + winner["sense"][0]["gloss"][0]["text"])
else:
    dailyKanji = (winner["kana"][0]["text"] + ' ' + winner["sense"][0]["gloss"][0]["text"])
    
    
def uprint(*objects, sep=' ', end='\n', file=sys.stdout):
    enc = file.encoding
    if enc == 'UTF-8':
        print(*objects, sep=sep, end=end, file=file)
    else:
        f = lambda obj: str(obj).encode(enc, errors='backslashreplace').decode(enc)
        print(*map(f, objects), sep=sep, end=end, file=file)


print(template.format(date=date, dailyKanji=dailyKanji))

