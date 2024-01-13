//
//  LaunchView.swift
//  gallery
//
//  Created by kehwa weng on 2024/1/4.
//

import SwiftUI

struct LaunchView: View {
    @State var show = false
    let title = "GINUP"
//    var delayStep = 0.5
    var initialDelays = [0.0,0.04,0.12,0.18,0.28,0.35]
    var body: some View {
//        HStack {
//            ForEach(0..<title.count, id: \.self) {index in
//                Text(String(title[title.index(title.startIndex, offsetBy: index)]))
//                    .font(.system(size: 100))
//                    .offset(y: show ? -50: 0)
//                    .animation(.easeInOut(duration: 0.5).delay(delayStep * Double(index)) ,value: show)
//            }
//        }
//        .onAppear() {
//            show.toggle()
//        }
        ZStack {
            ZStack {
                AnimatedTitleView(title: title, color: Color.red, initialDelay: initialDelays[5], animationType: .spring(duration: 1))

                AnimatedTitleView(title: title, color: Color.green, initialDelay: initialDelays[4], animationType: .spring(duration: 1))

                AnimatedTitleView(title: title, color: Color.blue, initialDelay: initialDelays[3], animationType: .spring(duration: 1))

                AnimatedTitleView(title: title, color: Color.pink, initialDelay: initialDelays[2], animationType: .spring(duration: 1))

                AnimatedTitleView(title: title, color: Color.yellow, initialDelay: initialDelays[1], animationType: .spring(duration: 1))

            }
            AnimatedTitleView(title: title, color: Color.red, initialDelay: initialDelays[0], animationType: .spring(duration: 1))
        }
    }
}

#Preview {
    LaunchView()
}

struct AnimatedTitleView: View {
    let title: String
    let color: Color
    let initialDelay: Double
    let animationType: Animation
    @State var scall = false
    @State private var show = false
    private var delayStep = 0.1
    
    init(title: String, color: Color,
         initialDelay: Double, animationType: Animation) {
        self.title = title
        self.color = color
        self.initialDelay = initialDelay
        self.animationType = animationType
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<title.count, id: \.self) { index in
                Text(String(title[title.index(title.startIndex, offsetBy: index)]))
                    .font(.system(size: 80)) .bold()
                    .offset(y: show ? -30 : 30)
                    .opacity(show ? 1 : 0)
                    .animation (animationType.delay(Double(index) * delayStep + initialDelay),
                                value: show)
                    .foregroundStyle(color)
            }
        }
        .scaleEffect(scall ? 1 : 1.2)
        .onAppear() {
            show.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                withAnimation{
                    self.scall.toggle()
                }
            }
        }
    }
}
