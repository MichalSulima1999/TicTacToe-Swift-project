//
//  PlayerIndicatorView.swift
//  TicTacToe
//
//  Created by Michael on 02/12/2023.
//

import SwiftUI

struct PlayerIndicatorView: View{
    var systemImageName: String
    var won: Bool
    @State private var isRotating = 0.0
    @State private var rotation3D = 0.0
    
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
            .rotation3DEffect(.degrees(rotation3D), axis: (0,1,0))
            .onChange(of: won) { w in
                let baseAnimation = Animation.linear(duration: 2)
                let repeated = baseAnimation.repeatForever(autoreverses: false)
                withAnimation(w ? repeated : Animation.default) {
                    rotation3D = w ? 360 : 0
                }
            }
    }
}
