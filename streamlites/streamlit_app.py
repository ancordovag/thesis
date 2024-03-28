import pandas as pd
import streamlit as st
import psycopg2
from stories import *

st.set_page_config(layout="wide")
st.title('Results of Experiments')

conn_string = "dbname=thesis user=postgres password=postgres"
conn = psycopg2.connect(conn_string)
print("Connection established")

projects = get_useful_projects()
stories = []
for p in projects:
    stories.append(p['story'])

versions = [x+1 for x in range(9)]
versions.append(91)
    
def load_one_from_db(conn, story, version):
    cursor = conn.cursor()
    command = "SELECT * FROM experiments e JOIN results r ON e.file = r.file WHERE story = '{}' AND version = {}".format(story, version)
    #st.write(command)
    #result_list = []
    result = None
    try:
        cursor.execute(command)
        result = cursor.fetchall()
        #for r in results:
        #    dicc_result = {"id":r[0], "prompt1":r[1], "prompt2":r[2], "encoding":r[3], "story":r[4], "story_1":r[5], "story_2":r[6], "version":r[7], "file":r[8], "created_at":r[9], "llm":r[10], "id_result":r[11], "file2":r[12], "kpi":r[13], "diff_lines":r[14], "errors":r[15], "n_models":r[16], "symbols":r[17], "matchs":r[18], "match_ratio":r[19], "created_at_result":r[20]}
        #    results.append(dicc_result)
        conn.commit()
        cursor.close()
    except Exception as err:
        #st.write(command)
        #st.write(f"Unexpected {err=}, {type(err)=} Bad Query.")
        conn.commit()
        cursor.close()
        pass
    #st.write(result_list)
    return result

def load_prompt_and_encoding(conn, fields, story, version):
    cursor = conn.cursor()
    command = "SELECT {} FROM experiments WHERE story = '{}' AND version = {}".format(fields, story, version)
    #st.write(command)
    #result_list = []
    result = None
    try:
        st.write(command)
        cursor.execute(command)
        result = cursor.fetchall()
        #for r in results:
        #    dicc_result = {"id":r[0], "prompt1":r[1], "prompt2":r[2], "encoding":r[3], "story":r[4], "story_1":r[5], "story_2":r[6], "version":r[7], "file":r[8], "created_at":r[9], "llm":r[10], "id_result":r[11], "file2":r[12], "kpi":r[13], "diff_lines":r[14], "errors":r[15], "n_models":r[16], "symbols":r[17], "matchs":r[18], "match_ratio":r[19], "created_at_result":r[20]}
        #    results.append(dicc_result)
        conn.commit()
        cursor.close()
    except Exception as err:
        #st.write(command)
        #st.write(f"Unexpected {err=}, {type(err)=} Bad Query.")
        conn.commit()
        cursor.close()
        pass
    #st.write(result_list)
    return result

def load_from_db(conn):
    cursor = conn.cursor()
    command = "SELECT * FROM experiments e JOIN results r ON e.file = r.file"
    results = None
    try:
        cursor.execute(command)
        results = cursor.fetchall()
        conn.commit()
        cursor.close()
    except Exception as err:
        print(command)
        print(f"Unexpected {err=}, {type(err)=} Bad Query.")
        conn.commit()
        cursor.close()
        pass
    return results

col1, col2 = st.columns(2)

col1.header("Select File")
story = col1.selectbox('Story', stories)
version = col1.selectbox('Version', versions)

col2.header("Select Fields")
prompt = col2.checkbox('Prompt')
encoding = col2.checkbox('Encoding')
created_at = col2.checkbox('Date')

fields= "file"
if prompt:
    fields += ", prompt1"
if encoding:
    fields += ", encoding"
if created_at:
    fields += ", created_at"
fields += " "


st.write('Results of Search of Story ', story)

# Create a text element and let the reader know the data is loading.
data_load_state = st.text('Loading data...')
# Load 10,000 rows of data into the dataframe.
data = load_prompt_and_encoding(conn,fields,story,version) # data = load_from_db(conn)
# Notify the reader that the data was successfully loaded.
data_load_state.text('Loading data...done!')

st.subheader('Raw data')
st.write(data)


