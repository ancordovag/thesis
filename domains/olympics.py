olympics = {"story":"olympics",
            "problem":'''The Winter Olympics have just wrapped up in Norway. Using only the clues that follow,
                determine the number of gold, silver and bronze medals won by each country. Remember,
                as with all grid-based logic puzzles, no option in any category will ever be used more than once.
                1. The four teams are the team from Bolivia, the team that won 3 gold medals, the team that won 6 silver medals, and the team from Argentina.
                2. The team from Oman and the team that won 10 silver medals are different.
                3. The team from Oman finished with 2 gold medals or finished with 1 gold medal.
                5. The squad that won 3 gold medals, the squad that won 6 silver medals and the squad from Bolivia were all different teams.
                6. Neither the team from Argentina nor the squad that won 2 silver medals is the squad that won 4 gold medals.
                8. The squad that won 2 gold medals is either the squad that won 6 silver medals or the team from Grenada.''',
            "constants":'''country: "Argentina"; "Bolivia"; "Grenada"; "Oman".
                silver_medals: 2; 6; 10; 11.
                gold_medals: 1; 2; 3; 4.''',
            "predicates":'''% The categories include country, silver_medals, and gold_medals. We use different variables C, S, and G to represent country, silver_medals, and gold_medals.
                % We assign a country C with silver medals S and gold medals G, where C belongs to country, S belongs to silver_medals, and G belongs to gold_medals.
                assign(C, S, G) ''',
            "rules":'''% Define the constants in each category.
                country("Argentina"; "Bolivia"; "Grenada"; "Oman").
                silver_medals(2; 6; 10; 11).
                gold_medals(1; 2; 3; 4).
                % For each country C, it is assigned with exactly 1 silver medals S and 1 gold medals G.
                {assign(C, S, G): silver_medals(S), gold_medals(G)}=1 :- country(C).''',
            "constraints":'''% No option in any category will ever be used more than once.
                {C1=C2; S1=S2; G1=G2}=0 :- assign(C1,S1,G1), assign(C2,S2,G2), (C1,S1,G1)!=(C2,S2,G2).
                % 1. The four teams are the team from Bolivia, the team that won 3 gold medals, the team that won 6 silver medals, and the team from Argentina.
                {C="Bolivia"; G=3; S=6; C="Argentina"}=1 :- assign(C,S,G).
                % 2. The team from Oman and the team that won 10 silver medals are different.
                C1!=C2 :- assign(C1,S1,G1), assign(C2,S2,G2), C1="Oman", S2=10.
                % 3. The team from Oman finished with 2 gold medals or finished with 1 gold medal.
                {G=2; G=1}=1 :- assign(C,S,G), C="Oman".'''    }