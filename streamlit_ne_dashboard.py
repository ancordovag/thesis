import pandas as pd
import streamlit as st
import matplotlib.pyplot as plt
import psycopg2
from stories import *

st.set_page_config(layout="wide")
st.title('Results of New Experiments')

conn_string = "dbname=thesis user=postgres password=postgres"
conn = psycopg2.connect(conn_string)
print("Connection established")

cursor = conn.cursor()
command = "SELECT * FROM ne_panel"
cursor.execute(command)
results = cursor.fetchall()
conn.commit()
cursor.close()

sql = "SELECT column_name FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'ne_panel'"
cursor = conn.cursor()
cursor.execute(sql)
columns = cursor.fetchall()
conn.commit()
cursor.close()

columns = [x[0] for x in columns]

df = pd.DataFrame(results, columns = columns)

df_story = df[['story','kpi','diff_lines','n_models','n_errors','jaccard']]
df_story_1 = df[['story_1','kpi','diff_lines','n_models','n_errors','jaccard']]
df_story_2 = df[['story_2','kpi','diff_lines','n_models','n_errors','jaccard']]
df_version = df[['version','kpi','diff_lines','n_models','n_errors','jaccard']]
df_story_version = df[['story','version','kpi','diff_lines','n_models','n_errors','jaccard']]

df_story_mean = df_story.groupby('story').mean()
df_story_1_mean = df_story_1.groupby('story_1').mean()
df_story_2_mean = df_story_2.groupby('story_2').mean()
df_version_mean = df_version.groupby('version').mean()
df_story_version_mean = df_story_version.groupby(['story','version']).mean()

def plot_measure(df,measure='jaccard'):
    fig, ax1 = plt.subplots(1,figsize=(8,3))
    ax1.set_title(measure.capitalize())
    ax1.bar(df.index,df[measure], label=measure)
    plt.legend()
    return fig

col1, col2 = st.columns(2)
measures = ['kpi','jaccard','n_errors','n_models']
figures = []
for m in measures:
    figures.append(plot_measure(df_story_mean,m))
counter = 0
for f in figures:
    counter += 1
    if counter % 2:
        with col1:
            with st.container():
                st.pyplot(f)
    else:
        with col2:
            with st.container():
                st.pyplot(f)

st.write("By version")

measures = ['kpi','jaccard','n_errors','n_models']
figures = []
for m in measures:
    figures.append(plot_measure(df_version_mean,m))
counter = 0
for f in figures:
    counter += 1
    if counter % 2:
        with col1:
            with st.container():
                st.pyplot(f)
    else:
        with col2:
            with st.container():
                st.pyplot(f)