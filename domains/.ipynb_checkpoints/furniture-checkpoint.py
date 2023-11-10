furniture = {"story" : "furniture",
            "problem" : """ 
            "Against the Grain" offers hand-made wooden furniture at reasonable prices. Each item is made by an in-house employee. Using only the clues that follow, match each item to the employee who
            crafted it, and determine its price and the type of wood used to make it. Remember, as with all grid-based logic puzzles, no option in any category will ever be used more than once.
            1. Bonita’s piece costs $325. 
            2. The item made of poplar costs more than Yvette’s piece.
            3. Tabitha’s item costs 50 dollars less than the piece made of sandalwood.
            4. The $275 item is either the piece made of ash or Yvette’s item.
            """,
              "constants" : """ employee: "Bonita"; "Yvette"; "Tabitha".
                    price: 225; 275; 325.
                    wood_type: "ash"; "poplar"; "sandalwood".    
                """,
             "predicates" : """
                    % The categories in Constants include employee, price, and wood_type. We use different variables E, P, and W to represent employee, price, and wood_type.
                    % We match an employee E with price P and wood type W, where E belongs to employee, P belongs to price, and W belongs to wood_type.
                    match(E, P, W)
                    """,
             "rules" : """
                       % Define the constants in each category.
                       employee("Bonita"; "Yvette"; "Tabitha").
                       price(225; 275; 325).
                       wood_type("ash"; "poplar"; "sandalwood").
                       % For each employee E, it matches with exactly 1 price P and 1 wood type W.
                       {match(E, P, W): price(P), wood_type(W)}=1 :- employee(E).
                       """,
             "constraints" : """
                        % No option in any category will ever be used more than once.
                        {E1=E2; P1=P2; W1=W2}=0 :- match(E1,P1,W1), match(E2,P2,W2), (E1,P1,W1)!=(E2,P2,W2).
                        % 1. Bonita’s piece costs $325. 
                        P=325 :- match(E,P,W), E="Bonita".
                        % 2. The item made of poplar costs more than Yvette’s piece.
                        P1>P2 :- match(E1,P1,W1), match(E2,P2,W2), W1="poplar", E2="Yvette".
                        % 3. Tabitha’s item costs 50 dollars less than the piece made of sandalwood.
                        P1=P2-50 :- match(E1,P1,W1), match(E2,P2,W2), E1="Tabitha", W2="sandalwood".
                        % 4. The $275 item is either the piece made of ash or Yvette’s item.
                        {W="ash"; E="Yvette"}=1 :- match(E,P,W), P=275.
                        """
        }