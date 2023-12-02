//
//  Alerts.swift
//  TicTacToe
//
//  Created by Michael on 02/12/2023.
//

import SwiftUI

struct AlertItem: Identifiable{
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext{
    static let humanWin = AlertItem(title: Text("You Win!"), message: Text("Congratulations! You won!"), buttonTitle: Text("Next game"))
    
    static let human1Win = AlertItem(title: Text("Player 1 Won!"), message: Text("Congratulations! Player 1 won!"), buttonTitle: Text("Next game"))
    
    static let human2Win = AlertItem(title: Text("Player 2 Won!"), message: Text("Congratulations! Player 2 won!"), buttonTitle: Text("Next game"))
    
    static let computerWin = AlertItem(title: Text("You Lose!"), message: Text("Better luck next time!"), buttonTitle: Text("Try again"))
    
    static let draw = AlertItem(title: Text("Draw!"), message: Text("What a battle!"), buttonTitle: Text("Try Again"))
}
