//
//  ContentView.swift
//  TicTacToe
//
//  Created by Michael on 02/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Tic tac toe").font(.title)
                Text("Turn: \(viewModel.currentPlayer.rawValue)").font(.title3)
                HStack {
                    Text("Player\(viewModel.gameMode == .PVP ? " 1" : "") points: \(viewModel.playerScore)")
                    Spacer()
                    Text("\(viewModel.gameMode == .PVP ? "Player 2" : "Computer") points: \(viewModel.opponentScore)")
                }
                Spacer()
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9){ i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            
                            PlayerIndicatorView(systemImageName: viewModel.moves[i]?.indicator ?? "",
                                                won: viewModel.wonPattern.contains(i))
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(viewModel.isGameboardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: {viewModel.resetGame()}))
            })
        }
        HStack {
            GameModeButtonView(mode: .PVE, action: viewModel.changeMode)
            Spacer()
            Text("Mode: \(viewModel.gameMode.rawValue)").font(.title2)
            Spacer()
            GameModeButtonView(mode: .PVP, action: viewModel.changeMode)
        }.padding(25)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
