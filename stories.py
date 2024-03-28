from domains.creek import creek
from domains.furniture import furniture
from domains.hop import hop
from domains.jobs import jobs
from domains.lights import lights
from domains.minotaur import minotaur
from domains.nqueens import nqueens
from domains.seeknumbers import seeknumbers
from domains.sudoku import sudoku
from domains.yosenabe import yosenabe

def get_all_projects():
    return [creek, furniture, hop, jobs, lights, minotaur, nqueens, seeknumbers, sudoku, yosenabe]

def get_useful_projects():
    return [creek, minotaur, seeknumbers, sudoku, yosenabe, hop, lights]

def get_short_projects():
    return [creek, minotaur, seeknumbers, sudoku, yosenabe, hop, lights]