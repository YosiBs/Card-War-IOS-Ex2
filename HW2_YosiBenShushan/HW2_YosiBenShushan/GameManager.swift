//
//  GameManager.swift
//  HW2_YosiBenShushan
//
//
import UIKit

class GameManager {
    let cardNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"]
    let cardSuits = ["clubs", "diamonds", "hearts", "spades"]
    
    var cardImages = [String]()
    var scoreLeft = 0
    var scoreRight = 0
    
    init() {
        setupCardImages()
        shuffleCards()
    }
    
    func setupCardImages() {
        for suit in cardSuits {
            for number in cardNumbers {
                let cardName = "\(number)_of_\(suit)"
                cardImages.append(cardName)
            }
        }
    }
    
    func shuffleCards() {
        cardImages.shuffle()
    }
    
    func drawCards() -> (leftCard: String, rightCard: String)? {
        guard cardImages.count >= 2 else {
            return nil
        }
        
        let leftCardName = cardImages.removeFirst()
        let rightCardName = cardImages.removeFirst()
        
        return (leftCardName, rightCardName)
    }
    
    func cardValue(for cardName: String) -> Int {
        let components = cardName.components(separatedBy: "_")
        if let numberString = components.first, let number = Int(numberString) {
            return number
        } else {
            return 0
        }
    }
    
    func updateScores(leftCardName: String, rightCardName: String) {
        let leftCardValue = cardValue(for: leftCardName)
        let rightCardValue = cardValue(for: rightCardName)
        
        if leftCardValue > rightCardValue {
            scoreLeft += 1
        } else if rightCardValue > leftCardValue {
            scoreRight += 1
        }
    }
    
    func getPlayerLeftScore() -> Int {
        return scoreLeft
    }
    
    func getPlayerRightScore() -> Int {
        return scoreRight
    }
}
