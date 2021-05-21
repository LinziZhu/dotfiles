import datetime
import json
from random import choice
import sys 
import os

sys.stdout.reconfigure(encoding='utf-8')
jmdictPath = 'C:/Users/Linzi/AppData/Local/nvim/resources/jmdict-eng-common-3.1.0.json'

#I use markdown for vim-wiki formatting. Adjust this if you use the vim-wiki native formatting.
template = """# {date} @
 
{formattedEntry}
"""

currentDate = datetime.date.today()
date = currentDate.strftime("%A").ljust(10) + currentDate.strftime("%d/%m")

#Read in the jmdict file
with open(os.path.expanduser(jmdictPath), encoding="utf-8") as f:
    jmdict = json.loads(f.read())

#choice randomly selects an object from the words listed in jmdict
entryOfTheDay = choice(jmdict["words"])

#check if anything exists in the kanji's entry field. Kana only words will leave this empty.
if entryOfTheDay["kanji"]:
    dailyKanji = entryOfTheDay["kanji"][0]["text"]
else:
    dailyKanji = 0

dailyKana = entryOfTheDay["kana"][0]["text"]

dailyGloss = ""
for i in entryOfTheDay["sense"][0]["gloss"][:-1]:
    dailyGloss = dailyGloss + i["text"] + "; "
dailyGloss = dailyGloss + entryOfTheDay["sense"][0]["gloss"][-1]["text"]

if dailyKanji:
    formattedEntry = "『 {dailyKanji} 』 ⸨ {dailyKana} ⸩ - {dailyGloss}".format(dailyKanji=dailyKanji, dailyKana=dailyKana, dailyGloss=dailyGloss)
else:
    formattedEntry = "⸨ {dailyKana} ⸩ - {dailyGloss}".format(dailyKana = dailyKana, dailyGloss=dailyGloss)

print(template.format(date=date, formattedEntry=formattedEntry))
