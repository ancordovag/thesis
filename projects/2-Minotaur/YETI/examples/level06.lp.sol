{
  "Solver": "clingo version 4.4.0",
  "Input": [
    "mino.lp","examples/level06.lp"
  ],
  "Call": [
    {
      "Witnesses": [
        {
          "Value": [
            "at(1,3,0)", "at(1,2,1)", "at(1,1,2)", "at(1,2,3)", "at(2,2,4)", "at(2,3,5)", "at(3,3,6)"
          ],
          "Costs": [
            7
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
      7
    ]
  },
  "Calls": 1,
  "Time": {
    "Total": 0.098,
    "Solve": 0.018,
    "Model": 0.010,
    "Unsat": 0.001,
    "CPU": 0.080
  }
}
