//
//  LedHomeView.swift
//  gallery
//
//  Created by kehwa weng on 2024/5/3.
//

import SwiftUI

struct LedHomeView: View {
    
    @State var show = false
    @State var text = ""
    @State var FontSeleceted = "ChalkboardSE-Regular"
    @State var TcolorSelected = "tc"
    @State var BcolorSelected = "bc"
    @State var TsizeSelected: CGFloat = 100
    
    var body: some View {
        ZStack {
            Color(UIColor.darkGray).ignoresSafeArea()
            
            if !show {
                ScrollView {
                    SettingView(show: $show, text: $text, FontSelected: $FontSeleceted, BcolorSelected: $BcolorSelected, TcolorSelected: $TcolorSelected, TsizeSelected: $TsizeSelected)
                }
                .ignoresSafeArea()
            }else {
                LedContentView(text: $text, textsize: $TsizeSelected, Tcolor: $TcolorSelected, Bcolor: $BcolorSelected, font: $FontSeleceted)
            }
        }
    }
        
}

#Preview {
    LedHomeView()
}
