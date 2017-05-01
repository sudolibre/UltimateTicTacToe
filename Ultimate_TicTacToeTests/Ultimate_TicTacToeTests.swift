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

let boardStateWonByO: [Place: Marker] = [
    Place(row: .top, column: .left): .o,
    Place(row: .top, column: .middle) : .x,
    Place(row: .top, column: .right) : .o,
    Place(row: .middle, column: .left) : .o,
    Place(row: .middle, column: .middle) : .empty,
    Place(row: .middle, column: .right) : .empty,
    Place(row: .bottom, column: .left) : .o,
    Place(row: .bottom, column: .middle) : .empty,
    Place(row: .bottom, column: .right) : .x,
]

let boardWonByO = Board<Marker>(savedState: boardStateWonByO)

let boardWonByX = Board<Marker>(savedState: boardStateWonByX)

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


let metaBoard = Board<Board<Marker>>(savedState: metaBoardState)



class Ultimate_TicTacToeTests: XCTestCase {
    func testUpdatePlaceSingleBoard() {
        var testBoard = boardWonByX
        testBoard.updatePlace(Place(row: .middle, column: .middle) , with: .o)
        let expected = testBoard.places[Place(row: .middle, column: .middle)]
        let result = Marker.o
        XCTAssertTrue(expected == result)
    }
    
    func testLastPlaySingleBoard() {
        var testBoard = boardWonByX
        testBoard.updatePlace(Place(row: .middle, column: .middle) , with: .o)
        let result = testBoard.lastPlay!
        let expected = (Place(row: .middle, column: .middle), Marker.o)
        XCTAssertTrue(expected == result)
    }
    
    func testAvailablePlacesSingleBoard() {
        var testBoard = boardWonByX
        testBoard.updatePlace(Place(row: .middle, column: .middle) , with: .o)
        let result = testBoard.availablePlaces
        let expected = [Place(row: .middle, column: .right), Place(row: .bottom, column: .middle)]
        XCTAssertTrue(expected == result)
    }
    
    func testOwnerXSingleBoard() {
        let testBoard = boardWonByX
        let result = testBoard.owner
        let expected = Marker.x
        XCTAssertTrue(expected == result)

    }
    
    func testOwnerNoneSingleBoard() {
        var testBoard = boardWonByX
        testBoard.updatePlace(Place(row: .bottom, column: .left), with: .empty)
        let result = testBoard.owner
        XCTAssertNil(result)
    }
    
    func testOwnerDrawSingleBoard() {
        var testBoard = boardWonByX
        testBoard.updatePlace(Place(row: .middle, column: .middle), with: .x)
        testBoard.updatePlace(Place(row: .middle, column: .right), with: .o)
        testBoard.updatePlace(Place(row: .bottom, column: .left), with: .o)
        testBoard.updatePlace(Place(row: .bottom, column: .middle), with: .x)
        let result = testBoard.owner
        let expected = Marker.empty
        XCTAssertTrue(expected == result)
    }
    
    func testOwnerOSingleBoard() {
        var testBoard = boardWonByX
        testBoard.updatePlace(Place(row: .middle, column: .middle), with: .o)
        testBoard.updatePlace(Place(row: .bottom, column: .left), with: .empty)
        testBoard.updatePlace(Place(row: .bottom, column: .middle), with: .o)
        let result = testBoard.owner
        let expected = Marker.o
        XCTAssertTrue(expected == result)
    }
    
    func testOwnerXMetaBoard() {
        var testBoard = metaBoard
        let testBoardWonByX = boardWonByX
        testBoard.updatePlace(Place(row: .middle, column: .middle), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .top, column: .middle), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .bottom, column: .middle), with: testBoardWonByX)
        let result = testBoard.owner
        let expected = Marker.x
        XCTAssertTrue(expected == result)
        
    }
    
    func testOwnerNoneMetaBoard() {
        var testBoard = metaBoard
        let testBoardWonByX = boardWonByX
        testBoard.updatePlace(Place(row: .middle, column: .middle), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .top, column: .middle), with: testBoardWonByX)
        let result = testBoard.owner
        XCTAssertNil(result)
        
    }
    
    func testOwnerDrawMetaBoard() {
        var testBoard = metaBoard
        let testBoardWonByX = boardWonByX
        let testBoardWonByO = boardWonByO
        //xox
        //oxo
        //oxo
        testBoard.updatePlace(Place(row: .top, column: .left), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .top, column: .middle), with: testBoardWonByO)
        testBoard.updatePlace(Place(row: .top, column: .right), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .middle, column: .left), with: testBoardWonByO)
        testBoard.updatePlace(Place(row: .middle, column: .middle), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .middle, column: .right), with: testBoardWonByO)
        testBoard.updatePlace(Place(row: .bottom, column: .left), with: testBoardWonByO)
        testBoard.updatePlace(Place(row: .bottom, column: .middle), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .bottom, column: .right), with: testBoardWonByO)
        let result = testBoard.owner
        let expected = Marker.empty
        XCTAssertTrue(expected == result)
    }
    
    func testOwnerOMetaBoard() {
        var testBoard = metaBoard
        let testBoardWonByX = boardWonByX
        let testBoardWonByO = boardWonByO
        //xox
        //oxo
        //oxo
        testBoard.updatePlace(Place(row: .top, column: .left), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .top, column: .middle), with: testBoardWonByO)
        testBoard.updatePlace(Place(row: .top, column: .right), with: testBoardWonByO)
        testBoard.updatePlace(Place(row: .middle, column: .left), with: testBoardWonByO)
        testBoard.updatePlace(Place(row: .middle, column: .middle), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .middle, column: .right), with: testBoardWonByO)
        testBoard.updatePlace(Place(row: .bottom, column: .left), with: testBoardWonByO)
        testBoard.updatePlace(Place(row: .bottom, column: .middle), with: testBoardWonByX)
        testBoard.updatePlace(Place(row: .bottom, column: .right), with: testBoardWonByO)
        let result = testBoard.owner
        let expected = Marker.o
        XCTAssertTrue(expected == result)
    }

    
    
    

    }
