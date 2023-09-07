{
  "Solver": "clingo version 4.4.0",
  "Input": [
    "mino.lp","examples/level03.lp"
  ],
  "Call": [
    {
      "Witnesses": [
        {
          "Value": [
            "at(2,3,0)", "at(2,2,1)", "at(2,1,2)", "at(1,1,3)", "at(1,1,4)", "at(2,1,5)", "at(3,1,6)", "at(3,2,7)", "at(3,3,8)"
          ],
          "Costs": [
            9
          ]
        },
        {
          "Value": [
            "at(2,3,0)", "at(2,2,1)", "at(2,1,2)", "at(1,1,3)", "at(1,1,4)", "at(2,1,5)", "at(2,2,6)", "at(3,2,7)", "at(3,3,8)"
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
    "Number": 7,
    "More": "no",
    "Optimum": "yes",
    "Optimal": 2,
    "Costs": [
      9
    ]
  },
  "Calls": 1,
  "Time": {
    "Total": 0.108,
    "Solve": 0.057,
    "Model": 0.007,
    "Unsat": 0.019,
    "CPU": 0.100
  }
}
