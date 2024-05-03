//
//  LedContentView.swift
//  gallery
//
//  Created by kehwa weng on 2024/5/3.
//

import SwiftUI

struct LedContentView: View {
    
    @Binding var text: String
    @Binding var textsize:CGFloat
    @Binding var Tcolor: String
    @Binding var Bcolor: String
    @Binding var font : String
    
//    @State var show = false
    @State var textWidth: CGFloat = 0
    @State var offset: CGFloat = 0
    
    var body: some View {
        ZStack{
            GeometryReader {geo in
                Image(.led)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .foregroundStyle(Color(Bcolor))
                Text(text)
                    .font(.custom(font, size: textsize))
                    .foregroundStyle(Color(Tcolor))
                    .fixedSize()
                    .background(GeometryReader{ textGeometry -> Color in
                        DispatchQueue.main.async{
                            self.textWidth = textGeometry.size.width
                        }
                        return Color.clear
                    })
                //                    .offset(x:show ? -500 : 1160)
                    .offset(x: offset)
                    .rotationEffect(.degrees(90))
                    .position(x: geo.size.width / 2)
                    .mask {
                        Image(.led)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .foregroundStyle(.grid)
                    }
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            offset = geo.size.height + textWidth / 2
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                                offset = -textWidth / 2
                            }
                        }
                    }
            }
            
            //            Text("\(self.textWidth)")
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    LedContentView()
//}
