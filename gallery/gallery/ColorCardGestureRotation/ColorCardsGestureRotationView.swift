//
//  ColorCardsGestureRotationView.swift
//  Carousal
//
//  Created by kehwa weng on 2023/12/19.
//

import SwiftUI

struct colorModel : Identifiable {
    var id = UUID()
    var color: [Color]
}


struct ColorCardsGestureRotationView: View {
    var mColor: [colorModel] = [
        colorModel(color: [.white,.red,.green]),
        colorModel(color: [.yellow,.black,.blue]),
        colorModel(color: [.gray,.orange,.cyan]),
        colorModel(color: [.brown,.cyan,.clear]),
        colorModel(color: [.primary,.purple,.pink])
        
    ]
    @State var show = false
    @State var dragAmount = CGSize.zero
    @State var selecredColor: Color = .blue
    
    var body: some View {
        ZStack{
            
            ForEach(mColor.indices, id: \.self){item in
                VStack{
                    ForEach(mColor[item].color, id:\.self) {color in
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(color)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                withAnimation {
                                    selecredColor = color
                                }
                            }
                    }
                }
                .padding(5)
                .padding(.bottom,40)
                .background(.white, in: RoundedRectangle(cornerRadius: 15))
                .overlay(alignment: .bottom) {
                    Button {
                        //
                    } label: {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(selecredColor)
                    }
                    .offset(x: show ? 4: 0, y: -7)
                }
                .rotationEffect(.degrees(Double(show ? 23*item : 0) + limitedRotation(item: item)), anchor: .bottom)
                .offset(
                    x: CGFloat(show ? Int(-6.9) * item : 0) - limitedRotation(item: item) / 3.7,
                    y: CGFloat(show ? -6 * item : 0) - limitedRotation(item: item) / 4
                )
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.dragAmount = value.translation
                        })
                        .onEnded({ value in
                            withAnimation {
                                self.dragAmount = .zero
                                if value.translation.width > 50 && !show {
                                    show = true
                                } else if value.translation.width < 20 && show {
                                    show = false
                                }
                            }
                        })
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
    }

    
    func limitedRotation(item: Int)->Double {
        let dragFactor = 0.1
        _ = Double(mColor.count - 1) * dragAmount.width * dragFactor
        let maxRotation = 100.5
        let maAllowDragWidth = maxRotation / (Double(mColor.count - 1) * dragFactor)
        let limitedDragAmoung = min(dragAmount.width, maAllowDragWidth)
        return min(Double(item) * limitedDragAmoung*dragFactor, maxRotation)
    }
    
}

#Preview {
    ColorCardsGestureRotationView()
}
