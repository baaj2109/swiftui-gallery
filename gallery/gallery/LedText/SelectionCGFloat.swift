//
//  SelectionCGFloat.swift
//  gallery
//
//  Created by kehwa weng on 2024/5/3.
//

import SwiftUI

struct SelectionCGFloat: View {
    var title: String
    var item: [dataModel]
    @Binding var selected: CGFloat
    var keyPathToProperty: KeyPath<dataModel, CGFloat>
    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            Text(title)
                .bold()
            HStack(spacing: 20){
                ForEach(item) {item in
                    Text(item.item)
                        .frame(width: 40, height: 40)
                        .font(.custom(item.font, size: 18))
                        .background(Color(item.color), in: Circle())
                        .scaleEffect(selected == item[keyPath: keyPathToProperty] ? 0.7: 1)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(selected == item[keyPath: keyPathToProperty] ? .white: .clear)
                        }
                        .onTapGesture {
                            withAnimation {
                                selected = item[keyPath: keyPathToProperty]
                            }
                        }
                }
            }
        }
    }
}
