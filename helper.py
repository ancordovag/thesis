import openai
import time

'''
Function that connect to OpenAI
@param prompt
@return response
'''
def get_completion(prompt, model="gpt-3.5-turbo"):
    messages = [{"role": "user", "content": prompt}]
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0, # this is the degree of randomness of the model's output
    )
    time.sleep(0.3)
    return response.choices[0].message["content"]

#===========================================================================
# ====================== Variation 1, 2 and 3 ==============================
#===========================================================================
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

def get_constants(example_1,example_2,query):
    instruction = '''Given a problem, extract all different constants and their categories in the form "category: constant_1; constant_2; ...; constant_n". Here, the format of each constant is turned into either an integer or a string surrounded by double quotes, e.g., "some name".'''
    prompt = get_text_for_constants(instruction, example_1,example_2,query["problem"])
    constants = get_completion(prompt)
    return constants

def get_predicates(example_1,example_2,query):
    instruction = '''Given a problem and some categorized constants of the form "category: constant_1; constant_2; ...;
    constant_n", generate the minimum number of predicates to define the relations among the categories of constants. Each generated
    predicate is of the form "predicate(X1, X2, ..., Xn)" where X1, X2, ..., Xn are different variables and each variable X belongs to one of
    the categories. For each category, there must exist at least one variable of some predicate that belongs to this category.'''
    prompt = get_text_for_predicates(instruction, example_1,example_2,query["problem"],query["constants"])
    predicates = get_completion(prompt)
    return predicates

def get_generation_rules(example_1,example_2,query):
    instruction = '''Given some categorized constants in the form "
category: constant_1; constant_2; ...; constant_n" and some predicates about the relation among different categories of constants, write ASP (Answer Set Programming) rules to generate the search space of possible relations.'''
    prompt = get_text_for_generation_rules(instruction, example_1,example_2, query["constants"],query["predicates"])
    generation_rules = get_completion(prompt)
    return generation_rules

def get_definition_rules(example_1,example_2,query, version=2):
    instruction = '''Consider the constraint in the following form
    <C1>; <C2>; ...; <Cm> :- <L1>, <L2>, ..., <Ln>. which says that if the conjunction "<L1> and <L2> and ... and <Ln>" is true, then the disjunction of comparisons "<C1> or <C2> or ... or <Cm>" must be true.
    One can also add a restriction that "exactly k of <C1>, <C2>, ..., <Cm> is true" by using the following form 
    {<C1>; <C2>; ...; <Cm>}=k :- <L1>,<L2>, ..., <Ln>. 
    Given a problem, extract all constraints from the clues in the problem using only the provided constants and predicates.'''
    prompt = get_text_for_definition_rules(instruction, example_1,example_2,query["problem"],query["constants"],query["predicates"])
    definition_rules = get_completion(prompt)
    return definition_rules

def pipeline(example_1,example_2,query):
    query["constants"] = get_constants(example_1,example_2,query)
    #print("Constants: "+query["constants"])
    query["predicates"] = get_predicates(example_1,example_2,query)
    #print("Predicates: "+query["predicates"])
    query["rules"] = get_generation_rules(example_1,example_2,query)
    query["constraints"] = get_definition_rules(example_1,example_2,query)
    asp_code = [query["rules"],query["constraints"]]
    answer = '\n'.join(asp_code)
    return answer

#===========================================================================
# ========================== Variation 5 ===================================
#===========================================================================
def get_generic_text(instruction, example_1,example_2,query,features):
    text = f'''{instruction}
            
        '''
    for key in features:
        text += f'''{key.capitalize()} 1:
                    {example_1[key.lower()]}

        '''
    for key in features:
        text += f'''{key.capitalize()} 2:
                    {example_2[key.lower()]}

        '''
    for key in features[:-1]:
        text += f'''{key.capitalize()} 3:
                    {query[key.lower()]}

        '''
    text += f'''{features[-1].capitalize()} 3: '''
    return text
                     
def produce_generation_rules(example_1, example_2, query):
    instruction = '''Given a problem and some predicates, write ASP (Answer Set Programming) rules to generate the search space of possible relations. Do not repeat rules.'''
    prompt = get_generic_text(instruction, example_1, example_2, query, ["problem","input_predicates","output_predicate","rules"])    
    generation_rules = get_completion(prompt)
    return generation_rules
    
def produce_definition_rules(example_1,example_2,query):
    instruction = '''Consider the constraint in the following form
    <C1>; <C2>; ...; <Cm> :- <L1>, <L2>, ..., <Ln>. which says that if the conjunction "<L1> and <L2> and ... and <Ln>" is true, then the disjunction of comparisons "<C1> or <C2> or ... or <Cm>" must be true.
    One can also add a restriction that "exactly k of <C1>, <C2>, ..., <Cm> is true" by using the following form 
    {<C1>; <C2>; ...; <Cm>}=k :- <L1>,<L2>, ..., <Ln>. 
    Given a problem, extract all constraints from the clues in the problem using only the provided constants and predicates. Do not repeat rules.'''
    prompt = get_generic_text(instruction, example_1,example_2, query, ["problem", "input_predicates","output_predicate", "constraints"])
    definition_rules = get_completion(prompt)
    return definition_rules