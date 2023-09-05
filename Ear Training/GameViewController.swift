//
//  ViewController.swift
//  Ear Training
//
//  Created by Andrea Bottino on 04/03/2023.
//

import UIKit
import AVFoundation


class GameViewController: UIViewController {
    
    @IBOutlet var guessButtons: [UIButton]!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var startTimer: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    
    var player: AVAudioPlayer!
    let vibration = UINotificationFeedbackGenerator()
    var timer = Timer()
    
    var totalTime = 0
    var secondsPassed = 0
    
    var streakCounter = 0 {
        didSet {
            streakLabel.alpha = 1
            if streakCounter == 5 {
                streakLabel.text = "You're on a streak! \(streakCounter) correct guesses!"
                streakLabel.backgroundColor = backgroundColor
            } else if streakCounter >= 10 && streakCounter % 5 == 0 {
                streakLabel.text = "Insane! \(streakCounter) correct guesses!"
                streakLabel.backgroundColor = .yellow
            }
            else {
                streakLabel.alpha = 0
            }
        }
    }
    var consecErrors = 0 {
        didSet {
            if consecErrors > 0 {
                topLabel.backgroundColor = .red
                topLabel.alpha = 1
            }
            if consecErrors == 1 {
                topLabel.text = "Wrong"
            } else if consecErrors == 2 {
                topLabel.text = "Keep trying!"
            } else if consecErrors > 2 {
                topLabel.text = "Don't give up!"
            }
        }
    }
    var totalCorrect = 0 {
        didSet {
            if totalCorrect > 0 {
                topLabel.alpha = 1
                topLabel.text = "Correct"
                topLabel.backgroundColor = .green
            }
            if survivalModeActivated == true {
                secondsPassed -= 2
            }
        }
    }
    var totalErrors = 0 {
        didSet {
            if survivalModeActivated == true {
                secondsPassed += 2
            }
        }
    }
    
    let notes = ["C", "D", "E", "F", "G", "A", "B"]
    var randomNote = ""
    
    var backgroundColor: UIColor?
    var accentColor: UIColor?
    var survivalModeActivated: Bool?
    
    func setupUI() {
        view.backgroundColor = backgroundColor
        backButton.tintColor = accentColor
        topLabel.alpha = 0
        streakLabel.alpha = 0
        disableGuesses()
        
        repeatButton.isEnabled = false
        repeatButton.alpha = survivalModeActivated == true ? 0 : 1
        repeatButton.layer.cornerRadius = repeatButton.frame.height/3
        repeatButton.layer.borderWidth = 3
        repeatButton.layer.borderColor = accentColor?.cgColor
        repeatButton.tintColor = survivalModeActivated == true ? .white : .black
        
        startTimer.layer.cornerRadius = startTimer.frame.height/3
        startTimer.backgroundColor = accentColor
        progressBar.progress = 0
        progressBar.progressTintColor = accentColor
        
        for button in guessButtons {
            button.layer.cornerRadius = button.frame.height/2
            button.layer.borderWidth = 3
            button.layer.borderColor = accentColor?.cgColor
            button.tintColor = survivalModeActivated == true ? .white : .black
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
    
    func explainGame() {
        let alertTitle = survivalModeActivated == true ? "Survival Mode" : (totalTime == 30 ? "Easy Mode" : "Hard Mode")
        let alertMessage = survivalModeActivated == true ? "Are you ready for a real challenge? \nGuess as many notes as you can. \nCorrect guesses add 2 seconds to the timer, mistakes deduct 2 seconds! \nRepeat Sound button is unavailable" : "Guess as many notes as you can in \(totalTime) seconds."
        let explanation = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        explanation.addAction(UIAlertAction(title: "OK", style: .default))
        present(explanation, animated: true)
    }
    
    func endGame() {
        let endMessage = UIAlertController(title: "Time's up!", message: "You've guessed \(totalCorrect) notes correctly and made \(totalErrors) mistakes. ", preferredStyle: .alert)
        endMessage.addAction(UIAlertAction(title: "OK", style: .default))
        present(endMessage, animated: true)
    }
    
    
    func playSound(_ soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        explainGame()
    }
    
    @IBAction func repeatSound(_ sender: UIButton) {
        vibration.notificationOccurred(.success)
        playSound(randomNote)
    }
    
    @IBAction func guess(_ sender: UIButton) {
        if sender.currentTitle == randomNote {
            streakCounter += 1
            totalCorrect += 1
            consecErrors = 0
            
            randomNote = notes.randomElement()!
            playSound(randomNote)
            
        } else {
            streakCounter = 0
            consecErrors += 1
            totalErrors += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.topLabel.alpha = 0
            self.streakLabel.alpha = 0
        }
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        vibration.notificationOccurred(.success)
        
        if startTimer.currentTitle == "START TIMER" {
            startGame()
            
        } else if startTimer.currentTitle == "STOP TIMER" {
            stopGame()
        }
    }
    
    func startGame() {
        startTimer.setTitle("STOP TIMER", for: .normal)
        progressBar.progress = 1
        secondsPassed = 0
        totalCorrect = 0
        totalErrors = 0
        
        enableGuesses()
        
        repeatButton.isEnabled = true
        repeatButton.alpha = 1
        
        randomNote = notes.randomElement()!
        playSound(randomNote)
        backButton.isEnabled = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            [self] timer in
            
            if secondsPassed < totalTime {
                let percentageProgress = Float(secondsPassed) / Float(totalTime)
                progressBar.progress = 1 - Float(percentageProgress)
                secondsPassed += 1
                
            } else {
                stopGame()
                endGame()
            }
        }
    }
    
    func stopGame() {
        startTimer.setTitle("START TIMER", for: .normal)
        timer.invalidate()
        backButton.isEnabled = true
        playSound("Silence")
        repeatButton.isEnabled = false
        repeatButton.alpha = 0.3
        disableGuesses()
        progressBar.progress = 0
    }
    
    @IBAction func backIsPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}






    

        
    
    
    
    
    
    
    
    

