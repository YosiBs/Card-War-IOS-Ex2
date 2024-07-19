//
//  EndGameViewController.swift
//  HW2_YosiBenShushan
//
//


import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet weak var score_Label: UILabel!
    @IBOutlet weak var winner_Label: UILabel!
    @IBOutlet weak var back_to_menu_btn: UIButton!
    var winnerName: String = ""
        var score: Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            back_to_menu_btn.contentHorizontalAlignment = .center
            back_to_menu_btn.contentVerticalAlignment = .center
            
            
            winner_Label.text = "\(winnerName) Won!"
            score_Label.text = "Score: \(score)"
        }
    

    @IBAction func backToMenuClicked(_ sender: UIButton) {
        // Navigate back to the first LoginViewController
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

}
