//
//  SelectionString.swift
//  gallery
//
//  Created by kehwa weng on 2024/5/3.
//

import SwiftUI

struct dataModel: Identifiable {

    var id = UUID()
    var item: String = ""
    var font: String = "ChakboardSE-Regular"
    var size: CGFloat = 100
    var color: String = "bc"
}

struct SelectionString: View {
//    var items: [dataModel] = [
//        dataModel(item: "100", size: 100),
//        dataModel(item: "150", size: 150),
//        dataModel(item: "200", size: 200)
//    ]
    var title: String
    var item: [dataModel]
//    var colorMap: [String: Color]? = nil

    @Binding var selected: String
    var keyPathToProperty: KeyPath<dataModel, String>
    
    
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
//                        .background(getColor(item.color), in:Circle())
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
//    func getColor(_ color: String ) -> Color {
//        if let cm = self.colorMap {
//            return cm[color]!
//        } else {
//            return Color(color)
//        }
//    }
}

//
//#Preview {
//    SelectionString()
//}
