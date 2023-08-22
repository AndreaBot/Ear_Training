//
//  PracticeViewController.swift
//  Ear Training
//
//  Created by Andrea Bottino on 11/03/2023.
//

import UIKit
import AVFoundation


class PracticeViewController: UIViewController {
    
    @IBOutlet var guessButtons: [UIButton]!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    let vibration = UINotificationFeedbackGenerator()
    var player: AVAudioPlayer!
    var consecErrors = 0
    let notes = ["C", "D", "E", "F", "G", "A", "B"]
    var randomNote = "" {
        didSet {
            playSound(randomNote)
            enableGuesses()
            repeatButton.isEnabled = true
            repeatButton.alpha = 1
            playButton.isEnabled = false
            playButton.alpha = 0.3
            topLabel.alpha = 0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableGuesses()
        playButton.layer.cornerRadius = playButton.frame.height/3
        repeatButton.isEnabled = false
        repeatButton.layer.cornerRadius = repeatButton.frame.height/3
        repeatButton.layer.borderColor = UIColor(named: "blueColor")?.cgColor
        repeatButton.layer.borderWidth = 3
        repeatButton.alpha = 0.3
        for button in guessButtons {
            button.layer.cornerRadius = button.frame.height/2
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor(named: "blueColor")?.cgColor
            button.tintColor = .black
        }
    }
    
    func disableGuesses() {
        for button in guessButtons {
            button.isEnabled = false
            button.alpha = 0.3
        }
    }
    
    func enableGuesses() {
        for button in guessButtons {
            button.isEnabled = true
            button.alpha = 1
        }
    }
    
    func playSound(_ soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @IBAction func playNote(_ sender: UIButton ) {
        vibration.notificationOccurred(.success)
        randomNote = notes.randomElement()!
    }
    
    @IBAction func repeatSound(_ sender: UIButton) {
        vibration.notificationOccurred(.success)
        playSound(randomNote)
    }
    
    @IBAction func guess(_ sender: UIButton) {
        topLabel.alpha = 1
        
        if sender.currentTitle == randomNote  {
            consecErrors = 0
            playButton.isEnabled = true
            playButton.alpha = 1
            disableGuesses()
            repeatButton.isEnabled = false
            repeatButton.alpha = 0.3
            topLabel.text = "Correct"
            topLabel.backgroundColor = .green
            
        } else {
            consecErrors += 1
            topLabel.backgroundColor = .red
            if consecErrors == 1 {
                topLabel.text = "Wrong"
            } else if consecErrors == 2 {
                topLabel.text = "Keep trying!"
            } else if consecErrors >= 4 {
                topLabel.text = "Don't give up!"
            }
        }
    }
    
    @IBAction func backisPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
