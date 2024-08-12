//
//  GameModel.swift
//  Ear Training
//
//  Created by Andrea Bottino on 12/08/2024.
//

import Foundation

protocol GameModelDelegate {
    func updateStreakLabel()
    func updateLabelConsecErrors()
    func showAnswerIsCorrect()
}

class GameModel {
    
    var delegate: GameModelDelegate?
    
    var survivalModeActivated = false
    
    var totalTime = 0
    var secondsPassed = 0
    let notes = ["C", "D", "E", "F", "G", "A", "B"]
    var randomNote = ""
    
    private var _streakCounter: Int = 0
    var streakCounter: Int {
        get {
            return _streakCounter
        }
        set {
            _streakCounter = newValue
            delegate?.updateStreakLabel()
        }
    }
    
    private var _consecError = 0
    var consecErrors: Int {
        get {
            return _consecError
        }
        set {
            _consecError = newValue
            delegate?.updateLabelConsecErrors()
        }
    }
    
    private var _totalCorrect = 0
    var totalCorrect: Int {
        get {
            return _totalCorrect
        }
        set {
            _totalCorrect = newValue
            delegate?.showAnswerIsCorrect()
        }
    }
    
    private var _totalErrors = 0
    var totalErrors: Int {
        get {
            return _totalErrors
        }
        set {
            _totalErrors = newValue
            if survivalModeActivated {
                secondsPassed += 2
            }
        }
    }
    
}
