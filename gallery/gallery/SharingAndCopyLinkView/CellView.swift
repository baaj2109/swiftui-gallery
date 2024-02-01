//
//  CellView.swift
//  gallery
//
//  Created by kehwa weng on 2024/2/1.
//

import SwiftUI

struct CellView: View {
    @State var show = false
    @State var lineWidth : CGFloat = 4
    var body: some View {
        ZStack {
//            Circle()
//                .frame(width: 250, height: 250)
//                .opacity(0.1)
            VStack {
                HStack{
                    Image(systemName: "car.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height:  60)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: lineWidth)
                        }
                        .offset(x: show ? 115: 300, y:show ?  -10: -100)
//                        .offset(x:115, y: -10)
                    Image(systemName: "car.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height:  60)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: lineWidth)
                        }
                        .offset(x: show ? -115: -300, y:show ?  -10: -100)
//                        .offset(x:-115, y: -10)
                }
                HStack{
                    Image(systemName: "car.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height:  60)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: lineWidth)
                        }
                        .offset(x: show ? 115: 300, y:show ?  10: 100)
//                        .offset(x: 115, y: 10)
                    Image(systemName: "car.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height:  60)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: lineWidth)
                        }
                        .offset(x: show ? -115: -300, y:show ?  10: 100)
//                        .offset(x: -115, y: 10)
                }
            }
            VStack{
                Image(systemName: "car.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height:  60)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: lineWidth)
                    }
                    .offset(y:show ?  -60: -300)
//                    .offset( y: -60)
                Image(systemName: "car.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height:  60)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: lineWidth)
                    }
                    .offset(y:show ?  60: 300)
//                    .offset( y: 60)
            }
            Image(systemName: "car.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height:  60)
                .overlay {
                    Circle()
                        .stroke(lineWidth: lineWidth)
                }
        }
        .rotationEffect(.degrees(show ? 0 : 100))
        .onAppear(){
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                show.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    CellView()
}
