//
//  Game.swift
//  Apple Pie.
//
//  Created by Fatima Zekic on 10/17/22.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    // keeps track of guessed letters
    var guessedLetters: [Character]
    
    // recieves a character, adds it to the collection, and updates incorrectMovesRemaining
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
        }
    }
    
    var formattedWord: String {
        // empty string
        var guessedWord = ""
        // goes through each character of the word
        for letter in word {
            // if the letter is in guessedLetters, convert to string and append it to guessedWord
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                // if its not a correct letter, append _ to guessed word
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    
}
