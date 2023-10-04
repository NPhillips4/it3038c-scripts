import random

randomNumber = random.randrange(1,20)

print('Take your first guess. Enter a number 1-20')

userGuess = int(input())

guessCount = 1

while userGuess != randomNumber:

    if userGuess > randomNumber:

        guessCount = guessCount + 1

        print('Too high. Enter another guess.')

        userGuess = int(input())

    elif userGuess < randomNumber:

        guessCount = guessCount + 1

        print('Too low. Enter another guess.')

        userGuess = int(input())

    else:

        break

print("You guessed correctly in %s tries!" % guessCount)

    
    


