def is_even(num):
    if num % 2 == 0:
        return True
    else:
        return False

def multiply_by_two(num):
    return num * 2

def divide_by_two(num):
    return num / 2

# Main program flowchart
number = int(input("Enter a number: "))

if is_even(number):
    result = multiply_by_two(number)
else:
    result = divide_by_two(number)

print("Result:", result)
