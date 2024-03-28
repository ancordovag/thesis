import pandas as pd
import streamlit as st
import matplotlib.pyplot as plt
import psycopg2
from stories import *


st.set_page_config(layout="wide")
st.title('Panel Resumed')

conn_string = "dbname=thesis user=postgres password=postgres"
conn = psycopg2.connect(conn_string)
print("Connection established")

projects = get_useful_projects()
stories = [None]
for p in projects:
    stories.append(p['story'])
versions = [None,2, 3, 4, 9, 10]
    
def load_panel(conn, story=None, version=None):
    cursor = conn.cursor()
    command = "SELECT file, encoding, story, story_1, story_2, kpi, jaccard FROM panel"
    if story and not version:
        command += " WHERE story = '{}'".format(story)
    if not story and version:
        command += " WHERE version = {}".format(version)
    if story and version:
        command += " WHERE story = '{}' AND version = {}".format(story, version)
    st.write(command)
    #result_list = []
    result = None
    try:
        cursor.execute(command)
        result = cursor.fetchall()
        conn.commit()
        cursor.close()
    except Exception as err:
        conn.commit()
        cursor.close()
        pass
    
    columns = ['file', 'encoding', 'story', 'story_1', 'story_2', 'kpi', 'jaccard']
    
    df = pd.DataFrame(result, columns = columns)
    #st.write(result_list)
    return df

def load_old_panel(conn, story=None, version=None):
    cursor = conn.cursor()
    command = "SELECT file, encoding, story, story_1, story_2, kpi, jaccard FROM b20140104_panel"
    if story and not version:
        command += " WHERE story = '{}'".format(story)
    if not story and version:
        command += " WHERE version = {}".format(version)
    if story and version:
        command += " WHERE story = '{}' AND version = {}".format(story, version)
    st.write(command)
    #result_list = []
    result = None
    try:
        cursor.execute(command)
        result = cursor.fetchall()
        conn.commit()
        cursor.close()
    except Exception as err:
        #st.write(command)
        #st.write(f"Unexpected {err=}, {type(err)=} Bad Query.")
        conn.commit()
        cursor.close()
        pass

col1, col2 = st.columns(2)

col1.header("Select Story and Version")
col2.header("Select Story and Version")
with col1:
    form1 = st.form(key='panel_form')
    story1 = form1.selectbox('Story',stories,key=1)
    version1 = form1.selectbox('Version',versions,key=2)
    submit_button = form1.form_submit_button(label='Submit')
    
with col2:
    form2 = st.form(key='old_panel_form')
    story2 = form2.selectbox('Story',stories,key=3)
    version2 = form2.selectbox('Version',versions,key=4)
    submit_button2 = form2.form_submit_button(label='Submit')
#story = col1.selectbox('Story', stories)
#version = col1.selectbox('Version', versions)



# Create a text element and let the reader know the data is loading.
data_load_state = st.text('Loading data...')
# Load 10,000 rows of data into the dataframe.
with col1:
    data1 = load_panel(conn,story1,version1)
    st.write(data1)
with col2:
    data2 = load_panel(conn,story2,version2)
    st.write(data2)
data_load_state.text('Loading data...done!')
