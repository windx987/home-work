n = int(input("Please enter a number: ")) # number of rows
for i in range(n):
    
    for j in range(n-i-1):
        print(" ", end="")

    for j in range(2*i+1):
        print("x", end="")

    for j in range(n-i-1):
        print(" ", end="")

    print()