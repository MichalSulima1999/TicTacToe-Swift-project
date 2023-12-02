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
                Text("Mode: \(viewModel.gameMode.rawValue)").font(.title2)
                Text("Turn: \(viewModel.currentPlayer.rawValue)").font(.title3)
                Spacer()
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9){ i in
                        ZStack{
                            GameSquareView(proxy: geometry)
                            
                            PlayerIndicatorView(systemImageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture{
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
            GameModeButtonView(mode: .PVP, action: viewModel.changeMode)
        }.padding(25)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
