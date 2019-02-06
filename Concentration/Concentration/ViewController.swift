//
//  ViewController.swift
//  Concentration
//
//  Created by Admin on 23.01.2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsCards)
    
    var numberOfPairsCards: Int {
            return (cardButtons.count + 1) / 2
    }
    
    
    @IBAction func newGame(_ sender: UIButton) {
        game.resetGame()
        emojiChoices = emojiTheme.randomElement()!.value
        updateViewFromModel()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! 
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("wrong card")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5720329582, blue: 0.3450941814, alpha: 0) : #colorLiteral(red: 1, green: 0.5720329582, blue: 0.3450941814, alpha: 1)
            }
            scoreLabel.text = "Score: \(game.score)"
            flipCountLabel.text = "Flips: \(game.flipCount)"
        }
    }
    // private var emojiChoices = ["👻", "🎃", "😈", "👺", "💀", "🙀", "🧛🏻‍♂️", "🦇"]
    
    private let emojiTheme = [
    "halloween" : "👻🎃😈👺💀🙀🧛🏻‍♂️🦇",
    "animals" : "🐼🐔🦄🐤🙊🐝🐞🐙",
    "sports" : "🏀🏈⚾️🎱🎾🏐⚽️🎲",
    "faces" : "😀😢😔😗😣🤬🤯😬",
    "cars" : "🚗🚕🚙🚌🚎🏎🚓🚑",
    "fruits" : "🍏🍎🍐🍊🍋🍌🍉🍇",
    "flags" : "🏳️‍🌈🇦🇺🇦🇹🇦🇿🇦🇽🇦🇱🇧🇯🇷🇺"
    ]
    
    private lazy var emojiChoices = emojiTheme.randomElement()!.value
    
    private var emoji = [Card: String]()
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStrinIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStrinIndex))
        }
        return emoji[card] ?? "?"
    }
}


extension Int {
    var arc4random: Int {
        if self == 0 {
            return 0
        } else  if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
    }
}

