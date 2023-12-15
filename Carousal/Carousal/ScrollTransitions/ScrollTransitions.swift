//
//  ScrollTransitions.swift
//  Carousal
//
//  Created by kehwa weng on 2023/12/15.
//

import SwiftUI

struct ScrollTransitions: View {
    let images = ["img1","img1","img1","img1","img1","img1","img1","img1","img1","img1","img1","img1"]
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
            ForEach(images, id: \.self) { item in
                Image(item).resizable().scaledToFill()
                    .frame(width: 185,height: 190)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            }
            .scrollTransition { image, phase in
                image
                    .scaleEffect(phase.isIdentity ? 1: 0.8)
                    .blur(radius: phase.isIdentity ? 0 : 4)
                    .rotation3DEffect(.degrees(phase.isIdentity ? 1 : 20), axis: (x: 30, y: 0, z: 30))
            }
        })
        .padding(.horizontal, 8)
    }
}

#Preview {
    ScrollTransitions()
}
