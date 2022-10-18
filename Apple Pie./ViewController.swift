//
//  ViewController.swift
//  Apple Pie.
//
//  Created by Fatima Zekic on 10/17/22.
//

import UIKit

var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]

let incorrectMovesAllowed = 7

class ViewController: UIViewController {
    // begin a new round after a win
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    // begin a round after a loss
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var currentGame: Game!
    
    func newRound(){
        if !listOfWords.isEmpty {
            // removes the first word of the list when player completes a round
            let newWord = listOfWords.removeFirst()
            // creates a new instance of Game
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            updateUI()
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI(){
        
        // displays the final formatted word at the bottom of the screen
        var letters = [String]()
        // store each newly created strings into a string array
        for letter in currentGame.formattedWord {
            // convert the array of characters to array of strings
            letters.append(String(letter))
        }
        // join the new collection together separated by blank spaces
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        // displays wins & losses score
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    // when a letter is pressed
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    // updates game when player wins or loses a round
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            // if player loses round
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            // if player wins round
            totalWins += 1
        } else {
            updateUI()
        }
    }
}

