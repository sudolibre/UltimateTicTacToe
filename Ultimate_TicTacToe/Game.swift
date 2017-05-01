//
//  Game.swift
//  Ultimate_TicTacToe
//
//  Created by Jonathon Day on 1/2/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

class Game {
    let playerXName: String
    let playerOName: String
    
    var metaBoard: Board<Board<Marker>>
    
    func nextBoard() -> Optional<Board<Marker>> {
        // if next board is nil then the user should choose
        if metaBoard.availablePlaces.contains((metaBoard.lastPlay?.1.lastPlay?.0)!) {
            return metaBoard.places[(metaBoard.lastPlay?.1.lastPlay?.0)!]!
        } else {
            return nil
        }
    }
    
    init(playerXName: String, playerOName: String) {
        self.playerOName = playerOName
        self.playerXName = playerXName
        metaBoard = Board<Board<Marker>>()
    }
    
}
