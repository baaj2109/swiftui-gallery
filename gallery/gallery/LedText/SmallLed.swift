//
//  SmallLed.swift
//  gallery
//
//  Created by kehwa weng on 2024/5/3.
//

import SwiftUI

struct SmallLed: View {
    
    @Binding var text: String
    @Binding var textsize:CGFloat
    @Binding var Tcolor: String
    @Binding var Bcolor: String
    @Binding var font : String
//    var colorMap: [String: Color]
    
    var body: some View {
        ZStack{
            GeometryReader {geo in
                Image(.led)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 300)
                    .foregroundStyle(Color(Bcolor))
//                    .foregroundStyle(colorMap[Bcolor]!)
                
                Text(text).bold()
                    .font(.custom(font, size: textsize))
                    .foregroundStyle(Color(Tcolor))
//                    .foregroundStyle(colorMap[Tcolor]!)
                    .fixedSize()
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
                    .mask {
                        Image(.led)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: 300)
                            .foregroundStyle(.grid)
                    }
            }
            .frame(height: 310)
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    SmallLed()
//}
