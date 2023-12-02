//
//  PlayerIndicatorView.swift
//  TicTacToe
//
//  Created by Michael on 02/12/2023.
//

import SwiftUI

struct PlayerIndicatorView: View{
    var systemImageName: String
    @State private var isRotating = 0.0
    
    var body: some View{
        Image(systemName: systemImageName).resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
            .rotationEffect(.degrees(isRotating))
            .onChange(of: systemImageName) { nv in
                withAnimation(.linear(duration: 0.5).speed(0.7)) {
                    isRotating = 360.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isRotating = 0.0
                }
            }
    }
}
