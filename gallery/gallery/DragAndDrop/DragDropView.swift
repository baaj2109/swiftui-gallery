//
//  DragDropView.swift
//  gallery
//
//  Created by kehwa weng on 2023/12/20.
//

import SwiftUI

struct DragDropView: View {
    @State private var draggedTitle: String?
    @State private var titles: [String]  = [
        "aaaa","bbbb","ccc","Ddddd","fffff","eeeeee","ttttttt"
    ]
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                Spacer().frame(height: 40)
                ForEach(titles, id: \.self) { title in
                    DragDropCellView(title: title)
                    // drag and drop gesture
                        .onDrag({
                            self.draggedTitle = title
                            return NSItemProvider()
                        })
                        .onDrop(of: [.text],
                                delegate: DropViewDelegate(
                                    destionationItem: title,
                                    titles: $titles,
                                    draggedItem: $draggedTitle
                                )
                        )
                }
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
        .background(.black)
    }
}

#Preview {
    DragDropView()
}


struct DragDropCellView: View {
    var title:String
    var body: some View {
        HStack{
            Spacer()
            Text(title)
            Spacer()
        }
        .padding(.vertical, 40)
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
