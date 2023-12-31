{
  "Solver": "clingo version 4.4.0",
  "Input": [
    "mino.lp","examples/level05.lp"
  ],
  "Call": [
    {
      "Witnesses": [
        {
          "Value": [
            "at(1,2,0)", "at(2,2,1)", "at(3,2,2)", "at(3,3,3)", "at(3,4,4)", "at(2,4,5)", "at(1,4,6)", "at(2,4,7)", "at(3,4,8)", "at(2,4,9)", "at(1,4,10)", "at(1,3,11)", "at(1,2,12)", "at(1,1,13)", "at(2,1,14)", "at(3,1,15)"
          ],
          "Costs": [
            16
          ]
        }
      ]
    }
  ],
  "Result": "OPTIMUM FOUND",
  "Models": {
    "Number": 8,
    "More": "no",
    "Optimum": "yes",
    "Optimal": 1,
    "Costs": [
      16
    ]
  },
  "Calls": 1,
  "Time": {
    "Total": 0.139,
    "Solve": 0.091,
    "Model": 0.015,
    "Unsat": 0.001,
    "CPU": 0.130
  }
}
