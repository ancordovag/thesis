{
  "Solver": "clingo version 4.4.0",
  "Input": [
    "mino.lp","examples/level01.lp"
  ],
  "Call": [
    {
      "Witnesses": [
        {
          "Value": [
            "at(2,1,0)", "at(1,1,1)", "at(2,1,2)", "at(3,1,3)", "at(3,2,4)"
          ],
          "Costs": [
            5
          ]
        }
      ]
    }
  ],
  "Result": "OPTIMUM FOUND",
  "Models": {
    "Number": 2,
    "More": "no",
    "Optimum": "yes",
    "Optimal": 1,
    "Costs": [
      5
    ]
  },
  "Calls": 1,
  "Time": {
    "Total": 0.035,
    "Solve": 0.005,
    "Model": 0.003,
    "Unsat": 0.000,
    "CPU": 0.030
  }
}
