#!/bin/python
# -*- coding: utf-8 -*-
# Author: Marius Schneider
# Date: 15.12.2011
# Updated 07.12.2012 by Arne König

# Usage: test.py <encoding> <instance> <result> [<optimum>]
# Arguments:
# encoding - name of the encoding to test
# instance - name of the instance to test
# result - expected result (SAT, UNSAT, or OPT)
# optimum - expected optimum as atom (only for OPT)

import sys
from subprocess import Popen, PIPE
import os
import tempfile
import logging
import json

# Enable Debugging:
#logging.basicConfig(level=logging.DEBUG, format='DEBUG: %(message)s')

# hardcoded arguments
GRINGO = "/home/wv/bin/linux/64/gringo"
RUNSOLVER = "/home/wv/bin/linux/64/runsolver"
CLASP = "/home/wv/bin/linux/64/clasp"
REF_ENC = "checker.lp"
MAX_MEM = 512
CUTOFF = 600
RUNSOLVER_OPTIONS = [RUNSOLVER, "-w", "/dev/null", "-M", str(MAX_MEM), "-W", str(CUTOFF)]


def call_gringo(ground_file, input_names):
    cmd = RUNSOLVER_OPTIONS + [GRINGO] + input_names
    logging.debug(" ".join(cmd))
    _stdout, stderr = Popen(cmd, stdout=ground_file, stderr=PIPE).communicate()
    if stderr:
        raise RuntimeError("Gringo: %s" % stderr)


def call_clasp(ground_file):
    cmd = RUNSOLVER_OPTIONS + [CLASP, "0", "--outf=2", ground_file.name]
    logging.debug(" ".join(cmd))
    stdout, stderr = Popen(cmd, stdout=PIPE, stderr=PIPE).communicate()
    if stderr:
        raise RuntimeError("Clasp: %s" % stderr)
    return stdout


def check_result(stdout, expected):
    output = json.loads(stdout)
    result = output['Result']
    logging.debug(result)
    solutions = []
    if not result.startswith('UNSAT'):
        solutions = [w['Value'] for w in output['Witnesses']]
    return result.startswith(expected), solutions


def main():
    # check input
    if len(sys.argv) < 4:
        raise RuntimeError("not enough arguments (%d instead of 3)" % (len(sys.argv) - 1))
    enc, inst, expected = sys.argv[1:4]
    enc = os.path.join("group", enc)
    for f in [enc, inst]:
        if not os.path.isfile(f):
            raise IOError("file %s not found!" % f)

    opt = None
    if expected == 'OPT':
        if len(sys.argv) < 5:
            raise RuntimeError("optimum missing")
        opt = sys.argv[4]

    logging.debug("instance: %s" % inst)
    logging.debug("encoding: %s" % enc)

    # check if encoding result is as expected
    try:
        with tempfile.NamedTemporaryFile(prefix="Ground", dir=".") as f:
            call_gringo(f, [enc, inst])
            stdout = call_clasp(f)
    except RuntimeError as e:
        logging.debug(str(e))
        return False
    ok, solutions = check_result(stdout, expected)
    if not ok:
        return False

    # succeed if expected UNSAT
    if expected == 'UNSAT':
        return True

    # check solutions if expected SAT
    if expected == 'SAT':
        with tempfile.NamedTemporaryFile(prefix="Ground", dir=".") as f:
            call_gringo(f, [REF_ENC, inst])
            stdout = call_clasp(f)
        ok, ref_solutions = check_result(stdout, expected)
        for s in solutions:
            s.sort()
        for s in ref_solutions:
            s.sort()
        solutions.sort()
        ref_solutions.sort()
        logging.debug(solutions)
        logging.debug(ref_solutions)
        return solutions == ref_solutions

    # check optimal solution
    if expected == 'OPT':
        with tempfile.NamedTemporaryFile(prefix="Ground", dir=".") as f:
            with tempfile.NamedTemporaryFile(prefix="Extended", dir=".") as exts:
                exts.write("%s.\n" % ". ".join(solutions[-1]))
                exts.flush()
                call_gringo(f, [REF_ENC, exts.name, inst])
            stdout = call_clasp(f)
        ok, ref_solutions = check_result(stdout, 'SAT')
        if not ok:
            return False
        found_opt = True
        opt_name = opt.split("(", 1)[0]
        for atom in ref_solutions[0]:
            if atom.startswith(opt_name):
                if atom == opt:
                    found_opt
                else:
                    return False
        return found_opt


if __name__ == '__main__':
    try:
        message = "success" if main() else "failure"
        sys.stdout.write("%s\n" % message)
    except Exception as e:
        sys.stderr.write("ERROR: %s\n" % str(e))
        exit(1)
