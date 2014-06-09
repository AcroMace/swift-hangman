//
//  HangmanGame.swift
//  SwiftHangman
//
//  Created by Andy Cho on 2014-06-07.
//  Copyright (c) 2014 Andy Cho. All rights reserved.
//

import Foundation

class HangmanGame {
    
    /**************************************************/
    /* Private properties                             */
    /**************************************************/
    
    // Number of guesses that player got wrong
    // Game ends when this value reaches 6
    var numberOfWrongGuesses = 0
    
    // All guesses made by the player
    // Initially an empty array of characters
    var allGuesses = Character[]()
    
    // The word input as the answer
    // Length is countElements(answer)
    var answer = ""
    
    // The letter entered by the player
    var guess: Character = " "
    
    // Whether or not game is in progress
    var inProgress = true
    
    
    /**************************************************/
    /* Private methods                                */
    /**************************************************/
    
    // Prints 30 lines to clear the screen
    func clearScreen() {
        for i in 1..30 {
            println()
        }
    }
    
    // Returns a string of all the right guesses made by the player
    // Prints "_" if the user has not guessed the letter in the answer
    func getRightGuesses() -> String {
        var rightGuesses = ""
        for char in answer {
            if (char == " ") {
                rightGuesses += "  "
            } else {
                var charGuessed = false
                for guess in allGuesses {
                    if (char == guess) {
                        charGuessed = true
                    }
                }
                if charGuessed {
                    rightGuesses += char + " "
                } else {
                    rightGuesses += "_ "
                }
            }
        }
        return rightGuesses
    }
    
    // Prints all the letters guessed by the player
    func printUsedLetters() {
        if (allGuesses.isEmpty) {
            println("nothing")
        } else {
            for guess in allGuesses {
                print(guess + " ")
            }
            println()
        }
    }
    
    // Prompts the user for the answer
    // Stores user's answer in .answer
    func askAnswer() {
        println("What is the answer? ")
        answer = trim(input().uppercaseString)
        clearScreen()
    }
    
    // Prompts the user for a guess
    // Stores user's guess in .guess
    func askLetter() {
        var invalidGuess = true
        println("What is your guess? ")
        while invalidGuess {
            guess = Character(input().uppercaseString.substringToIndex(1))
            invalidGuess = false
            if (guess == " " || guess == "\n") {
                invalidGuess = true
            } else {
                for char in allGuesses {
                    if (guess == char) {
                        invalidGuess = true
                    }
                }
            }
            if invalidGuess {
                print("Please enter a letter you have not tried before: ")
            }
        }
    }
    
    // Checks to see if the guessed letter is a part of the answer
    // Increments .numberOfWrongGuesses if not
    // Adds the user's guess to .allGuesses
    func checkLetter() {
        var letterIsRight = false
        for char in answer {
            if char == guess {
                letterIsRight = true
            }
        }
        if (letterIsRight == false) {
            ++numberOfWrongGuesses
        }
        allGuesses.append(guess)
    }
    
    // Checks to see if the game has ended
    // Changes .inProgress to false if:
    //    the user has guessed all the letters in the answer
    //    the user has made more than 6 wrong guesses
    func updateGameStatus() {
        inProgress = false
        let rightGuesses = getRightGuesses()
        // Check if all letters have been guessed
        for char in rightGuesses {
            if (char == "_") {
                inProgress = true
            }
        }
        // Lose condition
        if (numberOfWrongGuesses == 6) {
            inProgress = false
        }
    }
    
    // Draws the hangman, answers, guesses, and game state
    func drawHangman() {
        // Line 1
        println("  __________     Answer:")
        // Line 2
        print("  |    |         ")
        println(getRightGuesses())
        // Line 3
        print("  |    ")
        if (numberOfWrongGuesses >= 1) {
            println("O")
        } else {
            println()
        }
        // Line 4
        print("  |")
        if (numberOfWrongGuesses <= 1) {
            print("              ")
        } else if (numberOfWrongGuesses == 2) {
            print("    |         ")
        } else if (numberOfWrongGuesses == 3) {
            print("   /|         ")
        } else if (numberOfWrongGuesses >= 4) {
            print("   /|\\        ")
        }
        println("You have guessed:")
        // Line 5
        print("  |")
        if (numberOfWrongGuesses == 5) {
            print("   /          ")
        } else if (numberOfWrongGuesses == 6) {
            print("   / \\        ")
        } else {
            print("              ")
        }
        printUsedLetters()
        // Line 6
        println("  |              ")
        // Line 7
        print("--------------   ")
        if (numberOfWrongGuesses == 6) {
            println("Game Over")
        } else if (inProgress == false) {
            println("You Win!")
        }
    }
    
    
    /**************************************************/
    /* Public methods                                 */
    /**************************************************/
    
    // Starts the game and runs the main game loop
    func play() {
        askAnswer()
        while (inProgress) {
            drawHangman()
            askLetter()
            checkLetter()
            clearScreen()
            updateGameStatus()
        }
        drawHangman()
    }
    
}
