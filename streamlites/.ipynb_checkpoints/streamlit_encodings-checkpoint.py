import pandas as pd
import streamlit as st
import matplotlib.pyplot as plt
import psycopg2
from stories import *

st.set_page_config(layout="wide")
st.title('Results of Experiments')

conn_string = "dbname=thesis user=postgres password=postgres"
conn = psycopg2.connect(conn_string)
print("Connection established")

cursor = conn.cursor()
command = "SELECT * FROM panel"
cursor.execute(command)
results = cursor.fetchall()
conn.commit()
cursor.close()

sql = "SELECT column_name FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'panel'"
cursor = conn.cursor()
cursor.execute(sql)
columns = cursor.fetchall()
conn.commit()
cursor.close()

columns = [x[0] for x in columns]
df = pd.DataFrame(results, columns = columns)
df_story = df[['story','encoding','kpi','diff_lines','n_models','n_errors','jaccard']]

st.text("Name of file...")
