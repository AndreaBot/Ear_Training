//
//  PracticeViewController.swift
//  Ear Training
//
//  Created by Andrea Bottino on 11/03/2023.
//

import UIKit
import AVFoundation


class PracticeViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    
    @IBOutlet weak var PracticeGuessC: UIButton!
    @IBOutlet weak var PracticeGuessD: UIButton!
    @IBOutlet weak var PracticeGuessE: UIButton!
    @IBOutlet weak var PracticeGuessF: UIButton!
    @IBOutlet weak var PracticeGuessG: UIButton!
    @IBOutlet weak var PracticeGuessA: UIButton!
    @IBOutlet weak var PracticeGuessB: UIButton!
    @IBOutlet weak var PracticePlaySound: UIButton!
    @IBOutlet weak var PracticeRepeatSound: UIButton!
   
    @IBOutlet weak var PracticeUILabel: UILabel!
    
    func disableGuesses() {
        PracticeGuessC.isEnabled = false ; PracticeGuessC.setTitleColor(.lightGray, for: .disabled)
        PracticeGuessD.isEnabled = false ; PracticeGuessD.setTitleColor(.lightGray, for: .disabled)
        PracticeGuessE.isEnabled = false ; PracticeGuessE.setTitleColor(.lightGray, for: .disabled)
        PracticeGuessF.isEnabled = false ; PracticeGuessF.setTitleColor(.lightGray, for: .disabled)
        PracticeGuessG.isEnabled = false ; PracticeGuessG.setTitleColor(.lightGray, for: .disabled)
        PracticeGuessA.isEnabled = false ; PracticeGuessA.setTitleColor(.lightGray, for: .disabled)
        PracticeGuessB.isEnabled = false ; PracticeGuessB.setTitleColor(.lightGray, for: .disabled)
    }
    
    func enableGuesses() {
        PracticeGuessC.isEnabled = true ; PracticeGuessC.setTitleColor(.black, for: .normal)
        PracticeGuessD.isEnabled = true ; PracticeGuessD.setTitleColor(.black, for: .normal)
        PracticeGuessE.isEnabled = true ; PracticeGuessE.setTitleColor(.black, for: .normal)
        PracticeGuessF.isEnabled = true ; PracticeGuessF.setTitleColor(.black, for: .normal)
        PracticeGuessG.isEnabled = true ; PracticeGuessG.setTitleColor(.black, for: .normal)
        PracticeGuessA.isEnabled = true ; PracticeGuessA.setTitleColor(.black, for: .normal)
        PracticeGuessB.isEnabled = true ; PracticeGuessB.setTitleColor(.black, for: .normal)
    }
    
    func disableBorder() {
        PracticeGuessC.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        PracticeGuessD.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        PracticeGuessE.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        PracticeGuessF.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        PracticeGuessG.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        PracticeGuessA.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        PracticeGuessB.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
    }
    
    func enableBorder() {
        PracticeGuessC.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        PracticeGuessD.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        PracticeGuessE.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        PracticeGuessF.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        PracticeGuessG.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        PracticeGuessA.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        PracticeGuessB.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        disableGuesses()
        disableBorder()
        PracticePlaySound.isEnabled = true
        
        PracticeRepeatSound.isEnabled = false
        
        let guessArray = [PracticeGuessC, PracticeGuessD, PracticeGuessE, PracticeGuessF, PracticeGuessG, PracticeGuessA, PracticeGuessB]
        for x in guessArray {
            x!.frame.size.height = 52
            x!.frame.size.width = 52
            x!.layer.cornerRadius = 30
            x!.layer.borderWidth = 3
        }
        PracticePlaySound.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
        PracticePlaySound.layer.cornerRadius = 15
        PracticeRepeatSound.layer.cornerRadius = 15
        PracticeRepeatSound.layer.borderWidth = 3
        PracticeRepeatSound.layer.borderColor = CGColor(gray: 0.3, alpha: 0.35)
    }
    
    var consecErrors = 0
    
    let vibration = UINotificationFeedbackGenerator()
    
    var notes = ["C", "D", "E", "F", "G", "A", "B"]
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    var randomNote = "A"
    
    func generateRandom (randomNote: inout String) {
        randomNote = notes.randomElement()!
    }
    
    @IBAction func playNote(_ sender: UIButton ) {
    
        enableGuesses()
        enableBorder()
        
        PracticeRepeatSound.isEnabled = true
        PracticeRepeatSound.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        PracticePlaySound.isEnabled = false
        PracticePlaySound.backgroundColor = UIColor(white: 0.6, alpha: 0.35)
        PracticeUILabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.vibration.notificationOccurred(.success)
        
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        sender.alpha = 1.0
        }
        
        generateRandom(randomNote: &randomNote)
        playSound(soundName: randomNote)
        
        //PracticeUILabel.text = randomNote
    }
    
    @IBAction func repeatSound(_ sender: UIButton) {
        
        self.vibration.notificationOccurred(.success)
        
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        sender.alpha = 1.0
        }
        
        playSound(soundName: randomNote)
    }
    
    @IBAction func guess(_ sender: UIButton) {
        
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        sender.alpha = 1.0
        }
        
        if randomNote == sender.currentTitle {
          PracticePlaySound.isEnabled = true
          PracticePlaySound.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
          disableGuesses()
          disableBorder()
          PracticeRepeatSound.isEnabled = false
          PracticeRepeatSound.layer.borderColor = CGColor(gray: 0.3, alpha: 0.35)
          PracticeUILabel.text = "Correct"
          PracticeUILabel.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1.0)
            
        } else {
        consecErrors += 1
          PracticeUILabel.text = "Wrong"
          PracticeUILabel.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
            if consecErrors == 2 {
                PracticeUILabel.text = "Keep trying!"
            } else if consecErrors >= 5 {
                PracticeUILabel.text = "Don't give up!"
            }
        }
    }
 }
