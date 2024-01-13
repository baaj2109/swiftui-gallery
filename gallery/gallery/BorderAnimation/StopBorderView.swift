//
//  StopBorderView.swift
//  gallery
//
//  Created by kehwa weng on 2024/1/13.
//

import SwiftUI

struct StopBorderView: View {
    @State var cumulativeRotation: Double = 35
    @State var nextIncrementIndex = 0
    let cornerIncrements = [105, 70, 105, 70]
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 10)
                .frame(width: 290, height: 390)
                .foregroundStyle(.gray)
                .opacity(0.5)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 250, height: 250)
                .foregroundStyle(LinearGradient(
                    colors: [.clear,.red,.clear],
                    startPoint: .leading,
                    endPoint: .trailing)
                )
                .offset(y: 120)
                .rotationEffect(.degrees(cumulativeRotation))
                .mask {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 10)
                        .frame(width: 290, height: 390)
                }
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 290, height: 390)
                .foregroundStyle(.black.opacity(0.5))
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.linear(duration: 0.5)) {
                cumulativeRotation += Double(cornerIncrements[nextIncrementIndex])
            }
            if nextIncrementIndex == cornerIncrements.count - 1 {
                cumulativeRotation -= 350
                nextIncrementIndex = 0
            } else {
                nextIncrementIndex += 1
            }

        })
    }
}

#Preview {
    StopBorderView()
}
