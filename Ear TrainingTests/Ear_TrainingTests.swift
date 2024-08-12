//
//  Ear_TrainingTests.swift
//  Ear TrainingTests
//
//  Created by Andrea Bottino on 12/08/2024.
//

import XCTest
@testable import Ear_Training

final class Ear_TrainingTests: XCTestCase {
    
    var sut: GameModel!
    
    override func setUpWithError() throws {
        sut = GameModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGameHasSevenNotes() {
        // GIVEN
        let sut = GameModel()
        
        // THEN
        XCTAssertEqual(sut.notes.count, 7)
    }
    
    func testCorrectGuessIncreasesCounters() {
        checkCountersForCorrectAnswer()
    }
    
    func checkCountersForCorrectAnswer() {
        // GIVEN
        sut.randomNote = "A"
        
        // WHEN
        sut.checkGuess(buttonTitle: "A") {
            print("correct test")
        }
        
        // THEN
        XCTAssertEqual(sut.streakCounter, 1)
        XCTAssertEqual(sut.totalCorrect, 1)
        XCTAssertEqual(sut.consecErrors, 0)
    }
    
    func testWrongAnswerIncreaseCounters() {
        checkCountersForWrongAnswer()
    }
    
    func checkCountersForWrongAnswer() {
        // GIVEN
        sut.randomNote = "A"
        sut.streakCounter = 2
        sut.consecErrors = 0
        sut.totalErrors = 0
        
        // WHEN
        sut.checkGuess(buttonTitle: "C") {
            print("wrong test")
        }
        
        // THEN
        XCTAssertEqual(sut.streakCounter, 0)
        XCTAssertEqual(sut.consecErrors, 1)
        XCTAssertEqual(sut.totalErrors, 1)
    }
}
