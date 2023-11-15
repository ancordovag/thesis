import openai
import time
import pandas as pd
import numpy as np
from numpy.linalg import norm
  
#===========================================================================
# ======================== Open AI =========================================
#===========================================================================
def get_embedding(text, model="text-embedding-ada-002"):
   text = text.replace("\n", " ")
   return openai.Embedding.create(input = [text], model=model)['data'][0]['embedding']

def get_best_context(df, projects, story, N = 2):
    column_cosine = 'cos_' + story
    df_sorted = df.sort_values(by=column_cosine, ascending=False)
    second_best = df_sorted.iloc[1]  
    third_best = df_sorted.iloc[2] 
    best_stories = [second_best["stories"],third_best["stories"]]
    result = []
    for project in projects:
        if project["story"] in best_stories:
            result.append(project)
    return result

'''
Function that connect to OpenAI
@param prompt
@return response
'''
def get_completion(prompt, model="gpt-4"): #"gpt-3.5-turbo"
    messages = [{"role": "user", "content": prompt}]
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0, # this is the degree of randomness of the model's output
    )
    time.sleep(0.3)
    return response.choices[0].message["content"]

#===========================================================================
# =============================== Others ===================================
#===========================================================================
def get_similarity_dataframe(projects):   
    stories=[]
    problems = []
    for project in projects:
        stories.append(project["story"])
        problems.append(project["problem"])
    df = pd.DataFrame({"stories":stories,"problems":problems})
    df["embeddings"] = df.problems.apply(lambda x : get_embedding(x))
    for project in projects:
        query_embedding = df[df['stories'] == project["story"]]['embeddings']
        np_query = np.array(query_embedding)[0]
        cosine_name = 'cos_' + project['story']
        df[cosine_name] = df.embeddings.apply(lambda x : round(np.dot(np_query,np.array(x))/(norm(np_query)*norm(np.array(x))),3))
    return df
    
def lines_counter(file):
    with open(file,'r') as readfile:
        lines = readfile.readlines()
    return len(lines)