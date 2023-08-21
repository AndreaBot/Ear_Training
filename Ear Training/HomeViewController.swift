//
//  HomeViewController.swift
//  Ear Training
//
//  Created by Andrea Bottino on 09/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var easyOption: UIButton!
    @IBOutlet weak var hardOption: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet var allButtons: [UIButton]!
    
    let vibration = UINotificationFeedbackGenerator()
    
    var totalTime: Int = 0 {
        didSet {
            var alertMessage = totalTime == 30 ? "Easy Mode" : "Hard Mode"
            let explanation = UIAlertController(title: alertMessage, message: "Guess as many notes as you can in \(totalTime) seconds.", preferredStyle: .alert)
            explanation.addAction(UIAlertAction(title: "OK", style: .default))
            present(explanation, animated: true)
            continueButton.backgroundColor = UIColor(named: "blueColor")
            continueButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.isEnabled = false
        for button in allButtons {
            button.layer.cornerRadius = 15
        }
    }
    
    @IBAction func difficultySelected(_ sender: UIButton) {
        
        self.vibration.notificationOccurred(.success)
        
        if sender.currentTitle == "Easy" {
            totalTime = 30
            showSelection(easyOption, hardOption)
        } else if sender.currentTitle == "Hard" {
            totalTime = 10
            showSelection(hardOption, easyOption)
        }
        
        func showSelection(_ selectedButton: UIButton, _ deselectedButton: UIButton) {
            selectedButton.layer.cornerRadius = selectedButton.frame.height/2
            selectedButton.layer.borderWidth = 3
            selectedButton.layer.borderColor = UIColor(named: "blueColor")?.cgColor
            deselectedButton.layer.borderColor = UIColor(named: "blueColor")?.withAlphaComponent(0).cgColor
        }
    }
    
    @IBAction func proceedToGame(_ sender: UIButton) {
        self.vibration.notificationOccurred(.success)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNext" {
            let destinationVC = segue.destination as? GameViewController
            destinationVC?.totalTime = totalTime
        }
    }
}

