//
//  ViewController.swift
//  Ear Training
//
//  Created by Andrea Bottino on 04/03/2023.
//

import UIKit
import AVFoundation


class GameViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var guessC: UIButton!
    @IBOutlet weak var guessD: UIButton!
    @IBOutlet weak var guessE: UIButton!
    @IBOutlet weak var guessF: UIButton!
    @IBOutlet weak var guessG: UIButton!
    @IBOutlet weak var guessA: UIButton!
    @IBOutlet weak var guessB: UIButton!
    
    @IBOutlet weak var repeatSound: UIButton!
    
    @IBOutlet weak var startTimer: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    
    
    func disableGuesses() {
        guessC.isEnabled = false ; guessC.setTitleColor(.lightGray, for: .disabled)
        guessD.isEnabled = false ; guessD.setTitleColor(.lightGray, for: .disabled)
        guessE.isEnabled = false ; guessE.setTitleColor(.lightGray, for: .disabled)
        guessF.isEnabled = false ; guessF.setTitleColor(.lightGray, for: .disabled)
        guessG.isEnabled = false ; guessG.setTitleColor(.lightGray, for: .disabled)
        guessA.isEnabled = false ; guessA.setTitleColor(.lightGray, for: .disabled)
        guessB.isEnabled = false ; guessB.setTitleColor(.lightGray, for: .disabled)
    }
    
    func enableGuesses() {
        guessC.isEnabled = true ; guessC.setTitleColor(.black, for: .normal)
        guessD.isEnabled = true ; guessD.setTitleColor(.black, for: .normal)
        guessE.isEnabled = true ; guessE.setTitleColor(.black, for: .normal)
        guessF.isEnabled = true ; guessF.setTitleColor(.black, for: .normal)
        guessG.isEnabled = true ; guessG.setTitleColor(.black, for: .normal)
        guessA.isEnabled = true ; guessA.setTitleColor(.black, for: .normal)
        guessB.isEnabled = true ; guessB.setTitleColor(.black, for: .normal)
    }
    
    func disableBorder() {
        guessC.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        guessD.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        guessE.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        guessF.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        guessG.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        guessA.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
        guessB.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 0.35)
    }
    
    func enableBorder() {
        guessC.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        guessD.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        guessE.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        guessF.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        guessG.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        guessA.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        guessB.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
    }
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        disableGuesses()
        disableBorder()
        
        
        repeatSound.isEnabled = false
        
        let guessArray = [guessC, guessD, guessE, guessF, guessG, guessA, guessB]
        for x in guessArray {
            x!.frame.size.height = 52
            x!.frame.size.width = 52
            x!.layer.cornerRadius = 30
            x!.layer.borderWidth = 3
        }

        repeatSound.layer.cornerRadius = 15
        repeatSound.layer.borderWidth = 3
        repeatSound.layer.borderColor = CGColor(gray: 0.3, alpha: 0.35)
        
        startTimer.setTitle("START TIMER", for: .normal)
        startTimer.layer.cornerRadius = 15
        progressBar.progress = 0
        progressBar.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
    }
    
    func endGame() {
        let endMessage = UIAlertController(title: "Time's up!", message: "You've guessed \(self.totalCorrect) notes correctly and made \(self.totalErrors) mistakes. ", preferredStyle: .alert)
        endMessage.addAction(UIAlertAction(title: "OK", style: .default))
        present(endMessage, animated: true)
        repeatSound.isEnabled = false
        repeatSound.layer.borderColor = CGColor(gray: 0.3, alpha: 0.35)
    }
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @IBOutlet weak var UILabel: UILabel!
    @IBOutlet weak var Streak: UILabel!
    
    var streakCounter = 0
    var consecErrors = 0
    var totalCorrect = 0
    var totalErrors = 0
    
    let vibration = UINotificationFeedbackGenerator()
    
    var notes = ["C", "D", "E", "F", "G", "A", "B"]
    
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.UILabel.backgroundColor = UIColor(white: 1, alpha: 0)
        
        }
        enableGuesses()
        enableBorder()
    }
    var randomNote = "A"
    
    func generateRandom (randomNote: inout String) {
        randomNote = notes.randomElement()!
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
          streakCounter += 1
          totalCorrect += 1
          disableGuesses()
          disableBorder()
          UILabel.text = "Correct"
          UILabel.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1.0)
            
          repeatSound.isEnabled = true
          repeatSound.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
            
            generateRandom(randomNote: &randomNote)
            playSound(soundName: randomNote)
          
            if streakCounter == 5 {
                Streak.text = "You're on a streak! \(streakCounter) correct guesses!"
            }
            if streakCounter > 5 && streakCounter < 10 {
                Streak.text = ""
                Streak.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            }
            if streakCounter >= 10 && streakCounter % 5 == 0 {
                Streak.text = "Insane! \(streakCounter) correct guesses!"
                Streak.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)
                Streak.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
            }
            if streakCounter > 10 && streakCounter % 5 != 0 {
                Streak.text = ""
                Streak.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            }
        } else {
        streakCounter = 0
        consecErrors += 1
        totalErrors += 1
          UILabel.text = "Wrong"
          UILabel.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
            if consecErrors == 2 {
                UILabel.text = "Keep trying!"
            } else if consecErrors >= 5 {
                UILabel.text = "You've got this!"
            }
        }
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        
        progressBar.progress = 0.0
        secondsPassed = 0
        
        enableGuesses()
        enableBorder()
        
        repeatSound.isEnabled = true
        repeatSound.layer.borderColor = CGColor(red: 0, green: 0.35, blue: 1, alpha: 1)
        
        UILabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        Streak.text = ""
        Streak.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        
        self.vibration.notificationOccurred(.success)
        
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        sender.alpha = 1.0
        }
        
        generateRandom(randomNote: &randomNote)
        playSound(soundName: randomNote)
        
        totalCorrect = 0
        totalErrors = 0
        
        if startTimer.currentTitle == "START TIMER" {
            startTimer.setTitle("STOP TIMER", for: .normal)
            activateTimer()
            backButton.isEnabled = false
        } else if startTimer.currentTitle == "STOP TIMER" {
            startTimer.setTitle("START TIMER", for: .normal)
            timer.invalidate()
            backButton.isEnabled = true
            playSound(soundName: "Silence")
            repeatSound.isEnabled = false
            repeatSound.layer.borderColor = CGColor(gray: 0.3, alpha: 0.35)
            disableGuesses()
            disableBorder()
        }
    }
     
    func activateTimer() {
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
                (Timer) in
                
                if self.secondsPassed < self.totalTime {
                    
                    let percentageProgress = Float(self.secondsPassed) / Float(self.totalTime)
                    
                    self.progressBar.progress = Float(percentageProgress)
                    self.secondsPassed += 1
                    
                } else {
                    Timer.invalidate()
                    self.backButton.isEnabled = true
                    self.progressBar.progress = 1.0
                    self.startTimer.setTitle("START TIMER", for: .normal)
                    self.disableGuesses()
                    self.disableBorder()
                    self.UILabel.text = ""
                    self.UILabel.backgroundColor = UIColor(white: 1, alpha: 0)
                    self.Streak.backgroundColor = UIColor(white: 1, alpha: 0)
                    self.endGame()
                }
            }
        }
    
    @IBAction func backIsPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
 }
    
   

        
        

    

        
    
    
    
    
    
    
    
    

