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
    
    // Returns all the right guesses made by the player
    func getRightGuesses() -> String {
        var rightGuesses = ""
        for char in answer {
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
        return rightGuesses
    }
    
    // Print all the letters guessed by the player
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
    
    func askAnswer() {
        println("What is the answer? ")
        answer = trim(input().uppercaseString)
        clearScreen()
    }
    
    func askLetter() {
        print("What is your guess? ")
        guess = Character(input().uppercaseString.substringToIndex(1))
    }
    
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
    
    func checkGameStatus() {
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
    
    func play() {
        askAnswer()
        while (inProgress) {
            drawHangman()
            askLetter()
            checkLetter()
            clearScreen()
            checkGameStatus()
        }
        drawHangman()
    }
    
}
