//
//  Concentration.swift
//  Concentration
//
//  Created by Admin on 24.01.2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import Foundation

struct Concentration {
    
    private (set) var score = 0
    private (set) var flipCount = 0
    private var seenCards: Set<Int> = []
    private (set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): choosen index not in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if seenCards.contains(index) {
                        score -= 1
                    }
                    if seenCards.contains(matchIndex) {
                        score -= 1
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): you must have at least one pair of cards)")
        for _ in 1 ... numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func resetGame() {
        flipCount = 0
        score = 0
        seenCards = []
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards.shuffle()
        }

    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
