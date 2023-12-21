//
//  DragV2View.swift
//  gallery
//
//  Created by kehwa weng on 2023/12/21.
//

import SwiftUI

struct DragV2View: View {
    @State var Icons = ["pencil.and.outline", "scribble.variable", "plus.magnifyingglass", "square.fill.on.square.fill", "triangle.fill", "rhombus.fill", "arrowshape.turn.up.left.fill"]
    @State var DragIcon:String?
    var body: some View {
        VStack {
            ForEach(Icons, id: \.self){ item in
                Image(systemName: item)
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.vertical)
                    .draggable(item) {
                        Image(systemName: item)
                            .foregroundColor(.white)
                            .font(.title2)
                            .onAppear() {
                                DragIcon = item
                            }
                    }
                    .dropDestination(for:String.self) { items, location in
                        return false
                    }   isTargeted: { isActive in
                        guard let draggedIcon = DragIcon, isActive, draggedIcon != item else {return}
                        let (source, destintion) = (Icons.firstIndex(of: draggedIcon), Icons.firstIndex(of: item))
                        if let srcIndex = source, let destIndex = destintion {
                            withAnimation(.spring()) {
                                Icons.move(fromOffsets: IndexSet(integer: srcIndex), toOffset: destIndex)
                            }
                        }
                    }
            }
        }
        .frame(width: 70)
        .background(.black,in: RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
    }
}

#Preview {
    DragV2View()
}
