//
//  ViewController.swift
//  HW2_YosiBenShushan
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Game_LBL_title: UILabel!
    @IBOutlet weak var game_lbl_score_left: UILabel!
    @IBOutlet weak var game_label_score_right: UILabel!
    @IBOutlet weak var Game_img_right: UIImageView!
    @IBOutlet weak var Game_img_left: UIImageView!
    
    @IBOutlet weak var player_Label_Left: UILabel!
    
    @IBOutlet weak var player_Label_Right: UILabel!
    
    @IBOutlet weak var time_Counter: UILabel!
    
    var playerName: String = ""
        var side: Bool = false
        var gameManager = GameManager()
        var timer: Timer?
        var flipTimer: Timer?
        var countdownValue = 5
        var gameRounds = 05
        let maxRounds = 10

        override func viewDidLoad() {
            super.viewDidLoad()
            setupShadow(for: Game_img_left)
            setupShadow(for: Game_img_right)
            setupPlayerLabels()
            startCountdown()
        }
        
        func setupPlayerLabels() {
            if side {
                player_Label_Left.text = "PC"
                player_Label_Right.text = playerName
            } else {
                player_Label_Left.text = playerName
                player_Label_Right.text = "PC"
            }
        }

        func setupShadow(for imageView: UIImageView) {
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOpacity = 0.8
            imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
            imageView.layer.shadowRadius = 10
            imageView.layer.masksToBounds = false
        }

        func startCountdown() {
            countdownValue = 5
            time_Counter.text = "\(countdownValue)"
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
            showBackOfCards()
        }

        func stopCountdown() {
            timer?.invalidate()
            timer = nil
            flipTimer?.invalidate()
            flipTimer = nil
        }

        @objc func updateCountdown() {
            countdownValue -= 1
            time_Counter.text = "\(countdownValue)"
            if countdownValue <= 0 {
                stopCountdown()
                flipCards()
            }
        }

        func showBackOfCards() {
            Game_img_left.image = UIImage(named: "card_back")
            Game_img_right.image = UIImage(named: "card_back")
        }

        func flipCards() {
            if gameRounds >= maxRounds {
                endGame()
                return
            }

            if let cards = gameManager.drawCards() {
                Game_img_left.image = UIImage(named: cards.leftCard)
                Game_img_right.image = UIImage(named: cards.rightCard)
                
                gameManager.updateScores(leftCardName: cards.leftCard, rightCardName: cards.rightCard)
                game_lbl_score_left.text = "\(gameManager.getPlayerLeftScore())"
                game_label_score_right.text = "\(gameManager.getPlayerRightScore())"
                
                countdownValue = 3
                time_Counter.text = "\(countdownValue)"
                flipTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateFlipCountdown), userInfo: nil, repeats: true)
            }

            gameRounds += 1
        }

        @objc func updateFlipCountdown() {
            countdownValue -= 1
            time_Counter.text = "\(countdownValue)"
            if countdownValue <= 0 {
                flipTimer?.invalidate()
                flipTimer = nil
                showBackOfCardsAgain()
            }
        }

        func showBackOfCardsAgain() {
            showBackOfCards()
            startCountdown()
        }

    func endGame() {
            stopCountdown()
            
            let winner: String
            let score: Int
            
            if gameManager.scoreLeft >= gameManager.scoreRight {
                winner = player_Label_Left.text ?? "Player"
                score = gameManager.getPlayerLeftScore()
            } else {
                winner = player_Label_Right.text ?? "Player"
                score = gameManager.getPlayerRightScore()
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let endGameVC = storyboard.instantiateViewController(withIdentifier: "EndGameViewController") as? EndGameViewController {
                endGameVC.winnerName = winner
                endGameVC.score = score
                self.navigationController?.pushViewController(endGameVC, animated: true)
            }
        }
    
    }
