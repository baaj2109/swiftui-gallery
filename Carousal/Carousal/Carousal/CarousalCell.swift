//
//  CarousalCell.swift
//  Carousal
//
//  Created by kehwa weng on 2023/12/14.
//

import SwiftUI

struct CarousalCell: View {
    
    let id : Int
    var content : any View
    
    var body: some View {
        ZStack{
            AnyView(content)
        }
    }
}

#Preview {
    CarousalCell(id: 0, content: Text("none"))
}
