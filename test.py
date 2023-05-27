print("1+2 \\n")

x = complex(1j)
print(type(x))

pi = 3.141592653589793238
print(type(pi))

x = int(float(10.1009)+10.899)
print(x)

a = 15/5
b = 10//3

n = 3.141592653589793238462643383279502884197169399375105

print(a == b)

pi = 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
print(type(pi))

import math

def say_pi(pi):
    if (pi == math.pi):
        print("pi is real !!!")
    else:
        print("this is not pi!")

say_pi(n)


thisdict = {
    "name": "ling",
    "identity": "19-001-1234-1111",
    "year": 1964
}

print(thisdict["identity"][1]+"1")

