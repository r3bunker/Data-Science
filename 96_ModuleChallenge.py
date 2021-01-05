import datetime
import sys
import random

print(datetime.datetime.now())
print(sys.copyright)
print(sys.executable)

print(random.randint(1, 100))

x = 12
key = True
if x > 10:
    if key:
        print("X is greater than 10 and has the key.")
    else:
        print("x is greater than 10 and does not have the key")
elif x == 10:
    print("X is 10")
else:
    print("x is less than 10.")

print(10 > 9)

x = isinstance(5, int)
print(x)

i = 0
for i in range(10):
    print("{}".format(i))
    if i == 5:
        break
    elif i == 6:
        continue
    else:
        print("Let's keep it moving")

mySentence = 'loves the color'

colorList = ['red', 'blue', 'green', 'pink', 'teal', 'black']


def colorFunction(name):
    lst = []
    for i in colorList:
        msg = '{0} {1} {2}'.format(name, mySentence, i)
        lst.append(msg)
    return lst


def getName():
    go = True
    while go:
        name = input("What is your name?")
        if name == '':
            print("you need to enter your name")
        elif name == "Sally":
            print("Sally, you may not use this software")
        else:
            go = False
    lst = colorFunction(name)
    for i in lst:
        print(i)


getName()


def favTeam():
    userTeam = input("What is your favorite sports team?")
    if userTeam == '':
        print("Please enter a team")
    elif userTeam == "Cowyboys":
        print("Wrong")
    else:
        print("{} is a great team. Good choice!".format(userTeam))


favTeam()
