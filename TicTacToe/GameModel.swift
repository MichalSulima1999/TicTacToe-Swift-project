//
//  GameModel.swift
//  TicTacToe
//
//  Created by Michael on 02/12/2023.
//

import SwiftUI

struct GameModel {
    
    func processPVEPlayerMove(for position: Int,
                              moves: inout [Move?],
                              alertItem: inout AlertItem?,
                              isGameboardDisabled: inout Bool,
                              currentPlayer: inout Player) {
        if isSquareOccupied(in: moves, forIndex: position) {return}
        moves[position] = Move(player: .human, boardIndex: position)
        
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameboardDisabled = true
        currentPlayer = .computer
    }
    
    func processComputerMove(moves: inout [Move?],
                             alertItem: inout AlertItem?,
                             isGameboardDisabled: inout Bool,
                             currentPlayer: inout Player) {
        if currentPlayer == .computer {
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameboardDisabled = false
            currentPlayer = .human
            
            if checkWinCondition(for: .computer, in: moves){
                alertItem = AlertContext.computerWin
                return
            }
            
            if checkForDraw(in: moves){
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func processPVPPlayerMove(for position: Int,
                              moves: inout [Move?],
                              alertItem: inout AlertItem?,
                              currentPlayer: inout Player){
        if isSquareOccupied(in: moves, forIndex: position) {return}
        moves[position] = Move(player: currentPlayer, boardIndex: position)
        
        if checkWinCondition(for: currentPlayer, in: moves){
            alertItem = currentPlayer == .human ? AlertContext.human1Win : AlertContext.human2Win
            return
        }
        
        if checkForDraw(in: moves){
            alertItem = AlertContext.draw
            return
        }
        
        currentPlayer = currentPlayer == .human ? .human2 : .human
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    // AI Strategy:
    // If AI can win, then win
    // If AI can't win, then block
    // If AI can't block, then take middle square
    // If AI can't take middle square, take random available square
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int{
        
        // If AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        let computerMoves = moves.compactMap {$0}.filter{$0.player == .computer}
        let computerPositions = Set(computerMoves.map {$0.boardIndex})
        
        for pattern in winPatterns{
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable {return winPositions.first!}
            }
        }
        // If AI can't win, then block
        let humanMoves = moves.compactMap {$0}.filter{$0.player == .human}
        let humanPositions = Set(humanMoves.map {$0.boardIndex})
        
        for pattern in winPatterns{
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable {return winPositions.first!}
            }
        }
        // If AI can't block, then take middle square
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare){
            return centerSquare
        }
        
        // If AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition){
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        let playerMoves = moves.compactMap {$0}.filter{$0.player == player}
        let playerPositions = Set(playerMoves.map {$0.boardIndex})
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            return true
        }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap {$0}.count == 9
    }
}
