//
//  MetaBoard.swift
//  Ultimate_TicTacToe
//
//  Created by Jonathon Day on 12/30/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class MetaBoard {
    private(set) var playerX: String
    private(set) var playerO: String
    
    //private(set)
    var places: [Place: Board]
    //private(set)
    var currentBoardPlace: Place?
    private(set) var boardProgressStatus: BoardStatus = .inProgress
    
    
    // if the next board is not in the list of available places let the user choose somehow
    
    //private
    func nextBoard() -> Board? {
        // if next board is nil then the user can choose
        //TODO: should last place in Board be optional?
        if availablePlaces.contains(places[currentBoardPlace!]!.lastPlace!) {
        currentBoardPlace = places[currentBoardPlace!]!.lastPlace!
        return places[currentBoardPlace!]!
        } else {
            return nil
        }

    }
    
    func updateBoard(atPlace place: Place, withBoard board: Board, for marker: Marker) {
        places[place] = board
        checkForWinningCombinations(marker: marker)
        //currentBoardPlace = nextBoard()

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
    
    var overviewDescription: String {
        //TODO: look into printing description of each board in larger board.
        let tl = places[Place(row: .top, column: .left)]!.boardProgressStatus.description
        let tm = places[Place(row: .top, column: .middle)]!.boardProgressStatus.description
        let tr = places[Place(row: .top, column: .right)]!.boardProgressStatus.description
        let ml = places[Place(row: .middle, column: .left)]!.boardProgressStatus.description
        let mm = places[Place(row: .middle, column: .middle)]!.boardProgressStatus.description
        let mr = places[Place(row: .middle, column: .right)]!.boardProgressStatus.description
        let bl = places[Place(row: .bottom, column: .left)]!.boardProgressStatus.description
        let bm = places[Place(row: .bottom, column: .middle)]!.boardProgressStatus.description
        let br = places[Place(row: .bottom, column: .right)]!.boardProgressStatus.description
        
        let line0 = "\n META BOARD Score Overview \n"
        let line1 = "\(tl) | \(tm) | \(tr)\n"
        let line2 = "----------\n"
        let line3 = "\(ml) | \(mm) | \(mr)\n"
        let line4 = "----------\n"
        let line5 = "\(bl) | \(bm) | \(br)\n"
        
        return line0 + line1 + line2 + line3 + line4 + line5
        
    }
    
    var detailedDescription: String {
        let tl1 = places[Place(row: .top, column: .left)]!.line1
        let tm1 = places[Place(row: .top, column: .middle)]!.line1
        let tr1 = places[Place(row: .top, column: .right)]!.line1
        let tl2 = places[Place(row: .top, column: .left)]!.line2
        let tm2 = places[Place(row: .top, column: .middle)]!.line2
        let tr2 = places[Place(row: .top, column: .right)]!.line2
        let tl3 = places[Place(row: .top, column: .left)]!.line3
        let tm3 = places[Place(row: .top, column: .middle)]!.line3
        let tr3 = places[Place(row: .top, column: .right)]!.line3
        
        let ml1 = places[Place(row: .middle, column: .left)]!.line1
        let mm1 = places[Place(row: .middle, column: .middle)]!.line1
        let mr1 = places[Place(row: .middle, column: .right)]!.line1
        let ml2 = places[Place(row: .middle, column: .left)]!.line2
        let mm2 = places[Place(row: .middle, column: .middle)]!.line2
        let mr2 = places[Place(row: .middle, column: .right)]!.line2
        let ml3 = places[Place(row: .middle, column: .left)]!.line3
        let mm3 = places[Place(row: .middle, column: .middle)]!.line3
        let mr3 = places[Place(row: .middle, column: .right)]!.line3

        let bl1 = places[Place(row: .bottom, column: .left)]!.line1
        let bm1 = places[Place(row: .bottom, column: .middle)]!.line1
        let br1 = places[Place(row: .bottom, column: .right)]!.line1
        let bl2 = places[Place(row: .bottom, column: .left)]!.line2
        let bm2 = places[Place(row: .bottom, column: .middle)]!.line2
        let br2 = places[Place(row: .bottom, column: .right)]!.line2
        let bl3 = places[Place(row: .bottom, column: .left)]!.line3
        let bm3 = places[Place(row: .bottom, column: .middle)]!.line3
        let br3 = places[Place(row: .bottom, column: .right)]!.line3

        
        let separator = "\n_________________________________________\n-----------------------------------------\n"
        let miniSeparator = "\n---------- ||  ---------- ||  ----------\n"
        let nl = "\n"
        
        let line0 = "\n META BOARD Detailed \n"
        
        let line1 = "\(tl1)  ||  \(tm1)  ||  \(tr1)"
        let line2 = "\(tl2)  ||  \(tm2)  ||  \(tr2)"
        let line3 = "\(tl3)  ||  \(tm3)  ||  \(tr3)"

        let line4 = "\(ml1)  ||  \(mm1)  ||  \(mr1)"
        let line5 = "\(ml2)  ||  \(mm2)  ||  \(mr2)"
        let line6 = "\(ml3)  ||  \(mm3)  ||  \(mr3)"

        let line7 = "\(bl1)  ||  \(bm1)  ||  \(br1)"
        let line8 = "\(bl2)  ||  \(bm2)  ||  \(br2)"
        let line9 = "\(bl3)  ||  \(bm3)  ||  \(br3)"
        
        return line0 + nl + line1 + miniSeparator + line2 + miniSeparator + line3 + separator + line4 + miniSeparator + line5 + miniSeparator + line6 + separator + line7 + miniSeparator + line8 + miniSeparator + line9 + nl
    }
    
    func checkForWinningCombinations(marker: Marker) {
        var topRows = 0
        var middleRows = 0
        var bottomRows = 0
        var leftColumns = 0
        var middleColumns = 0
        var rightColumns = 0
        var diagonalRight = 0
        var diagnoalLeft = 0
        
        for i in places where i.value.boardProgressStatus == BoardStatus.winner(marker) {
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
    
    init(playerX: String, playerO: String) {
        self.playerX = playerX
        self.playerO = playerO
        self.places = [
            Place(row: .top, column: .left): Board(),
            Place(row: .top, column: .middle) : Board(),
            Place(row: .top, column: .right) : Board(),
            Place(row: .middle, column: .left) : Board(),
            Place(row: .middle, column: .middle) : Board(),
            Place(row: .middle, column: .right) : Board(),
            Place(row: .bottom, column: .left) : Board(),
            Place(row: .bottom, column: .middle) : Board(),
            Place(row: .bottom, column: .right) : Board()
        ]
    }
    
    
    init(savedState: [Place: Board], playerX: String, playerO: String) {
        self.playerX = playerX
        self.playerO = playerO
        places = savedState
    }
}

