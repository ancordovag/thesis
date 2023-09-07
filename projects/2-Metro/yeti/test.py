#!/bin/python
# Author: Marius Schneider
# Date: 15.12.2011

import sys
from subprocess import Popen, PIPE
import os
import tempfile

def callGringo(gringo,enc,inst,runsolver,maxMem):
    groundFile = tempfile.NamedTemporaryFile(prefix="GROUND",dir=".",delete=True)
    cmd = [runsolver, "-w", "/dev/null", "-M", str(maxMem), gringo, inst]
    for e in enc:
        cmd.append(e)
    #print(" ".join(cmd))
    p = Popen(cmd,stdout=groundFile,stderr = PIPE)
    (stdout, stderr ) = p.communicate()
    if (stderr != ""):
        print("Error Gringo: ")
        print(stderr)
        sys.exit()
    #factsFH.close()
    return groundFile

def callClasp(clasp,grFile,runsolver,maxMem,options):
    cmd = [runsolver, "-w", "/dev/null", "-M", str(maxMem), clasp, "--quiet=1,1", grFile.name]
    cmd.extend(options)
    #print(" ".join(cmd))
    p = Popen(cmd,stdout = PIPE, stderr = PIPE)
    (stdo, stderr) = p.communicate()
    if (stderr != ""):
        print("Error Clasp: ")
        print(stderr)   
        sys.exit()
    grFile.close()
    return stdo

def parseAS(stdo,SAT,opt):
    nextAS = False
    stdo = stdo.split("\n")
    preds = ""
    satFound = ""
    for line in stdo:
        if (nextAS == True):
            preds = line.split(" ")
            preds = ". ".join(preds)+"."
        if (line.find("Answer:")!=-1):
            nextAS = True
        else:
            nextAS = False
        if (line.find("SATISFIABLE") != -1 and opt == 0):
            satFound = "SAT"
        if (line.find("UNSATISFIABLE") != -1):
            satFound = "UNSAT"
        if (line.find("OPTIMUM FOUND") != -1 and opt > 0):
            satFound = "SAT"
    #print(satFound)
    if (satFound == "UNSAT" and satFound == SAT):
        return [True,""]
    if (satFound == "SAT" and satFound == SAT):
        return [True,preds]
    return [False,preds]

if __name__ == '__main__':
    inst = sys.argv[1]  # first argument: instance file
    sat = sys.argv[2]   # second argument: SAT or UNSAT
    opt = int(sys.argv[3])   # this argument: 0 or > 0 
    enc = os.path.join("group/",sys.argv[4])   # fourth argument: name of encoding file 

    
    # hardcoded arguments
    gringo = "/home/wv/bin/linux/32/gringo"
    runsolver = "/home/wv/bin/linux/32/runsolver"
    clasp = "/export/home/yeti/clasp-2.0.X"
    #clasp = "clasp-2.0.5-internal-st"
    maxMem = 256
    ourEnc = "encoding.lp"
    
    print(inst)
    
    if (os.path.isfile(enc) == False):
        sys.stderr.write("ERROR: encoding not found!\n")
        sys.exit()
    
    if (os.path.isfile(inst) == False):
        sys.stderr.write("ERROR: instance not found!\n")
        sys.exit()
        
    groundFH = callGringo(gringo,[enc],inst,runsolver,maxMem)
    stdo = callClasp(clasp,groundFH,runsolver,maxMem,[])
    [ok,preds] = parseAS(stdo,sat,opt)
    
    if (ok == False):
        #sys.stderr.write("ERROR: calculation of AS wasn't correct!\n")
        sys.stderr.write("failure\n")
        sys.exit()
    if (ok == True and sat == "UNSAT"):
        print("success")
        sys.exit()
    
    # if (ok == True and sat == "SAT"):
    exts = tempfile.NamedTemporaryFile(prefix="Extended",dir=".",delete=True)
    exts.write(preds+"\n")
    groundFH = callGringo(gringo,[enc,exts.name],inst,runsolver,maxMem)
    if (opt > 0):
        stdo = callClasp(clasp,groundFH,runsolver,maxMem,["--opt-value="+str(opt)])
    else:
        stdo = callClasp(clasp,groundFH,runsolver,maxMem,[])
    #print(stdo)
    [ok, preds ] = parseAS(stdo,"SAT",opt)
    if (ok == True):
        print("success")
    else:
        sys.stderr.write("failure\n")