from fal import FalDbt
import os

cwd = os.getcwd()
faldbt = FalDbt(profiles_dir=cwd, project_dir=cwd)

faldbt.list_sources()
# [['results', 'ticket_data_sentiment_analysis']]

# faldbt.list_models()
# {
#   'zendesk_ticket_metrics': <RunStatus.Success: 'success'>, 
#   'stg_o3values': <RunStatus.Success: 'success'>, 
#   'stg_zendesk_ticket_data': <RunStatus.Success: 'success'>, 
#   'stg_counties': <RunStatus.Success: 'success'>
# }

# ref() means the same thing to everyone in the data team(think: data engineers, data analysts, data scientists)
# no need to fiddle with ad hoc SQL to get the dataframe
sentiments = faldbt.ref('fct_reviews')
sentiments.tail(10)

# let's enrich the dataframe with the sentiment scores
from textblob import TextBlob
from textblob.classifiers import NaiveBayesClassifier

sentiments_sample = sentiments.tail(10)

sentiments_polarity = []
sentiments_subjectivity = []
for index, row in sentiments_sample.iterrows():
    text = row['comments']
    blob = TextBlob(text)
    sentiments_polarity.append(blob.sentiment.polarity)
    sentiments_subjectivity.append(blob.sentiment.subjectivity)


sentiments_sample['polarity'] = sentiments_polarity
sentiments_sample['subjectivity'] = sentiments_subjectivity

print(sentiments_sample)