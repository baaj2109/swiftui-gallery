//
//  IconTransition.swift
//  gallery
//
//  Created by kehwa weng on 2024/1/13.
//

import SwiftUI

struct IconTransition: View {
    
    @State private var isRotation = false
    @State private var isHidden = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 15, content: {
                
                line()
                    .rotationEffect(.degrees(isRotation ? 48: 0),
                                    anchor: .leading)
                
                line()
                    .scaleEffect(isHidden ? 0: 1, anchor: isHidden ? .trailing : .leading)
                    .opacity(isHidden ? 0: 1)
                    
                line()
                    .rotationEffect(.degrees(isRotation ? -48: 0),
                                    anchor: .leading)
            })
            .onTapGesture {
                withAnimation (.interpolatingSpring(stiffness: 500, damping: 15)){
                    isRotation.toggle()
                    isHidden.toggle()
                }
            }
        }
    }
    
    
    @ViewBuilder
    func line() -> some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 65, height: 10)
            .foregroundStyle(.black)
    }
}

#Preview {
    IconTransition()
}
