//
//  SmallTypes.swift
//  Ultimate_TicTacToe
//
//  Created by Jonathon Day on 12/30/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

enum Marker: String {
    case x = "X", o = "O", empty = " "
    
    var available: Bool {
        return self == .empty
    }
}

enum Column: Int {
    case left = 1, middle = 2, right = 3
}

enum Row: Int {
    case top = 4, middle = 5, bottom = 6
}

enum BoardStatus {
    case winner(Marker), draw, inProgress
    
    static func ==(_ lhs: BoardStatus, _ rhs: BoardStatus) -> Bool {
        switch (lhs, rhs) {
        case (.winner(let x), .winner(let y)):
            return x == y
        case (.winner, _):
            return false
        case (.draw, .draw), (.inProgress, .inProgress):
            return true
        case (.draw, _), (.inProgress, _):
            return false
        }
    }
    
    var description: String {
        switch self {
        case .winner(let x):
            return x.rawValue
        case .draw:
            return "D"
        case .inProgress:
            return " "
        }
    }
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

