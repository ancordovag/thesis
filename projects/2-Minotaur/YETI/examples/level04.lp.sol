{
  "Solver": "clingo version 4.4.0",
  "Input": [
    "mino.lp","examples/level04.lp"
  ],
  "Call": [
    {
      "Witnesses": [
        {
          "Value": [
            "at(1,2,0)", "at(1,3,1)", "at(2,3,2)", "at(3,3,3)", "at(4,3,4)", "at(4,2,5)", "at(4,1,6)", "at(4,2,7)", "at(4,3,8)", "at(3,3,9)", "at(2,3,10)", "at(1,3,11)", "at(1,2,12)", "at(1,1,13)"
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
    "Number": 7,
    "More": "no",
    "Optimum": "yes",
    "Optimal": 1,
    "Costs": [
      14
    ]
  },
  "Calls": 1,
  "Time": {
    "Total": 0.077,
    "Solve": 0.033,
    "Model": 0.009,
    "Unsat": 0.003,
    "CPU": 0.070
  }
}
