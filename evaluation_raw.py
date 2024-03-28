### Import libraries
import openai
import os
import time
from datetime import datetime
import pandas as pd
import numpy as np7
from numpy.linalg import norm
import psycopg2
import clingo
from clingo.control import Control
import json
from yaml import load, Loader
from helper import *
from stories import *

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

def asp_try_4(asp_file,instance):
    models = []  
    errors = []
    symbols = []

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
    control = clingo.Control(['--warn=none','0','-t', '2']) #,  '--opt-mode=optN'
    input_files = [asp_file, instance]
    for file_name in input_files:
        with open(file_name, "r") as file:
            asp_program.extend(file.readlines())
            
    try:
        control.add("base", [], "".join(asp_program))
    except Exception as err:         
        print(f"Unexpected {err=}, {type(err)=}.")
        errors.append(err)
        return models, errors, symbols
    
    try:
        control.ground([("base", [])])
    except Exception as err:         
        print(f"Unexpected {err=}, {type(err)=}.")
        errors.append(err)
        return models, errors, symbols
    
    #control.configuration.solve.models = 0  # Limit the number of models to 1
    try:
        control.solve(on_model=on_model)
    except Exception as err:         
        print(f"Unexpected {err=}, {type(err)=}.")
        errors.append(err)
        return models, errors, symbols
    
    time_final = time.time() 
    delta_time = time_final-time_init
    
    if delta_time > 2 and len(symbols) == 0:
        errors.append("Timeout")

    #print(f"Results: {models}, {errors}, {symbols}. Timedelta {delta_time}")
    return models, errors, symbols

def get_symbols_from_solution(solution_path):        
    with open(solution_path,'r') as file:
        if ".json" in solution_path:
            data = json.load(file)
            results = data["Call"][0]["Witnesses"] #[0]["Value"]
            #print(result)
        else:
            lines = file.readlines()
            splitted = lines[0].split()
            results = [{"Value":splitted}]
    return results

def jaccard_similarity(lista1, lista2):
    set1 = set(lista1)
    set2 = set(lista2)
    intersection = len(set1.intersection(set2))
    union = len(set1.union(set2))
    return 

def get_metrics(symbols, solutions):
    symbols_set = set(symbols)
    matchs = 0
    final_tp = set()
    final_fp = ()
    final_fn = ()
    for solution in solutions:
        solution_set = set(solution["Value"])
        union = len(symbols_set.union(solution_set))
        tp = solution_set.intersection(symbols_set)
        matchs_temp = len(tp)
        solution_len = len(solution_set)
        if matchs_temp >= matchs:            
            matchs = matchs_temp
            final_tp = tp
            final_fp = symbols_set.difference(solution_set)
            final_fn = solution_set.difference(symbols_set)
            solution_len = len(solution_set)
    accuracy = matchs / solution_len if solution_len != 0 else 0 
    precision = matchs / (len(final_tp) + len(final_fp)) if (len(final_tp) + len(final_fp)) != 0 else 0  
    recall = matchs / (len(final_tp) + len(final_fn)) if (len(final_tp) + len(final_fn)) != 0 else 0 
    f1_score = 2 * ((precision * recall) / (precision + recall)) if (precision + recall) != 0 else 0
    jaccard = matchs / union if union != 0 else 0
    #print(f"Accuracy: {accuracy:.4f}. Precision: {precision:.4f}. Recall: {recall:.4f}. F1: {f1_score:.4f}")
    return matchs, round(accuracy,2), round(precision,2), round(recall,2), round(f1_score,2), round(jaccard,2)

def get_best_metrics(all_symbols,solutions):
    matchs = acc = prec = rec = f1 = jac = 0
    for symbols in all_symbols:
        matchs_t, acc_t, prec_t, rec_t, f1_t, jac_t = get_metrics(symbols, solutions)
        if matchs_t > matchs:
            matchs = matchs_t
            acc = acc_t
            prec = prec_t
            rec = rec_t
            f1 = f1_t
            jac = jac_t
    return matchs, acc, prec, rec, f1, jac

def repetition_counter(file):
    with open(file,'r') as f:
        lines = f.readlines()
        lines = [x for x in lines if x!='\n']
        #print(f"Lines {lines}")
        list_unique_lines = list(set(lines))
        unique_lines = len(list_unique_lines)
        #print(f"List Unique Lines: {list_unique_lines}")
        return len(lines) - unique_lines

def evaluate(file, instance, solution_path, canonical_file):
    models, errors, symbols = asp_try_4(file,instance)
    n_models = len(models)
    canonical_lines = lines_counter(canonical_file)
    encoding_lines = lines_counter(file)
    repeated_lines = repetition_counter(file)
    #print("Length of Canonical:" + str(canonical_lines) + ". Length Encoding: "+ str(encoding_lines))
    errors = 0
    diff_lines = abs(canonical_lines - encoding_lines)
    solutions = get_symbols_from_solution(solution_path)
    #print("Symbols: " + str(symbols))
    #print("Solution: " + str(solution))
    matchs, accuracy, precision, recall, f1_score, jaccard = get_best_metrics(symbols, solutions) 
    at_least_a_model = 1 if n_models > 0 else 0
    kpi = 25 + at_least_a_model*25 + 10*(accuracy + precision + recall + f1_score + jaccard) - diff_lines - repeated_lines * 2 - errors * 5
    result_dict = {"kpi":kpi, "diff_lines":diff_lines, "repeated":repeated_lines, "errors":errors, "n_models":n_models, "symbols":symbols, "matchs":matchs,
                    "accuracy":accuracy, "precision":precision, "recall":recall, "f1_score":f1_score, "jaccard":jaccard}
    #print(f"Precision: {precision}")
    print_out_dict = {x: result_dict[x] for x in result_dict if x not in ["symbols"]}
    print(print_out_dict)
    return result_dict

conn_string = "dbname=thesis user=postgres password=postgres"
conn = psycopg2.connect(conn_string)
print("Connection established")

def save_in_database(conn, file, kpi, diff_lines, repeated, errors, n_models, symbols, matchs, accuracy, precision, recall, f1_score, jaccard):
    cursor = conn.cursor()
    symbols = str(symbols).replace("'","")
    command = '''INSERT INTO results (file, kpi, diff_lines, repeated, errors, n_models, symbols, matchs, accuracy, precision, recall, f1_score, jaccard) 
                VALUES ('%(file)s', '%(kpi)s', '%(diff_lines)s', '%(repeated)s', '%(errors)s', '%(n_models)s', '%(symbols)s', '%(matchs)s', '%(accuracy)s', '%(precision)s', '%(recall)s', '%(f1_score)s',
                 '%(jaccard)s');''' % {"file":file, "kpi": kpi, "diff_lines": diff_lines, "repeated":repeated, "errors": errors, "n_models": n_models, "symbols": symbols, "matchs":matchs, "accuracy":accuracy, "precision":precision, "recall":recall, "f1_score":f1_score, "jaccard":jaccard}
    try:
        cursor.execute(command)
        conn.commit()
        cursor.close()
        print(f"Insertion of results of file {file} successful")
    except Exception as err:
        print(command)
        print(f"Unexpected {err=}, {type(err)=} Result not inserted.")
        conn.commit()
        cursor.close()
        pass

def look_file(conn, file):
    cursor = conn.cursor()
    command = "SELECT * FROM results WHERE file = '"+ file + "'"
    results = []
    try:
        cursor.execute(command)
        results = cursor.fetchall()
        conn.commit()
        cursor.close()
    except Exception as err:
        print(command)
        print(f"Unexpected {err=}, {type(err)=} Bad search.")
        conn.commit()
        cursor.close()
        pass
    return results

def all_files_db(conn):
    cursor = conn.cursor()
    command = "SELECT file FROM experiments"
    results = []
    try:
        cursor.execute(command)
        results = cursor.fetchall()
        conn.commit()
        cursor.close()
    except Exception as err:
        print(command)
        print(f"Unexpected {err=}, {type(err)=} Bad search.")
        conn.commit()
        cursor.close()
        pass
    return results

selected_files = [x[0] for x in all_files_db(conn)]
selected_files = selected_files[0:100]

data = []
counter = 0
for file in selected_files:
    counter += 1
    story = file.split("_")[0]
    results = look_file(conn,file)
    print("===Counter: "+ str(counter) +" ==== Evaluation of " + story + ". File: "+ file +" ===============")
    story = file.split("_")[0]
    canonical_file = canonical_dict[story]
    instance_file = instances_dict[story]
    solution_file = solution_dict[story]
    path_of_file = os.path.join("generated_solutions",file)
    #try:
    results = evaluate(path_of_file,instance_file,solution_file,canonical_file)
    continue
    kpi = results["kpi"]
    diff_lines = results["diff_lines"]
    repeated = results["repeated"]
    errors = results["errors"]
    n_models = results["n_models"]
    symbols = results["symbols"]
    matchs = results["matchs"]
    accuracy = results["accuracy"]
    precision = results["precision"]
    recall = results["recall"]
    f1_score = results["f1_score"]
    jaccard = results["jaccard"]
    #save_in_database(conn, file, kpi, diff_lines, repeated, errors, n_models, symbols, matchs, accuracy, precision, recall, f1_score, jaccard)
    #except Exception as err:
    #    print(f"Unexpected {err=}, {type(err)=} Bad Evaluation.")
    #    #print(f"Problem with file {file}")
    #    pass
    data.append(results)