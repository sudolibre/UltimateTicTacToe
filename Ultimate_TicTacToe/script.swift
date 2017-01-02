//
//  Main.swift
//  Ultimate_TicTacToe
//
//  Created by Jonathon Day on 12/30/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

func mainLoop() {
    print("Hello and welcome to Tic-Tac-Toe.")
    var usersPlayingGame = true
    let metaBoard = setupMetaBoard()
    
    //get first board
    print(metaBoard.overviewDescription + "\n" + metaBoard.detailedDescription)
    let availablePlaces = metaBoard.availablePlaces
    let firstBoardPlace = availablePlaces[answerToQuestion("Player X please choose a board to start the game", withPossibleAnswers: availablePlaces.map { $0.description })]
    metaBoard.currentBoardPlace = firstBoardPlace
    
    while usersPlayingGame == true {
        // X plays a turn
        print(metaBoard.overviewDescription + "\n" + metaBoard.detailedDescription)
        print(metaBoard.places[metaBoard.currentBoardPlace!]!.description)
        let boardAfterplayerXTurn = playTurn(onBoard: metaBoard.places[metaBoard.currentBoardPlace!]!, marker: Marker.x)
        metaBoard.places[metaBoard.currentBoardPlace!]! = boardAfterplayerXTurn
        metaBoard.currentBoardPlace = boardAfterplayerXTurn.lastPlace
        
        //Check if X won the board and metaboard
        if checkForWin(onBoard: boardAfterplayerXTurn) {
            if checkForWin(onMetaBoard: metaBoard) {
                usersPlayingGame = false
                continue
            }
        }
        
        //O chooses a board if neccesary
        
        switch metaBoard.places[metaBoard.currentBoardPlace!]!.boardProgressStatus {
        case .winner, .draw:
            print(metaBoard.overviewDescription + "\n" + metaBoard.detailedDescription)
            let availablePlaces = metaBoard.availablePlaces
            let nextBoardPlace = availablePlaces[answerToQuestion("Player O please choose a new board to play next", withPossibleAnswers: availablePlaces.map { $0.description })]
            metaBoard.currentBoardPlace = nextBoardPlace
        case .inProgress:
            break
        }
        
        
        // O plays a turn
        print(metaBoard.overviewDescription + "\n" + metaBoard.detailedDescription)
        print(metaBoard.places[metaBoard.currentBoardPlace!]!.description)
        let boardAfterplayerOTurn = playTurn(onBoard: metaBoard.places[metaBoard.currentBoardPlace!]!, marker: Marker.o)
        metaBoard.places[metaBoard.currentBoardPlace!]! = boardAfterplayerOTurn
        metaBoard.currentBoardPlace = boardAfterplayerOTurn.lastPlace
        
        //Check if O won the board and metaboard
        
        if checkForWin(onBoard: boardAfterplayerXTurn) {
            if checkForWin(onMetaBoard: metaBoard) {
                usersPlayingGame = false
                continue
            }
        }
        
        // X chooses a board if neccesary
        switch metaBoard.places[metaBoard.currentBoardPlace!]!.boardProgressStatus {
        case .winner, .draw:
            print(metaBoard.overviewDescription + "\n" + metaBoard.detailedDescription)
            let availablePlaces = metaBoard.availablePlaces
            let nextBoardPlace = availablePlaces[answerToQuestion("Player X please choose a new board to play next", withPossibleAnswers: availablePlaces.map { $0.description })]
            metaBoard.currentBoardPlace = nextBoardPlace
        case .inProgress:
            break
        }
        
    }
}

func checkForWin(onBoard board: Board) -> Bool {
    switch board.boardProgressStatus {
    case .inProgress:
        return false
    case .draw:
        print(board.description)
        print("This board has been completed as a draw!")
        return true
    case .winner(let marker):
        print(board.description)
        print("Player \(marker) has won this board!")
        return true
    }
}

func checkForWin(onMetaBoard metaBoard: MetaBoard) -> Bool {
    switch metaBoard.boardProgressStatus {
    case .inProgress:
        return false
    case .draw:
        print(metaBoard.overviewDescription + "\n" + metaBoard.detailedDescription)
        print("Ultimate Tic-Tac-Toe has been completed in a draw!")
        return true
    case .winner(let marker):
        print(metaBoard.overviewDescription + "\n" + metaBoard.detailedDescription)
        print("Player \(marker) has won Ultimate Tic Tac Toe!")
        return true
    }
}


func playTurn(onBoard board: Board, marker: Marker) -> Board {
    var newBoard = board
    let availablePlaces = newBoard.availablePlaces
    let indexForMoveOfPlayer = answerToQuestion("Player \(marker.rawValue) please choose the next place you would like mark on the CURRENT BOARD", withPossibleAnswers: availablePlaces.map { $0.description })
    newBoard.placeMarker(marker, onPlace: availablePlaces[indexForMoveOfPlayer])
    print(board)
    return newBoard
}



func setupMetaBoard() -> MetaBoard {
    let playerXName = answerQuestion("What is the name of the first Player? The first player will place X's on the board")
    let playerOName = answerQuestion("What is the name of the second Player? The second player will place O's on the board")
    let game = MetaBoard(playerX: playerXName, playerO: playerOName)
    return game
}


func answerToQuestion(_ question: String, withPossibleAnswers possibleAnswers: [String]) -> Int {
    print(question)
    var intAnswer: Int?
    let selection = possibleAnswers.enumerated()
    for i in selection {
        print("\(i.offset) - \(i.element)")
    }
    
    while intAnswer == nil {
        let answer = readLine(strippingNewline: true)!
        if let answer = Int(answer) {
            if answer < possibleAnswers.count {
                intAnswer = answer
            } else {
                print("invalid selection. Please select a number between 0 and \(possibleAnswers.count - 1)")
            }
        } else {
            print("invalid selection. Please select a number between 0 and \(possibleAnswers.count - 1)")
        }
    }
    return intAnswer!
}

func answerQuestion(_ question: String) -> String {
    print(question)
    let answer = readLine(strippingNewline: true)!
    return answer
}
