//
//  Board.swift
//  BetterTicTacToe
//
//  Created by Jonathon Day on 12/16/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

struct Board: CustomStringConvertible {
    var playerX: Player
    var playerO: Player
    
    var currentState: [Place: Marker]
    
    var availablePlaces: [Place] {
        var availablePlaces = [Place]()
        
        for i in currentState {
            if i.value == .empty {
                availablePlaces.append(i.key)
            }
        }
        return availablePlaces
    }
    
    enum Marker: String {
        case x = "X", o = "O", empty = " "
    }
    
    enum Column: Int {
       case left = 1, middle = 2, right = 3
    }
    
    enum Row: Int {
        case top = 4, middle = 5, bottom = 6
    }
    
    var description: String {
        let tl = currentState[Place(row: .top, column: .left)]!.rawValue
        let tm = currentState[Place(row: .top, column: .middle)]!.rawValue
        let tr = currentState[Place(row: .top, column: .right)]!.rawValue
        let ml = currentState[Place(row: .middle, column: .left)]!.rawValue
        let mm = currentState[Place(row: .middle, column: .middle)]!.rawValue
        let mr = currentState[Place(row: .middle, column: .right)]!.rawValue
        let bl = currentState[Place(row: .bottom, column: .left)]!.rawValue
        let bm = currentState[Place(row: .bottom, column: .middle)]!.rawValue
        let br = currentState[Place(row: .bottom, column: .right)]!.rawValue
        
        let line1 = "\(tl) | \(tm) | \(tr)\n"
        let line2 = "----------\n"
        let line3 = "\(ml) | \(mm) | \(mr)\n"
        let line4 = "----------\n"
        let line5 = "\(bl) | \(bm) | \(br)\n"
        
        return line1 + line2 + line3 + line4 + line5

    }

    
    struct Place: Hashable {
        let row: Row
        let column: Column
        
        var description: String {
            var textDescription = ""
            switch self.row {
            case .top:
                textDescription += "Top "
            case .middle:
                textDescription += "Middle "
            case .bottom:
                textDescription += "Bottom "
            }
            
            switch self.column {
            case .left:
                textDescription += "Left"
            case .middle:
                textDescription += "Middle"
            case .right:
                textDescription += "Right"
            }
            
            return textDescription
        }
        
        var hashValue: Int {
            return row.hashValue ^ column.hashValue
        }
        
        static func ==(_ lhs: Place, _ rhs: Place) -> Bool {
            return lhs.row == rhs.row && lhs.column == rhs.column
        }
    }
    
    mutating func placeMarker(_ marker: Marker, onPlace place: Place ) {
        currentState[place] = marker
    }
    
    
    var gameWon: Bool {
        return hasWinningCombinations(marker: .x) || hasWinningCombinations(marker: .o)
    }
    
    func hasWinningCombinations(marker: Marker) -> Bool {
        var topRows = 0
        var middleRows = 0
        var bottomRows = 0
        var leftColumns = 0
        var middleColumns = 0
        var rightColumns = 0
        var diagonalRight = 0
        var diagnoalLeft = 0
        
        for i in currentState where i.value == marker {
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
        
        return topRows == 3 || middleRows == 3 || bottomRows == 3 || leftColumns == 3 || middleColumns == 3 || rightColumns == 3 || diagnoalLeft == 3 || diagonalRight == 3
    }
    
    init(playerX: Player, playerO: Player) {
        self.playerX = playerX
        self.playerO = playerO
        self.currentState = [
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

}

extension Board {
    
    init(savedState: [Place: Marker], players: [Player]) {
        currentState = savedState
        playerX = players[0]
        playerO = players[1]
    }
}

