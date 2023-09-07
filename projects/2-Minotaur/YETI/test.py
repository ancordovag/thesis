#!/bin/python
# -*- coding: utf-8 -*-
# Author: Marius Schneider
# Date: 15.12.2011
# Updated 08.11.2011 by Arne König
# Updated 27.11.2011 by Javier Romero

# Usage: test.py <encoding> <instance> <solution>
# Arguments:
# encoding - name of the encoding to test
# instance - name of the instance to test
# solution - solution of <instance> with correct encoding printed using option --outf=2

import sys
from subprocess import Popen, PIPE
import os
import tempfile
import logging
import json

# Enable Debugging:
#logging.basicConfig(level=logging.DEBUG, format='DEBUG: %(message)s')

# hardcoded arguments
GRINGO = "/home/wv/bin/linux/64/gringo-4"
RUNSOLVER = "/home/wv/bin/linux/64/runsolver"
CLASP = "/home/wv/bin/linux/64/clasp3"
REF_ENC = "checker.lp"
MAX_MEM = 256
CUTOFF = 600
RUNSOLVER_OPTIONS = [RUNSOLVER, "-w", "/dev/null", "-M", str(MAX_MEM), "-W", str(CUTOFF)]


def call_gringo(ground_file, input_names):
    cmd = RUNSOLVER_OPTIONS + [GRINGO] + input_names
    logging.debug(" ".join(cmd))
    _stdout, stderr = Popen(cmd, stdout=ground_file, stderr=PIPE).communicate()
    if stderr:
        raise RuntimeError("Gringo: %s" % stderr)

def call_clasp(ground_file):
    cmd = RUNSOLVER_OPTIONS + [CLASP, "0", "--outf=2", "--quiet=1", "--opt-mode=optN", ground_file.name]
    logging.debug(" ".join(cmd))
    stdout, stderr = Popen(cmd, stdout=PIPE, stderr=PIPE).communicate()
    if stderr:
        raise RuntimeError("Clasp: %s" % stderr)
    return stdout

def parse_solution(solution):
    output = json.loads(solution)
    result = output['Result']
    solutions = []
    if not result.startswith('UNSAT'):
        solutions = [w['Value'] for w in output['Call'][0]['Witnesses']]
    return solutions

def check_result(stdout,mysolution):
    logging.debug("parsing result...")
    logging.debug(stdout)
    solutions   = parse_solution(stdout)
    logging.debug("parsing solution...")
    logging.debug(mysolution)
    mysolutions = parse_solution(mysolution)
    logging.debug("checking...")
    if (len(solutions) != len(mysolutions)): return False
    for s in solutions:   s.sort()
    for s in mysolutions: s.sort()
    solutions.sort()
    mysolutions.sort()
    return solutions == mysolutions

def main():

    if len(sys.argv) < 4:
        raise RuntimeError("not enough arguments (%d instead of 3)" % (len(sys.argv) - 1))
    enc, inst, sol = sys.argv[1:4]
    enc = os.path.join("group", enc)
    for f in [enc, inst, sol]:
        if not os.path.isfile(f):
            raise IOError("file %s not found!" % f)

    logging.debug("encoding: " + enc)
    logging.debug("instance: " + inst)
    logging.debug("solution: " + sol)

    try:
        with tempfile.NamedTemporaryFile(prefix="Ground", dir=".") as f:
            logging.debug("grounding...")
            call_gringo(f, [enc, inst])
            logging.debug("solving...")
            stdout = call_clasp(f)
    except RuntimeError as e: return False
    logging.debug("checking...")
    return check_result(stdout,open(sol,"r").read())

if __name__ == '__main__':
    try:
        message = "success" if main() else "failure"
        sys.stdout.write("%s\n" % message)
    except Exception as e:
        sys.stderr.write("ERROR: %s\n" % str(e))
        exit(1)
