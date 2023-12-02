//
//  GameSquareView.swift
//  TicTacToe
//
//  Created by Michael on 02/12/2023.
//

import SwiftUI

struct GameSquareView: View {
    var proxy: GeometryProxy
    @State private var scale = 1.0
    
    var body: some View{
        Circle().foregroundColor(.blue).opacity(0.5)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
            .scaleEffect(scale)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 2)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                
                withAnimation(repeated) {
                    scale = 0.9
                }
            }
    }
}
