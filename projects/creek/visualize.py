from matplotlib import pyplot
from matplotlib import colors
from matplotlib.ticker import MaxNLocator

def get_color(cells,y,x):    
    to_look = '('+str(y)+','+str(x)+')'
    for cell in cells:
        if to_look in cell:
            if 'white' in cell:
                return 1
            elif 'black' in cell:
                return 0
            else:
                print('WTH?')
                return -2

with open('output.lp','r') as file:
    lines = file.readlines()

for line in lines:
    if 'black(' in line:
        cells = line.split()
        break

print("CELLS {}".format(cells))

n_rows =  4
n_columns = 3

data = []
for x in range(1,n_rows+1):
    row = []
    for y in range(1,n_columns+1):    
        color = get_color(cells,y,x)
        row.append(color)
    data.append(row)

print("Data {}".format(data))

colormap = colors.ListedColormap(["blue","yellow"])
#pyplot.figure(figsize=(5,5))
#pyplot.ylim(1,n_rows+1)
#pyplot.xlim(1,n_columns+1)
pyplot.gca().xaxis.set_major_locator(MaxNLocator(integer=True))
pyplot.gca().yaxis.set_major_locator(MaxNLocator(integer=True))
pyplot.imshow(data, cmap=colormap)
pyplot.grid()
pyplot.show()

    

    
