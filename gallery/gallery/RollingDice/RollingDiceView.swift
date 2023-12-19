//
//  RollingDiceView.swift
//  Carousal
//
//  Created by kehwa weng on 2023/12/17.
//

import SwiftUI

struct RollingDiceView: View {
    @State var targetValue: Int = 000
    @State var offset : [CGFloat] = [0,0,0]
    
    var body: some View {
        VStack {
            HStack{
                SingleDigitView(offset: offset[0])
                SingleDigitView(offset: offset[1])
                SingleDigitView(offset: offset[2])
            }
            .frame(width: 200, height: 70)
            .overlay{
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 5)
                HStack(spacing: 63){
                    Rectangle().frame(width: 5, height: 65)
                    Rectangle().frame(width: 5, height: 65)
                }
            }
            Button {
                generateRandomNumber()
            } label: {
                Text("Generate Number")
            }
        }
        .padding()
    }
    

    
    func generateRandomNumber() {
        targetValue = Int.random(in: 0...999)
        setOffsets()
    }
    func setOffsets() {
        let digits = String(format:"%03d",targetValue).map{String($0)}
        withAnimation(.easeInOut(duration: 1.0)) {
            for (index, digit) in digits.enumerated() {
                offset[index] = CGFloat(Int(digit)!) * 70
            }
        }
    }
}

struct SingleDigitView: View {
    var offset: CGFloat = 0
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0) {
                ForEach(0..<10) {number in
                    Text("\(number)").font(.largeTitle).bold()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .offset(y: -offset)
        }
        .clipped()
    }
}


#Preview {
    RollingDiceView()
}
