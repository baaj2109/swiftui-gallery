//
//  BorderAnimationView.swift
//  gallery
//
//  Created by kehwa weng on 2024/1/13.
//

import SwiftUI

struct BorderAnimationView: View {
    @State var startR: Double = 0
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 300, height: 400)
            .overlay {
                AngularGradient.init(
                    gradient: Gradient(colors: [.clear,.clear,.clear, .red]),
                    center: .center,
                    angle: .degrees(300)
                )
                .frame(width: 490,height: 490)
                .rotationEffect(.degrees(startR))
                .mask {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 6)
                        .frame(width: 297, height: 395)
                }
            }
            .onAppear(){
                withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                    startR = 360
                }
            }
    }
    
}

#Preview {
    BorderAnimationView()
}
