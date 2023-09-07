from matplotlib import pyplot
# next, i will set up a 8 x 8 2d matrix, with random bits as elements (0 or 1); 
# for randomization of integers (0 or 1) I use the random module in Python;
# for building each row in the 2d matrix I use list comprehension in Python
import random
data = [[random.randint(a=0,b=1) for x in range(0,8)], # row 1
        [random.randint(a=0,b=1) for x in range(0,8)], # row 2
        [random.randint(a=0,b=1) for x in range(0,8)], # row 3
        [random.randint(a=0,b=1) for x in range(0,8)]] # row 4
# display the 2d data matrix
data
pyplot.figure(figsize=(5,5))
pyplot.imshow(data)
pyplot.show()