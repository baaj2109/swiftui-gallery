//
//  TipView.swift
//  Carousal
//
//  Created by kehwa weng on 2023/12/17.
//

import SwiftUI
import TipKit


/*
 .task {
    try? Tips.resetDatasstore()
    try? Tips.configure([
        .displayFrequency(.immediate)
        .datastoreLocation(.applicationDefault)
    ])
 
 */
struct TipView: View {
    private let favTip = FavoriteTip()
    var body: some View {
        ZStack {
            Color("Yellow")
            VStack{
                Image("img")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "heart")
                            .font(.system(size: 24))
                            .foregroundStyle(.red)
                            .padding()
                            .popoverTip(favTip , arrowEdge: .bottom)
                        
                    }
                    .padding(.vertical,60)
                    .padding(.horizontal, 10)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TipView()
}

// struct for tipview
struct FavoriteTip: Tip {
    var title : Text {
        Text("Save the photo as favorite")
    }
    var message : Text? {
        Text("Your favorite photo swill appear in the favorite folder")
    }
    var image: Image? {
        Image(systemName: "heart")
    }
}
