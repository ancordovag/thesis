{
  "Solver": "clingo version 4.4.0",
  "Input": [
    "mino.lp","examples/level02.lp"
  ],
  "Call": [
    {
      "Witnesses": [
        {
          "Value": [
            "at(3,1,0)", "at(3,2,1)", "at(2,2,2)", "at(2,1,3)", "at(1,1,4)", "at(2,1,5)", "at(2,2,6)", "at(3,2,7)", "at(3,3,8)"
          ],
          "Costs": [
            9
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
      9
    ]
  },
  "Calls": 1,
  "Time": {
    "Total": 0.031,
    "Solve": 0.008,
    "Model": 0.002,
    "Unsat": 0.000,
    "CPU": 0.020
  }
}
