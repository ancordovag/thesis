jobs = {"story" : "jobs",
             "problem" :"""
                        1. There are four people: Roberta, Thelma, Steve, and Pete.
                        2. Among them, they hold eight different jobs.
                        3. Each holds exactly two jobs.
                        4. The jobs are: chef, guard, nurse, telephone operator, police officer (gender not implied), teacher, actor, and boxer.
                        5. The job of nurse is held by a male.
                        6. The husband of the chef is the telephone operator.
                        7. Roberta is not a boxer.
                        8. Pete has no education past the ninth grade.
                        9. Roberta, the chef, and the police officer went golfing together.""",
                "constants":'''person: "Roberta"; "Thelma"; "Steve"; "Pete".
                job: "chef"; "guard"; "nurse"; "telephone operator"; "police officer"; "teacher"; "actor"; "boxer".''',
                "predicates":'''% The categories in Constants include person, job, gender, and education. We use different variables P, J, G, and E to represent person, job, gender, and education.
                        % We assign a person P to job J, with gender G and education E, where P belongs to person, J belongs to job, G belongs to gender, and E belongs to education.
                        assign(P, J, G, E)'''
            }