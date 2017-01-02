//
//  Ultimate_TicTacToeTests.swift
//  Ultimate_TicTacToeTests
//
//  Created by Jonathon Day on 12/30/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import XCTest
@testable import Ultimate_TicTacToe

let playerX = "Xavier"
let playerO = "Oscar"
let boardStateWonByX: [Place: Marker] = [
    Place(row: .top, column: .left): .x,
    Place(row: .top, column: .middle) : .o,
    Place(row: .top, column: .right) : .x,
    Place(row: .middle, column: .left) : .x,
    Place(row: .middle, column: .middle) : .empty,
    Place(row: .middle, column: .right) : .empty,
    Place(row: .bottom, column: .left) : .x,
    Place(row: .bottom, column: .middle) : .empty,
    Place(row: .bottom, column: .right) : .o,
]
let boardWonByX = Board(savedState: boardStateWonByX)

let metaBoardState = [
    Place(row: .top, column: .left): boardWonByX,
    Place(row: .top, column: .middle) : Board(),
    Place(row: .top, column: .right) : Board(),
    Place(row: .middle, column: .left) : Board(),
    Place(row: .middle, column: .middle) : Board(),
    Place(row: .middle, column: .right) : Board(),
    Place(row: .bottom, column: .left) : Board(),
    Place(row: .bottom, column: .middle) : Board(),
    Place(row: .bottom, column: .right) : Board()
]


let metaBoard = MetaBoard(savedState: metaBoardState, playerX: playerX, playerO: playerO)

class Ultimate_TicTacToeTests: XCTestCase {
    
    func testDescriptions() {
        let expectedBoard = "\nCURRENT BOARD\nX | O | X\n----------\nX |   |  \n----------\nX |   | O\n"
        let resultingBoard = boardWonByX.description
        let expectedMetaBoardDetailed = "\n META BOARD Detailed \n\nX | O | X  ||    |   |    ||    |   |  \n---------- ||  ---------- ||  ----------\nX |   |    ||    |   |    ||    |   |  \n---------- ||  ---------- ||  ----------\nX |   | O  ||    |   |    ||    |   |  \n_________________________________________\n-----------------------------------------\n  |   |    ||    |   |    ||    |   |  \n---------- ||  ---------- ||  ----------\n  |   |    ||    |   |    ||    |   |  \n---------- ||  ---------- ||  ----------\n  |   |    ||    |   |    ||    |   |  \n_________________________________________\n-----------------------------------------\n  |   |    ||    |   |    ||    |   |  \n---------- ||  ---------- ||  ----------\n  |   |    ||    |   |    ||    |   |  \n---------- ||  ---------- ||  ----------\n  |   |    ||    |   |    ||    |   |  \n"
        let resultingMetaBoardDetailed = metaBoard.detailedDescription
        let expectedMetaBoardOverview = "\n META BOARD Score Overview \nX |   |  \n----------\n  |   |  \n----------\n  |   |  \n"
        let resultingMetaBoardOverview = metaBoard.overviewDescription
        print(resultingMetaBoardDetailed)
        print(resultingMetaBoardOverview)
        XCTAssertEqual(resultingBoard, expectedBoard)
        XCTAssertEqual(expectedMetaBoardDetailed, expectedMetaBoardDetailed)
        XCTAssertEqual(expectedMetaBoardOverview, resultingMetaBoardOverview)
    }
    
    func testPlaceMarker() {
        var testBoard = boardWonByX
        testBoard.placeMarker(.o, onPlace: Place(row: .middle, column: .middle))
        let result = testBoard.places[Place(row: .middle, column: .middle)]
        let expected = Marker.o
        XCTAssertEqual(result, expected)
    }
    
//    func testNextBoard() {
//        var testMetaBoard = metaBoard
//        testMetaBoard.currentBoardPlace = Place(row: .middle, column: .middle)
//        let newBoard = testMetaBoard.places[testMetaBoard.currentBoardPlace!]!.placeMarker(.x, onPlace: Place(row: .top, column: .right))
//        testMetaBoard.places[currentBoardPlace] = newBoard
//        testMetaBoard.currentBoardPlace = newBoard.lastPlace
//        testMetaBoard.nextBoard()!.placeMarker(.o, onPlace: Place(row: .middle, column: .middle))
//        let result = testMetaBoard.nextBoard()
//        let expected = testMetaBoard.places[Place(row: .middle, column: .middle)]
//        XCTAssertEqual(result, expected)
//    }
    
    func testNextBoardIsAlreadyWon() {
        var testMetaBoard = metaBoard
        testMetaBoard.currentBoardPlace = Place(row: .middle, column: .middle)
        testMetaBoard.places[testMetaBoard.currentBoardPlace!]!.placeMarker(.x, onPlace: Place(row: .top, column: .left))
        let result = testMetaBoard.nextBoard()
        XCTAssertNil(result)
    }
    
    func testMarkerAvailable() {
        let x = Marker.x
        let o = Marker.o
        let empty = Marker.empty
        XCTAssertTrue(empty.available)
        XCTAssertTrue(!x.available)
        XCTAssertTrue(!o.available)

    }
}
