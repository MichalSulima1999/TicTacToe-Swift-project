//
//  Models.swift
//  TicTacToe
//
//  Created by Michael on 02/12/2023.
//

import SwiftUI

enum GameMode: String {
    case PVE = "PVE",
         PVP = "PVP"
}

enum Player: String {
    case human = "Player 🙋",
         human2 = "Player 2 🙋‍♂️",
         computer = "CPU 🤖"
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String{
        return player == .human ? "xmark" : "circle"
    }
}
