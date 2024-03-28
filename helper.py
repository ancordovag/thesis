import openai
import os
import time
import pandas as pd
import numpy as np
from numpy.linalg import norm
from yaml import load, Loader
import psycopg2
import clingo

#===========================================================================
# ======================== Dictionaries ====================================
#===========================================================================

canonical_dict = {"sudoku":os.path.join("projects","sudoku","canonical_sudoku.lp"),
                 "seeknumbers":os.path.join("projects","seeknumbers","canonical_seeknumbers2.lp"),
                 "minotaur":os.path.join("projects","minotaur","canonical_minotaur1.lp"),
                 "creek":os.path.join("projects","creek","canonical_creek.lp"),                 
                 "yosenabe":os.path.join("projects","yosenabe","canonical_yosenabe.lp"),
                 "hop":os.path.join("projects","hop","canonical_hop.lp"),
                 "lights":os.path.join("projects","lights","canonical_lights.lp")}

instances_dict ={"sudoku":os.path.join("projects","sudoku","instances","ex01.lp"),
                 "seeknumbers":os.path.join("projects","seeknumbers","instances","ex01.lp"),
                 "minotaur":os.path.join("projects","minotaur","instances","level01.lp"),
                 "creek":os.path.join("projects","creek","instances","ex01.lp"),
                 "yosenabe":os.path.join("projects","yosenabe","instances","instance01.lp"),
                 "hop":os.path.join("projects","hop","instances","level1.lp"),
                 "lights":os.path.join("projects","lights","instances","test01.lp")}

solution_dict ={"sudoku":os.path.join("projects","sudoku","solutions","ex01.json"),
                 "seeknumbers":os.path.join("projects","seeknumbers","solutions","ex01.json"),
                 "minotaur":os.path.join("projects","minotaur","solutions","level01.json"),
                 "creek":os.path.join("projects","creek","solutions","ex01.json"),
                 "yosenabe":os.path.join("projects","yosenabe","solutions","solution01.txt"),
                 "hop":os.path.join("projects","hop","solutions","solution01.txt"),
                 "lights":os.path.join("projects","lights","solutions","solution01.txt")}

#===========================================================================
# ======================== Open AI =========================================
#===========================================================================
def set_api_key():
    with open("config.yml","r") as config:
        data = load(config, Loader=Loader)
        api_key = data["apikey"]
        openai.api_key  = api_key
        
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

'''
Function that connect to OpenAI to write line by line
@param prompt
@return response
'''
def get_completion_rules(prompt, model="gpt-4", previous_messages=[]): #"gpt-3.5-turbo"
    messages = [{"role": "system", "content": "You are a helpful code generator."},
                {"role": "user", "content": '''Given the description of a problem and some initial rules, 
                                             write the missing rules in Answer Set Programming to solve the problem.'''}]
    messages.extend(previous_messages)
    messages.append({"role": "user", "content": prompt})
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0, # this is the degree of randomness of the model's output
    )
    time.sleep(0.2)
    return response.choices[0].message["content"]

'''
Function that connect to OpenAI to write line by line
@param prompt
@return response
'''
def get_completion_line(prompt, model="gpt-4", previous_messages=[]): #"gpt-3.5-turbo"
    messages = [{"role": "system", "content": "You are a helpful code generator."},
                {"role": "user", "content": '''Given the description of a problem, and a commented line, 
                        your task is to translate this commented line in Answer Set Programming. 
                        Just write one or a few predicates or rules. Do not try to solve the whole problem at once.'''}]
    messages.extend(previous_messages)
    messages.append({"role": "user", "content": prompt})
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0, # this is the degree of randomness of the model's output
    )
    time.sleep(0.2)
    return response.choices[0].message["content"]

'''
Function that connect to OpenAI to write line by line from Representation in ASP
@param prompt
@return response
'''
def get_completion_representation(prompt, model="gpt-4", previous_messages=[]): #"gpt-3.5-turbo"
    messages = [{"role": "system", "content": "You are a helpful code generator."},
                {"role": "user", "content": '''Given the description of a problem, predicates in Answer Set Programming, and a commented line, 
                        your task is to translate this last commented line to a rule in Answer Set Programming, using the given predicates or past rules. 
                        Just write one or a few predicates or rules. Do not try to solve the whole problem at once.'''}]
    messages.extend(previous_messages)
    messages.append({"role": "user", "content": prompt})
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0, # this is the degree of randomness of the model's output
    )
    time.sleep(0.2)
    return response.choices[0].message["content"]

'''
Function that improve a comment
@param prompt
@return response
'''
def get_improved_nlp(problem,comment, model="gpt-4"): #"gpt-3.5-turbo"
    messages = [{"role": "system", "content": "You are a helpful code generator."},
                {"role": "user", "content": '''Given the description of a problem and a particular rule written in natural language, intended to solve some aspect of the problem, improve the redaction in a good and clear english.'''}]
    content = f'''Problem: {problem} 
                Rule: {comment}'''
    messages.append({"role": "user", "content": content})
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0, # this is the degree of randomness of the model's output
    )
    time.sleep(0.2)
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

def get_connection():
    conn_string = "dbname=thesis user=postgres password=postgres"
    conn = psycopg2.connect(conn_string)
    return conn

#===========================================================================
# =============================== Clingo ===================================
#===========================================================================
def asp_try_5(asp_file,instance):
    models = []  
    errors = []
    symbols = []
    messages = []

    def custom_logger(code, message):
        messages.append(message)
        
    def on_model(model):
        #print("Model:", model)
        models.append(model)
        with open('output.txt','w') as file:
            print(model, file=file)
        with open('output.txt','r') as file:
            lines = file.readlines()
            symbols_list = lines[0].split()
            #for s in symbols_list:
            symbols.append(symbols_list)
        os.remove("output.txt")

    time_init = time.time() 
    asp_program = []
    # TODO: timeout of Unix systems. Wrapper around. Kill the process. 
    control = clingo.Control(['--warn=none','-t','5','-n','10'], logger=custom_logger) #, '--warn=none', '--opt-mode=optN' --time-limit=5, -t 5
    input_files = [asp_file, instance]
    for file_name in input_files:
        with open(file_name, "r") as file:
            asp_program.extend(file.readlines())
            
    try:
        control.add("base", [], "".join(asp_program))
    except Exception as err:         
        #print(f"Unexpected {err=}, {type(err)=}.")
        errors.append(str(err))
        return models, errors, symbols, messages
    
    try:
        control.ground([("base", [])])
    except Exception as err:         
        #print(f"Unexpected {err=}, {type(err)=}.")
        errors.append(str(err))
        return models, errors, symbols, messages
    
    #control.configuration.solve.models = 0  # Limit the number of models to 1
    try:
        control.solve(on_model=on_model)
    except Exception as err:         
        #print(f"Unexpected {err=}, {type(err)=}.")
        errors.append(str(err))
        return models, errors, symbols, messages
    
    time_final = time.time() 
    delta_time = time_final-time_init
    
    if delta_time > 5 and len(symbols) == 0:
        errors.append("Timeout")

    #print(f"Results: {models}, {errors}, {symbols}. Timedelta {delta_time}")
    return models, errors, symbols, messages