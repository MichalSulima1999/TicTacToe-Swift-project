//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Michael on 02/12/2023.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    @Published var gameMode: GameMode = .PVE
    @Published var currentPlayer: Player = .human
    @Published private var model: GameModel = GameModel()
    
    var playerScore: Int {
        model.playerScore
    }
    
    var opponentScore: Int {
        model.opponentScore
    }
    
    var wonPattern: Set<Int> {
        model.wonPattern
    }
    
    func processPlayerMove(for position: Int) {
        if gameMode == .PVE {
            model.processPVEPlayerMove(for: position,
                                       moves: &moves,
                                       alertItem: &alertItem,
                                       isGameboardDisabled: &isGameboardDisabled,
                                       currentPlayer: &currentPlayer)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
                model.processComputerMove(moves: &moves,
                                          alertItem: &alertItem,
                                          isGameboardDisabled: &isGameboardDisabled,
                                          currentPlayer: &currentPlayer)
            }
        } else {
            model.processPVPPlayerMove(for: position, moves: &moves, alertItem: &alertItem, currentPlayer: &currentPlayer)
        }
    }
    
    func changeMode(mode: GameMode) {
        gameMode = mode
        model.resetPoints()
        resetGame()
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        currentPlayer = .human
        model.resetWonPattern()
        isGameboardDisabled = false
    }
}
