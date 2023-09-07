{
  "Solver": "clingo version 4.4.0",
  "Input": [
    "mino.lp","examples/level08.lp"
  ],
  "Call": [
    {
      "Witnesses": [
        {
          "Value": [
            "at(3,3,0)", "at(4,3,1)", "at(5,3,2)", "at(6,3,3)", "at(7,3,4)", "at(7,4,5)", "at(7,3,6)", "at(7,2,7)", "at(7,1,8)", "at(6,1,9)", "at(5,1,10)", "at(4,1,11)", "at(3,1,12)", "at(2,1,13)"
          ],
          "Costs": [
            14
          ]
        }
      ]
    }
  ],
  "Result": "OPTIMUM FOUND",
  "Models": {
    "Number": 10,
    "More": "no",
    "Optimum": "yes",
    "Optimal": 1,
    "Costs": [
      14
    ]
  },
  "Calls": 1,
  "Time": {
    "Total": 2.077,
    "Solve": 1.887,
    "Model": 0.334,
    "Unsat": 0.021,
    "CPU": 2.050
  }
}
