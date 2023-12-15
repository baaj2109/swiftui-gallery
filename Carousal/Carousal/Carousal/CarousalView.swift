//
//  CarousalView.swift
//  Carousal
//
//  Created by kehwa weng on 2023/12/13.
//

import SwiftUI

struct CarousalView: View {
    
    var xDistance: Int = 150
    
    @State private var snappedItem = 0.0
    @State private var draggingItem = 1.0
    @State private var activeIndex: Int = 0
    
    var views: [CarousalCell] = [
        CarousalCell(id: 1, content: ZStack{
            ZStack{
                RoundedRectangle(cornerRadius: 19)
                    .fill(.red)
                Text("1")
                    .padding()
            }
            .frame(width: 200,height: 400)
        }),
        CarousalCell(id: 2, content: ZStack{
            ZStack{
                RoundedRectangle(cornerRadius: 19)
                    .fill(.red)
                Text("2")
                    .padding()
            }
            .frame(width: 200,height: 400)
        }),
        CarousalCell(id: 3, content: ZStack{
            ZStack{
                RoundedRectangle(cornerRadius: 19)
                    .fill(.red)
                Text("3")
                    .padding()
            }
            .frame(width: 200,height: 400)
        }),
    ]
    
    var body: some View {
        ZStack {
            ForEach(views, id: \.self.id) { view in
                view
                    .scaleEffect(1.0 - abs(distance(view.id)) * 0.2)
                    .opacity(1.0 - abs(distance(view.id)) * 0.3)
                    .offset(x: getOffset(view.id), y: 0)
                    .zIndex(1.0 - abs(distance(view.id)) * 0.1)
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        draggingItem = snappedItem + value.translation.width / 100
                    }
                    .onEnded { value in
                        withAnimation {
                            draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                            draggingItem = round(draggingItem).remainder(dividingBy: Double(views.count))
                            snappedItem = draggingItem
                            self.activeIndex = views.count + Int(draggingItem)
                            if self.activeIndex > views.count || Int(draggingItem) >= 0 {
                                self.activeIndex = Int(draggingItem)
                            }
                        }
                    }
            )
        }
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item).remainder(dividingBy: Double(views.count)))
    }
    
    func getOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(views.count) * distance(item)
        return sin(angle) * Double(xDistance)
    }
}

#Preview {
    CarousalView()
}
