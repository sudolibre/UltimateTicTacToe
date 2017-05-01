//
//  SmallTypes.swift
//  Ultimate_TicTacToe
//
//  Created by Jonathon Day on 12/30/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

enum Marker: String, Ownable {
    case x = "X", o = "O", empty = " "
    
    var owner: Marker? {
        return self
    }
}

extension Marker {
    init() {
        self = .empty
    }
}

enum Column: Int {
    case left = 1, middle = 2, right = 3
}

enum Row: Int {
    case top = 4, middle = 5, bottom = 6
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

protocol Ownable {
    var owner: Marker? { get }
    init()
}

