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
    @IBOutlet weak var practideModeButton: UIButton!
    @IBOutlet weak var survivalModeButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.isEnabled = false
        continueButton.backgroundColor = UIColor(white: 0.6, alpha: 0.5)
        continueButton.layer.cornerRadius = 15
        practideModeButton.layer.cornerRadius = 15
        practideModeButton.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
        survivalModeButton.layer.cornerRadius = 15
    }
    
    let vibration = UINotificationFeedbackGenerator()
    
    var totalTime = 0
    
    func easyGame() {
        let easyMessage = UIAlertController(title: "Easy Mode", message: "Guess as many notes as you can in 30 seconds.", preferredStyle: .alert)
        easyMessage.addAction(UIAlertAction(title: "OK", style: .default))
        present(easyMessage, animated: true)
    }
    
    func hardGame() {
        let hardMessage = UIAlertController(title: "Hard Mode", message: "Guess as many notes as you can in 10 seconds.", preferredStyle: .alert)
        hardMessage.addAction(UIAlertAction(title: "OK", style: .default))
        present(hardMessage, animated: true)
    }
    
    @IBAction func difficultySelected(_ sender: UIButton) {
        
        self.vibration.notificationOccurred(.success)
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
        continueButton.isEnabled = true
        continueButton.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
        if sender.currentTitle == "Easy" {
            totalTime = 30
            easyOption.layer.cornerRadius = 35
            easyOption.layer.borderWidth = 3
            easyOption.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
            hardOption.layer.borderColor = CGColor(red: 0, green: 0, blue: 1, alpha: 0)
            easyGame()
        } else if sender.currentTitle == "Hard" {
            totalTime = 10
            hardOption.layer.cornerRadius = 35
            hardOption.layer.borderWidth = 3
            hardOption.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
            easyOption.layer.borderColor = CGColor(red: 0, green: 0, blue: 1, alpha: 0)
            hardGame()
        }
    }
    
    @IBAction func `continue`(_ sender: UIButton) {
        
        self.vibration.notificationOccurred(.success)
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
    }
    
    @IBAction func practiceMode(_ sender: UIButton) {
        
        self.vibration.notificationOccurred(.success)
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
        
        //performSegue(withIdentifier: "goToPractice", sender: self)
    }
    
    @IBAction func survivalMode(_ sender: UIButton) {
        
        self.vibration.notificationOccurred(.success)
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
        
        //performSegue(withIdentifier: "goToSurvival", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNext" {
            let destinationVC = segue.destination as? ViewController
            destinationVC?.totalTime = totalTime
        }
        
    }
}
