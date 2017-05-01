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
        return places.filter { $0.value.owner == .empty || $0.value.owner == nil }.map { $0.key }
    }
    
    mutating func updatePlace(_ place: Place, with value: T ) {
        places[place] = value
        lastPlay = (place, value)
    }
    

    var owner: Marker? {
        let setForX = NSCountedSet()
        let setForO = NSCountedSet()
        
        for i in places {
            // check for instances of a diagonal win pattern
            switch (i.key.row, i.key.column) {
            case (.bottom, .left):
                if i.value.owner == .x { setForX.add("diagonalLeft") }
                if i.value.owner == .o { setForO.add("diagonalLeft") }
            case (.middle,.middle):
                if i.value.owner == .x { setForX.add("diagonalLeft"); setForX.add("diagonalRight")  }
                if i.value.owner == .o { setForO.add("diagonalLeft"); setForO.add("diagonalRight") }
            case (.top, .right):
                if i.value.owner == .x { setForX.add("diagonalLeft") }
                if i.value.owner == .o { setForO.add("diagonalLeft") }
            case (.bottom, .right):
                if i.value.owner == .x { setForX.add("diagonalRight") }
                if i.value.owner == .o { setForO.add("diagonalRight") }
            case (.top, .left):
                if i.value.owner == .x { setForX.add("diagonalRight") }
                if i.value.owner == .o { setForO.add("diagonalRight") }
            default:
                break
            }
            
            //add instances of a column or row win pattern
            switch i.value.owner {
            case .some(.x):
                setForX.addObjects(from: [i.key.column, i.key.row])
            case .some(.o):
                setForO.addObjects(from: [i.key.column, i.key.row])
            default:
                break
            }
        }
        
        //if a marker has 3 instances in a win pattern then they own this board
        let patternCountsForX = setForX.map { setForX.count(for: $0) }
        let bestPatternCountForX = patternCountsForX.max()
        let patternCountsForO = setForO.map { setForO.count(for: $0) }
        let bestPatternCountForO = patternCountsForO.max()
        
        if let count = bestPatternCountForX {
            if count == 3 {
                return .x
            }
        }
        
        if let count = bestPatternCountForO {
            if count == 3 {
                return .o
            }
        }

        if availablePlaces.count == 0 {
            return .empty
        }
        
        return nil
    }


    init() {
        self.places = [
            Place(row: .top, column: .left): T(),
            Place(row: .top, column: .middle) : T(),
            Place(row: .top, column: .right) : T(),
            Place(row: .middle, column: .left) : T(),
            Place(row: .middle, column: .middle) : T(),
            Place(row: .middle, column: .right) : T(),
            Place(row: .bottom, column: .left) : T(),
            Place(row: .bottom, column: .middle) : T(),
            Place(row: .bottom, column: .right) : T()
        ]
    }
    
    init(savedState: [Place: T]) {
        places = savedState
    }

}

