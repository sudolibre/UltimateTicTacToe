//
//  Board.swift
//  BetterTicTacToe
//
//  Created by Jonathon Day on 12/16/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

struct Board: CustomStringConvertible, Equatable {
    private(set) var places: [Place: Marker]
    private(set) var boardProgressStatus: BoardStatus = .inProgress
    private(set) var lastPlace: Place?
    
    var available: Bool {
        return boardProgressStatus == .inProgress
    }
    
    var availablePlaces: [Place] {
        var availablePlaces = [Place]()
        
        for i in places {
            if i.value.available == true {
                availablePlaces.append(i.key)
            }
        }
        return availablePlaces
    }
    
    var tl: String { return places[Place(row: .top, column: .left)]!.rawValue }
    var tm: String { return places[Place(row: .top, column: .middle)]!.rawValue }
    var tr: String { return places[Place(row: .top, column: .right)]!.rawValue }
    var ml: String { return places[Place(row: .middle, column: .left)]!.rawValue }
    var mm: String { return places[Place(row: .middle, column: .middle)]!.rawValue }
    var mr: String { return places[Place(row: .middle, column: .right)]!.rawValue }
    var bl: String { return places[Place(row: .bottom, column: .left)]!.rawValue }
    var bm: String { return places[Place(row: .bottom, column: .middle)]!.rawValue }
    var br: String { return places[Place(row: .bottom, column: .right)]!.rawValue }

    let nl = "\n"
    let seperator = "----------"
    
    let line0 = "CURRENT BOARD"
    var line1: String { return "\(tl) | \(tm) | \(tr)" }
    var line2: String { return "\(ml) | \(mm) | \(mr)" }
    var line3: String { return "\(bl) | \(bm) | \(br)" }

    var description: String {
            return nl + line0 + nl + line1 + nl + seperator + nl + line2 + nl + seperator + nl + line3 + nl

    }

    
    mutating func placeMarker(_ marker: Marker, onPlace place: Place ) {
        places[place] = marker
        checkForWinningCombinations(marker: marker)
        lastPlace = place
    }
    
    
    
    fileprivate mutating func checkForWinningCombinations(marker: Marker) {
        var topRows = 0
        var middleRows = 0
        var bottomRows = 0
        var leftColumns = 0
        var middleColumns = 0
        var rightColumns = 0
        var diagonalRight = 0
        var diagnoalLeft = 0
        
        for i in places where i.value == marker {
            switch i.key.column  {
            case .right:
                rightColumns += 1
            case .middle:
                middleColumns += 1
            case .left:
                leftColumns += 1
            }
            
            switch i.key.row {
            case .bottom:
                bottomRows += 1
            case .middle:
                middleRows += 1
            case .top:
                topRows += 1
            }
            
            switch (i.key.row, i.key.column) {
            case (.bottom, .left):
                diagnoalLeft += 1
            case (.middle,.middle):
                diagnoalLeft += 1
                diagonalRight += 1
            case (.top, .right):
                diagnoalLeft += 1
            case (.bottom, .right):
                diagonalRight += 1
            case (.top, .left):
                diagonalRight += 1
            default:
                continue
            }
        }
        
        if topRows == 3 || middleRows == 3 || bottomRows == 3 || leftColumns == 3 || middleColumns == 3 || rightColumns == 3 || diagnoalLeft == 3 || diagonalRight == 3 {
            boardProgressStatus = .winner(marker)
        }
        
        if availablePlaces.count == 0 {
            boardProgressStatus = .draw
        }
    }
    
    static func ==(lhs: Board, rhs: Board) -> Bool {
        return lhs.places == rhs.places
    }
    
    init() {
        self.places = [
            Place(row: .top, column: .left): .empty,
            Place(row: .top, column: .middle) : .empty,
            Place(row: .top, column: .right) : .empty,
            Place(row: .middle, column: .left) : .empty,
            Place(row: .middle, column: .middle) : .empty,
            Place(row: .middle, column: .right) : .empty,
            Place(row: .bottom, column: .left) : .empty,
            Place(row: .bottom, column: .middle) : .empty,
            Place(row: .bottom, column: .right) : .empty
        ]
    }
    
    init(savedState: [Place: Marker]) {
        places = savedState
        checkForWinningCombinations(marker: .x)
        checkForWinningCombinations(marker: .o)
    }

}

