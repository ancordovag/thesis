from helper import get_completion

#===========================================================================
# ===================== Generic Prompt generator ===========================
#===========================================================================
def get_prompt(instruction, example_1,example_2,query,features):
    text = f'''{instruction}
            
        '''
    for key in features:
        text += f'''{key.capitalize()} 1:
                    {example_1[key]}

        '''
    for key in features:
        text += f'''{key.capitalize()} 2:
                    {example_2[key]}

        '''
    for key in features[:-1]:
        text += f'''{key.capitalize()} 3:
                    {query[key]}

        '''
    text += f'''{features[-1].capitalize()} 3: '''
    return text

#===========================================================================
# ====================== Variation 1 =======================================
#===========================================================================
def get_constants(example_1,example_2,query):
    instruction = '''Given a problem, extract all different constants and their categories in the form "category: constant_1; constant_2; ...; constant_n". Here, the format of each constant is turned into either an integer or a string surrounded by double quotes, e.g., "some name".'''
    prompt = get_prompt(instruction, example_1,example_2,query,["problem","constants"])
    constants = get_completion(prompt)
    return constants

def get_predicates(example_1,example_2,query):
    instruction = '''Given a problem and some categorized constants of the form "category: constant_1; constant_2; ...;
    constant_n", generate the minimum number of predicates to define the relations among the categories of constants. Each generated
    predicate is of the form "predicate(X1, X2, ..., Xn)" where X1, X2, ..., Xn are different variables and each variable X belongs to one of
    the categories. For each category, there must exist at least one variable of some predicate that belongs to this category.'''
    prompt = get_prompt(instruction, example_1,example_2,query,["problem","constants","predicates"])
    predicates = get_completion(prompt)
    return predicates

def get_generation_rules(example_1,example_2,query):
    instruction = '''Given some categorized constants in the form "
category: constant_1; constant_2; ...; constant_n" and some predicates about the relation among different categories of constants, write ASP (Answer Set Programming) rules to generate the search space of possible relations.'''
    prompt = get_prompt(instruction, example_1,example_2, query, ["constants","predicates","rules"])
    generation_rules = get_completion(prompt)
    return generation_rules, prompt

def get_definition_rules(example_1,example_2,query, version=2):
    instruction = '''Consider the constraint in the following form
    <C1>; <C2>; ...; <Cm> :- <L1>, <L2>, ..., <Ln>. which says that if the conjunction "<L1> and <L2> and ... and <Ln>" is true, then the disjunction of comparisons "<C1> or <C2> or ... or <Cm>" must be true.
    One can also add a restriction that "exactly k of <C1>, <C2>, ..., <Cm> is true" by using the following form 
    {<C1>; <C2>; ...; <Cm>}=k :- <L1>,<L2>, ..., <Ln>. 
    Given a problem, extract all constraints from the clues in the problem using only the provided constants and predicates.'''
    prompt = get_prompt(instruction, example_1,example_2,query,["constants","predicates","constraints"])
    definition_rules = get_completion(prompt)
    return definition_rules, prompt

def pipeline1(example_1,example_2,query):
    query["constants"] = get_constants(example_1,example_2,query)
    #print("Constants: "+query["constants"])
    query["predicates"] = get_predicates(example_1,example_2,query)
    #print("Predicates: "+query["predicates"])
    query["rules"], prompt1 = get_generation_rules(example_1,example_2,query)
    query["constraints"], prompt2 = get_definition_rules(example_1,example_2,query)
    asp_code = [query["rules"],query["constraints"]]
    answer = '\n'.join(asp_code)
    prompts = [prompt1, prompt2]
    return answer, prompts

#===========================================================================
# ========================== Variation 2 ===================================
#===========================================================================                     
def produce_generation_rules(example_1, example_2, query):
    instruction = '''Given a problem and some predicates, write ASP (Answer Set Programming) rules to generate the search space of possible relations. Do not repeat rules.'''
    prompt = get_prompt(instruction, example_1, example_2, query, ["problem","input_predicates","output_predicate","rules"])    
    generation_rules = get_completion(prompt)
    return generation_rules, prompt
    
def produce_definition_rules(example_1,example_2,query):
    instruction = '''Consider the constraint in the following form
    <C1>; <C2>; ...; <Cm> :- <L1>, <L2>, ..., <Ln>. which says that if the conjunction "<L1> and <L2> and ... and <Ln>" is true, then the disjunction of comparisons "<C1> or <C2> or ... or <Cm>" must be true.
    One can also add a restriction that "exactly k of <C1>, <C2>, ..., <Cm> is true" by using the following form 
    {<C1>; <C2>; ...; <Cm>}=k :- <L1>,<L2>, ..., <Ln>. 
    Given a problem, extract all constraints from the clues in the problem using only the provided constants and predicates. Do not repeat rules.'''
    prompt = get_prompt(instruction, example_1,example_2, query, ["problem", "input_predicates","output_predicate", "constraints"])
    definition_rules = get_completion(prompt)
    return definition_rules, prompt

def pipeline2(example_1,example_2,copy_problem):
    generation_rules, prompt1 = produce_generation_rules(example_1,example_2,copy_problem)
    definition_rules, prompt2 = produce_definition_rules(example_1,example_2,copy_problem)
    asp_code = [generation_rules,definition_rules]
    answer = '\n'.join(asp_code)
    prompts = [prompt1, prompt2]
    return answer, prompts
    
#===========================================================================
# ========================== Variation 3 ===================================
#===========================================================================
def produce_definition_from_generation_rules(example_1,example_2,query):
    instruction = '''Consider the constraint in the following form
    <C1>; <C2>; ...; <Cm> :- <L1>, <L2>, ..., <Ln>. which says that if the conjunction "<L1> and <L2> and ... and <Ln>" is true, then the disjunction of comparisons "<C1> or <C2> or ... or <Cm>" must be true.
    One can also add a restriction that "exactly k of <C1>, <C2>, ..., <Cm> is true" by using the following form 
    {<C1>; <C2>; ...; <Cm>}=k :- <L1>,<L2>, ..., <Ln>. 
    Given a problem, extract all constraints from the clues in the problem using only the provided constants and predicates. Do not repeat rules.'''
    prompt = get_prompt(instruction, example_1,example_2, query, ["problem", "input_predicates","output_predicate", "rules", "constraints"])
    definition_rules = get_completion(prompt)
    return definition_rules, prompt
    
def pipeline3(example_1,example_2,copy_problem):
    generation_rules, prompt1 = produce_generation_rules(example_1,example_2,copy_problem)
    definition_rules, prompt2 = produce_definition_from_generation_rules(example_1,example_2,copy_problem)
    asp_code = [generation_rules,definition_rules]
    answer = '\n'.join(asp_code)
    prompts = [prompt1, prompt2]
    return answer, prompts

#===========================================================================
# ========================== Variation 4 ===================================
#===========================================================================
def produce_encoding(example_1,example_2,query):
    instruction = '''Given a problem, some input predicates and an output predicate, write an ASP (Answer Set Programming) encoding.'''
    prompt = get_prompt(instruction, example_1,example_2, query, ["problem", "input_predicates","output_predicate", "encoding"])
    rules = get_completion(prompt)
    return rules, prompt
    
def pipeline4(example_1,example_2,copy_problem):
    answer, prompt = produce_encoding(example_1,example_2,copy_problem)
    prompts = [prompt, ""]
    return answer, prompts

#===========================================================================
# ========================== Variation 5 ===================================
#===========================================================================
def produce_normal_rules(example_1,example_2,query):
    instruction = '''Given a problem, write normal rules in an ASP (Answer Set Programming) encoding of the form  <C1> :- <L1>, <L2>, ..., <Ln>. which says that if the conjunction "<L1> and <L2> and ... and <Ln>" is true, then"<C1>" must be true.'''
    prompt = get_prompt(instruction,example_1,example_2,query,["problem","normal_rules"])
    rules = get_completion(prompt)
    return rules, prompt

def produce_constraint_rules(example_1,example_2, query):
    instruction = '''Given a problem and some normal rules, write some integrity constraints of the form: ":- <L1>, <L2>, ..., <Ln>." which says that the conjunction "<L1> and <L2> and ... and <Ln>" cannot be true,'''
    prompt = get_prompt(instruction,example_1,example_2,query,["problem","normal_rules","integrity_constraints"])
    rules = get_completion(prompt)
    return rules, prompt
    
def pipeline5(example_1,example_2,query):
    normal_rules, prompt1 = produce_normal_rules(example_1, example_2, query)
    query['normal_rules'] = normal_rules
    constraints, prompt2 = produce_constraint_rules(example_1, example_2, query)
    answer = "".join([normal_rules,constraints])
    prompts = [prompt1, prompt2]
    return answer, prompts

#===========================================================================
#========================== Variation 6 ====================================
#===========================================================================

def produce_possible_rules(example_1,example_2,query):
    instruction = '''Given a problem and a representation in ASP with an expected output predicate X, write rules of the form "possible_X :- <L1>, <L2>, ..., <Ln>." which says that if the conjunction "<L1> and <L2> and ... and <Ln>" is true, then "possible_X" must be true. The output predicate must contain the prefix "possible".'''
    prompt = get_prompt(instruction,example_1,example_2,query,["problem","Representation in ASP","possible_rules"])
    rules = get_completion(prompt)
    return rules, prompt
    
def pipeline6(example_1,example_2,query):
    possible_rules, prompt = produce_possible_rules(example_1, example_2, query)
    answer = "".join([possible_rules])
    prompts = [prompt,""]
    return answer, prompts

#===========================================================================
#========================== Variation 7 ====================================
#===========================================================================

def produce_possible_rules2(example_1,example_2,query):
    instruction = '''Given a problem and a representation in ASP with an expected output predicate X, write rules of the form "possible_X :- <L1>, <L2>, ..., <Ln>." which says that if the conjunction "<L1> and <L2> and ... and <Ln>" is true, then "possible_X" must be true. The output predicate must contain the prefix "possible". For example, if the output predicate is "match", then the code generates the predicate "possible_match".'''
    prompt = get_prompt(instruction,example_1,example_2,query,["problem","Representation in ASP","possible_rules"])
    rules = get_completion(prompt)
    return rules, prompt
    
def pipeline7(example_1,example_2,query):
    possible_rules, prompt = produce_possible_rules2(example_1, example_2, query)
    answer = "".join([possible_rules])
    prompts = [prompt,""]
    return answer, prompts

#===========================================================================
#========================== Variation 8 ====================================
#===========================================================================

def produce_possible_rules3(example_1,example_2,query):
    instruction = '''Given a problem and a representation in ASP with an expected output predicate X, write rules of the form "possible_X :- <L1>, <L2>, ..., <Ln>." which says that if the conjunction "<L1> and <L2> and ... and <Ln>" is true, then "possible_X" must be true. The output predicate must contain the prefix "possible". For example, if the output predicate is "match", then the code generates the predicate "possible_match". Just write the possible predicates rules, do NOT try to solve the problem.'''
    prompt = get_prompt(instruction,example_1,example_2,query,["problem","Representation in ASP","possible_rules"])
    rules = get_completion(prompt)
    return rules, prompt
    
def pipeline8(example_1,example_2,query):
    possible_rules, prompt = produce_possible_rules3(example_1, example_2, query)
    answer = "".join([possible_rules])
    prompts = [prompt,""]
    return answer, prompts

#===========================================================================
#========================== Variation 9 ====================================
#===========================================================================

def produce_possible_rules4(example_1,example_2,query):
    instruction = '''Given a problem and a representation in ASP, write generation rules to generate the expected output using the input predicates. Do not write contraints nor try to solve the whole problem, but just write the generation rules.'''
    prompt = get_prompt(instruction,example_1,example_2,query,["problem","Representation in ASP","Generation rules"])
    rules = get_completion(prompt)
    return rules, prompt
    
def pipeline9(example_1,example_2,query):
    possible_rules, prompt = produce_possible_rules4(example_1, example_2, query)
    answer = "".join([possible_rules])
    prompts = [prompt,""]
    return answer, prompts
    
#===========================================================================
# ========================== Main Pipeline =================================
#===========================================================================
def pipeline(example_1,example_2,query,version):
    if version == 1:
        answer, prompts = pipeline1(example_1,example_2,query)
    elif version == 2:
        answer, prompts = pipeline2(example_1,example_2,query)
    elif version == 3: 
        answer, prompts = pipeline3(example_1,example_2,query)
    elif version == 4:
        answer, prompts = pipeline4(example_1,example_2,query)
    elif version == 5:
        answer, prompts = pipeline5(example_1,example_2,query)
    elif version == 6:
        answer, prompts = pipeline6(example_1,example_2,query)
    elif version == 7:
        answer, prompts = pipeline7(example_1,example_2,query)
    elif version == 8:
        answer, prompts = pipeline8(example_1,example_2,query)
    elif version == 9:
        answer, prompts = pipeline9(example_1,example_2,query)
    else:
        answer, prompts = pipeline1(example_1,example_2,query)
    return answer, prompts