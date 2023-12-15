//
//  Gesture.swift
//  Carousal
//
//  Created by kehwa weng on 2023/12/15.
//

import SwiftUI

struct Gesture: View {
    var body: some View {
        VStack{
            
        }
    }
}

#Preview {
    Gesture()
}

struct TapGestureViews: View {
    @State private var changeColor = Color.yellow
    var body: some View{
        VStack{
            let tapGesture = TapGesture().onEnded { _ in
                if self.changeColor == Color.yellow {
                    withAnimation{
                        self.changeColor = .gray
                    }
                } else if  self.changeColor == .gray {
                    withAnimation {
                        self.changeColor = .yellow
                    }
                }
            }
            Circle()
                .foregroundStyle(changeColor)
                .shadow(radius: 10)
                .gesture(tapGesture)
                .frame(width: 100)
        }
    }
}


struct LongTapGestureView: View {
    @State private var didLongPress: Bool = false
    @State private var scale: CGFloat = 1
    @State private var color = Color.gray
    var body: some View {
        VStack {
            Circle()
                .scale(scale)
                .frame(width: 300)
                .foregroundStyle(color)
                .gesture(LongPressGesture().onEnded({ _ in
                    if self.didLongPress == false{
                        withAnimation {
                            self.scale = 1.2
                            self.color = .white
                        }
                    } else if self.didLongPress == true{
                        withAnimation {
                            self.scale = 1
                            self.color = .gray
                        }
                    }
                    self.didLongPress.toggle()
                }))
        }
    }
}

struct DragGesturesView: View {
    @State private var drag: CGSize = .zero
    @State private var color = Color.yellow
    var body: some View{
        Circle()
            .frame(width: 300)
            .foregroundStyle(color)
            .gesture(DragGesture()
                    .onChanged({ value in
                        withAnimation {
                            self.drag = value.translation
                        }
                        
                    })
                    .onEnded({ _ in
                        withAnimation {
                            self.drag = .zero
                        }
                    })
            )
    }
}

struct RotationGestureView: View {
    @State var rotation: Angle = .zero
    @State var color = Color.yellow
    var body: some View{
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(color)
                .shadow(radius: 10)
                .rotationEffect(rotation)
                .frame(width: 100, height: 100)
                .gesture(
                    RotateGesture()
                        .onChanged({ value in
                            rotation = value.rotation
                        })
                )
        }
    }
}
