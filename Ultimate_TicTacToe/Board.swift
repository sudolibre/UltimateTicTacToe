//
//  Board.swift
//  BetterTicTacToe
//
//  Created by Jonathon Day on 12/16/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

struct Board<T: Ownable>: Ownable {
    var places: Dictionary<Place, T>
    // if owner is empty the game is a draw. if owner is nil it is still up for grabs.
    private(set) var lastPlay: (Place, T)?
    
    var availablePlaces: [Place] {
        return places.filter { $0.value.owner == nil }.map { $0.key }
    }
    
    mutating func updatePlace(_ place: Place, with value: T ) {
        places[place] = value
        lastPlay = (place, value)
    }
    
    var owner: Marker? {
        //TODO: major code duplication here
        var topRowsX = 0,
        topRowsO = 0,
        middleRowsX = 0,
        middleRowsO = 0,
        bottomRowsX = 0,
        bottomRowsO = 0,
        leftColumnsX = 0,
        leftColumnsO = 0,
        middleColumnsX = 0,
        middleColumnsO = 0,
        rightColumnsO = 0,
        rightColumnsX = 0,
        diagonalRightX = 0,
        diagonalRightO = 0,
        diagnoalLeftX = 0,
        diagnoalLeftO = 0
        
        for i in places {
            switch i.key.column  {
            case .right:
                if i.value.owner == .x { rightColumnsX += 1 }
                if i.value.owner == .o { rightColumnsO += 1 }
            case .middle:
                if i.value.owner == .x { middleColumnsX += 1 }
                if i.value.owner == .o { middleColumnsO += 1 }
            case .left:
                if i.value.owner == .x { leftColumnsX += 1 }
                if i.value.owner == .o { leftColumnsO += 1 }
            }
            
            switch i.key.row {
            case .bottom:
                if i.value.owner == .x { bottomRowsX += 1 }
                if i.value.owner == .o { bottomRowsO += 1 }
            case .middle:
                if i.value.owner == .x { middleRowsX += 1 }
                if i.value.owner == .o { middleRowsO += 1 }
            case .top:
                if i.value.owner == .x { topRowsX += 1 }
                if i.value.owner == .o { topRowsO += 1 }
            }
            
            switch (i.key.row, i.key.column) {
            case (.bottom, .left):
                if i.value.owner == .x { diagnoalLeftX += 1 }
                if i.value.owner == .o { diagnoalLeftO += 1 }
            case (.middle,.middle):
                if i.value.owner == .x { diagnoalLeftX += 1; diagonalRightX += 1 }
                if i.value.owner == .o { diagnoalLeftO += 1; diagonalRightO += 1 }
            case (.top, .right):
                if i.value.owner == .x { diagnoalLeftX += 1 }
                if i.value.owner == .o { diagnoalLeftO += 1 }
            case (.bottom, .right):
                if i.value.owner == .x { diagonalRightX += 1 }
                if i.value.owner == .o { diagonalRightO += 1 }
            case (.top, .left):
                if i.value.owner == .x { diagonalRightX += 1 }
                if i.value.owner == .o { diagonalRightO += 1 }
            default:
                continue
            }
        }
        
        if topRowsX == 3 || middleRowsX == 3 || bottomRowsX == 3 || leftColumnsX == 3 || middleColumnsX == 3 || rightColumnsX == 3 || diagonalRightX == 3 || diagnoalLeftX == 3 {
            return .x
        } else if topRowsO == 3 || middleRowsO == 3 || bottomRowsO == 3 || leftColumnsO == 3 || middleColumnsO == 3 || rightColumnsO == 3 || diagonalRightO == 3 || diagnoalLeftO == 3 {
            return .o
        } else if availablePlaces.count == 0 {
            return .empty
        } else {
            return nil
        }
    }

    
//    static func ==(lhs: Board, rhs: Board) -> Bool {
//        return lhs.places == rhs.places
//    }
    
    init() {
        let defaultPlaces: Dictionary<Place, T?> = [
        Place(row: .top, column: .left): nil,
        Place(row: .top, column: .middle) : nil,
        Place(row: .top, column: .right) : nil,
        Place(row: .middle, column: .left) : nil,
        Place(row: .middle, column: .middle) : nil,
        Place(row: .middle, column: .right) : nil,
        Place(row: .bottom, column: .left) : nil,
        Place(row: .bottom, column: .middle) : nil,
        Place(row: .bottom, column: .right) : nil
        ]
        
        self.places  = defaultPlaces
    }
    
    init(savedState: [Place: T]) {
        places = savedState
    }

}

