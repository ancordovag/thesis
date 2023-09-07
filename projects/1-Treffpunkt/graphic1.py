import sys
import optparse

def find_AS(stri):
    next = 0
    for l in stri:
        
        if (next == 1):
            return l
        if (l == "Answer: 1\n"):
            next = 1
            
def build_grid(i,j):
    arr = []
    d1 = i * 4 + 1
    d2 = j * 4 + 1
    for i in range(0,d1):
        arr.append([])
        for j in range(0,d2):
            if (i % 4 == 0):
                arr[i].append("-")
            else:
                if( (j) % 4 == 0):
                    arr[i].append("|")
                else:
                    if (j % 2 == 0) and (i % 2 == 0):
                        arr[i].append("+")
                    else:
                        arr[i].append(" ")
    return arr
                
def add_as(arr,asf,dim):
    try:
        for l in asf:
            if (l[:4] == "numb"):
                l = l[7:len(l)-1]
                l = l.split(",")
                arr[(int(l[0]) - 1) * 4 + 2][ (int(l[1]) - 1) * 4 + 2] = l[2]
            else:
                l  = l[5:len(l)-1]
                l = l.split(",")
                y1 = l[0]
                x1 = l[1]
                y2 = l[2]
                x2 = l[3]
                if(y1 == y2):
                    if (x1 > x2):
                        #print("east->west")
                        #print(l)
                        arr[(int(y2) - 1) * 4 + 2][ (int(x2) - 1) * 4 + 3] = "-"
                        arr[(int(y1) - 1) * 4 + 2][ (int(x1) - 1) * 4 + 1] = "-"
                    else:
                        #print("west->east")
                        #print(l)
                        arr[(int(y1) - 1) * 4 + 2][ (int(x1) - 1) * 4 + 3] = "-"
                        arr[(int(y2) - 1) * 4 + 2][ (int(x2) - 1) * 4 + 1] = "-"
     
                    
                if(x1 == x2):
                    if (y1 > y2):
                        #print("south->north")
                        #print(l)
                        arr[(int(y2) - 1) * 4 + 3][ (int(x2) - 1) * 4 + 2] = "|"
                        arr[(int(y1) - 1) * 4 + 1][ (int(x1) - 1) * 4 + 2] = "|"
     
                    else:
                        #print("north->south")
                        #print(l)
                        arr[(int(y1) - 1) * 4 + 3][ (int(x1) - 1) * 4 + 2] = "|"
                        arr[(int(y2) - 1) * 4 + 1][ (int(x2) - 1) * 4 + 2] = "|"
    except:
        print("SIZE of field is too small!")
        sys.exit()
    print_arr(arr)
                
def print_arr(arr):
    for i in range(0,len(arr)):
        stri = ""
        for j in range(0,len(arr[i])):
            stri = stri + str(arr[i][j])
        print(stri)

def main():
    try: scriptDir = os.path.join(scriptDir, os.path.dirname(os.readlink(__file__)))                                                                                            
    except: pass 
    
    usage = "Usage: %prog [--options]"
    parser = optparse.OptionParser(usage=usage)
    parser.add_option("-s", "--size", dest="size", type="int", default=3, help="size of puzzle")
    (options, args) = parser.parse_args()
   
    input_str = sys.stdin.readlines()
    
    # find "answer 1" in input stream
    asf = find_AS(input_str)
    parts = asf.split(" ")
    # filter "\n"
    parts = parts[:len(parts)-1]
    arr = build_grid(options.size,options.size)
    add_as(arr,parts,options.size)
    
   # print(parts)

main()