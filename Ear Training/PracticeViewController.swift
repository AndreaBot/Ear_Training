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
    
    var gameModel = GameModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        gameModel.delegate = self
    }
    
    func setupUI() {
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
        gameModel.randomNote = gameModel.notes.randomElement()!
        playSound(gameModel.randomNote)
        repeatButton.isEnabled = true
        repeatButton.alpha = 1.0
        enableGuesses()
    }
    
    @IBAction func repeatSound(_ sender: UIButton) {
        vibration.notificationOccurred(.success)
        playSound(gameModel.randomNote)
    }
    
    @IBAction func guess(_ sender: UIButton) {
        gameModel.checkGuess(buttonTitle: sender.currentTitle!) {
            gameModel.randomNote = gameModel.notes.randomElement()!
            playSound(gameModel.randomNote)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.topLabel.alpha = 0
        }
    }
    
    @IBAction func backisPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}


//MARK: - GameModelDelegate

extension PracticeViewController: GameModelDelegate {
    func showAnswerIsCorrect() {
        if gameModel.totalCorrect > 0 {
            topLabel.alpha = 1
            topLabel.text = "Correct"
            topLabel.backgroundColor = .green
        }
        if gameModel.survivalModeActivated == true {
            gameModel.secondsPassed -= 2
        }
    }
    
    func updateLabelConsecErrors() {
        if gameModel.consecErrors > 0 {
            topLabel.backgroundColor = .red
            topLabel.alpha = 1
        }
        if gameModel.consecErrors == 1 {
            topLabel.text = "Wrong"
        } else if gameModel.consecErrors == 2 {
            topLabel.text = "Keep trying!"
        } else if gameModel.consecErrors > 2 {
            topLabel.text = "Don't give up!"
        }
    }
    
    func updateStreakLabel() {
    }
}
