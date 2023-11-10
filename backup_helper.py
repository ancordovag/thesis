def get_text_for_constants(instruction, example_1, example_2, problem):
    text = f"""{instruction}
    
    Problem 1:
    {example_1["problem"]}
    
    Constants:
    {example_1["constants"]}
    
    Problem 2:
    {example_2["problem"]}
    
    Constants:
    {example_2["constants"]}
    
    Problem 3:
    {problem}
    
    Constants:
    """
    return text

def get_text_for_predicates(instruction, example_1, example_2, problem, constants):
    text = f"""{instruction}
    
    Problem 1:
    {example_1["problem"]}
    
    Constants 1:
    {example_1["constants"]}

    Predicates 1:
    {example_1["predicates"]}
    
    Problem 2:
    {example_2["problem"]}
    
    Constants 2:
    {example_2["constants"]}

    Predicates 2:
    {example_2["predicates"]}

    Problem 3:
    {problem}
    
    Constants 3:
    {constants}

    Predicates 3:
    """
    return text

def get_text_for_generation_rules(instruction, example_1,example_2, constants, predicates):
    text = f"""{instruction}

    Constants 1:
    {example_1["constants"]}

    Predicates 1:
    {example_1["predicates"]}

    ASP Rules 1:
    {example_1["rules"]}
    
    Constants 2:
    {example_2["constants"]}

    Predicates 2:
    {example_2["predicates"]}

    ASP Rules 2:
    {example_2["rules"]}

    Constants 3: 
    {constants}
    
    Predicates 3: 
    {predicates}
    
    ASP Rules 3: """ 
    return text

def get_text_for_definition_rules(instruction, example_1,example_2, problem, constants, predicates):
    text = f"""{instruction}

    Problem 1:    
    {example_1["problem"]}

    Constants 1:     
    {example_1["constants"]}
    
    Predicates 1:    
    {example_1["predicates"]}

    Constraints 1: 
    {example_1["constraints"]}
    
    Problem 2: 
    {example_2["problem"]}

    Constants 2:     
    {example_2["constants"]}
    
    Predicates 2:    
    {example_2["predicates"]}

    Constraints 2: 
    {example_2["constraints"]}

    Problem 3: 
    {problem}
    
    Constants 3:
    {constants}
    
    Predicates 3:    
    {predicates}

    Constraints 3: """
    return text
