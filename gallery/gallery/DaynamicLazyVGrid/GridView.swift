//
//  GridView.swift
//  gallery
//
//  Created by kehwa weng on 2024/2/1.
//

import SwiftUI

struct GridView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var showDelectAction: Bool = false
    @State private var selectedSquare: Squares?
    @State private var showAddItemPopover: Bool = false
    @State private var newItemText: String = ""
    @State private var editingSquare: Squares?
    var body: some View {
        ZStack{
            Color.black
                .opacity(0.7)
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                    ForEach(squaresData) {item in
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(height: 200)
                                .foregroundStyle(.black)
                            Text(item.text)
                                .bold()
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            menuButtons(square: item)
                        }))
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .frame(height: 200)
                            .foregroundStyle(.black)
                       Image(systemName: "plus.circle")
                            .foregroundStyle(.white)
                            .font(.system(size: 60))
                            .onTapGesture {
                                showAddItemPopover = true
                            }
                        
                    }
                    .foregroundStyle(.black)
                    .animation(.easeInOut, value: showDelectAction)
                    .animation(.easeInOut, value: showAddItemPopover)
                }
            }
        }
        .alert("Are you sure", isPresented: $showDelectAction,
               presenting: selectedSquare) { item in
            Button("Delete", role: .destructive) {
                DeleteItem(item)
            }
            Button("Cancel", role: .cancel) {
                //
            }
        } message: { item in
            Text("This action cannot be undone!")
        }
        .alert("Add new Item", isPresented: $showAddItemPopover) {
            TextField("New Item", text: $newItemText)
                .foregroundStyle(.black)
            Button(editingSquare == nil ? "add" : "update") {
                addandEditItem()
            }
        } message: {
            Text("Enter the text for new item")
        }
    }
    
    func DeleteItem(_ item: Squares) {
        squaresData.removeAll{$0.id == item.id}
    }
    
    func addandEditItem() {
        if let editingItem = editingSquare,
           let index = squaresData.firstIndex(where: {$0.id == editingItem.id}){
            withAnimation {
                squaresData[index].text = newItemText
            }
            editingSquare = nil
        } else {
            let newItem = Squares(text: newItemText)
            withAnimation {
                squaresData.append(newItem)
            }
        }
        newItemText = ""
        showAddItemPopover = false
    }
    
    @ViewBuilder
    func menuButtons(square: Squares) -> some View {
        Button {
            withAnimation {
                editingSquare = square
                newItemText = square.text
                showAddItemPopover = true
            }
        } label: {
            buttonsBody(buttonTitle: "Edit", imageName: "slider.horizontal.2.gobackward")
        }
        Button {
            withAnimation {
                selectedSquare = square
                showDelectAction.toggle()
            }
        } label: {
            buttonsBody(buttonTitle: "Delete", imageName: "trash.circle")
        }
    }
    
    @ViewBuilder
    func buttonsBody(buttonTitle: String, imageName: String) -> some View {
        HStack {
            Text(buttonTitle)
            Image(systemName: imageName)
        }
    }
}

#Preview {
    GridView()
}

struct Squares: Identifiable, Hashable {
    var id = UUID()
    var text: String
}

var squaresData: [Squares] = [
    Squares(text: "One"),
    Squares(text: "Two"),
    Squares(text: "Three"),
    Squares(text: "Four")
]
