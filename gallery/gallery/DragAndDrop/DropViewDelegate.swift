//
//  DropViewDelegate.swift
//  gallery
//
//  Created by kehwa weng on 2023/12/20.
//

import Foundation
import SwiftUI


struct DropViewDelegate : DropDelegate {
    
    let destionationItem: String
    @Binding var titles: [String]
    @Binding var draggedItem: String?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if let draggedItem {
            let fromIndex = titles.firstIndex(of: draggedItem)
            if let fromIndex {
                let toIndex = titles.firstIndex(of: destionationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation{
                        self.titles.move(
                            fromOffsets: IndexSet(integer: fromIndex),
                            toOffset: (toIndex > fromIndex) ? (toIndex + 1) : toIndex
                        )
                    }
                }
            }
        }
    }
}
