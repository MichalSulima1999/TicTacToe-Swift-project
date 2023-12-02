//
//  GameModeButtonView.swift
//  TicTacToe
//
//  Created by Michael on 02/12/2023.
//

import SwiftUI

struct GameModeButtonView: View {
    let mode: GameMode
    let action: (GameMode) -> Void
    
    var body: some View {
        Button(action: {
            action(mode)
        }) {
            Text(mode.rawValue)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}
