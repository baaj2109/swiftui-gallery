//
//  SettingView.swift
//  gallery
//
//  Created by kehwa weng on 2024/5/3.
//

import SwiftUI

struct SettingView: View {
//    @State var text = ""
//    @State var show = false
//    @State var fontselected = ""
    
    @Binding var show: Bool
    @Binding var text: String
    @Binding var FontSelected: String
    @Binding var BcolorSelected: String
    @Binding var TcolorSelected: String
    @Binding var TsizeSelected: CGFloat
    var fonts:[dataModel] = [
        dataModel(item:"Aa", font:"ChalkboardSE-Regular"),
        dataModel(item:"Ab", font:"Palatino-Roman"),
        dataModel(item:"Ac", font:"Futura-Medium"),
        dataModel(item:"Ad", font:"Copperplate"),
        dataModel(item:"Ae", font:"Optima-Regular"),
        dataModel(item:"Ae", font: "Papyrus")
    ]
    
    
    var Tcolor:[dataModel] = [
        dataModel(color: "tc"),
        dataModel(color: "tc2"),
        dataModel(color: "tc3"),
        dataModel(color: "tc4"),
        dataModel(color: "tc5"),
    ]
    
    var bcolor:[dataModel] = [
        dataModel(color: "bc"),
        dataModel(color: "bc2"),
        dataModel(color: "bc3"),
        dataModel(color: "bc4"),
        dataModel(color: "bc5"),
    ]
    
    
    var Tsize:[dataModel] = [
        dataModel(item: "100", size: 100),
        dataModel(item: "150", size: 150),
        dataModel(item: "200", size: 200)
    ]
    
    var colorMap = Color.createColorMap()
    
    var body: some View {
        VStack(alignment: .leading){
            SmallLed(text: $text, textsize: $TsizeSelected, Tcolor: $TcolorSelected, Bcolor: $BcolorSelected, font: $FontSelected /*, colorMap: colorMap*/)
            textView
            SelectionString(title: "Font", item: fonts, selected: $FontSelected, keyPathToProperty: \.font)
            SelectionString(title: "Text Color", item: Tcolor, /*colorMap: colorMap, */ selected: $TcolorSelected, keyPathToProperty: \.color)
            SelectionString(title: "BG Color", item: bcolor,/* colorMap: colorMap, */selected: $BcolorSelected, keyPathToProperty: \.color)
            SelectionCGFloat(title: "Text size", item: Tsize, selected: $TsizeSelected, keyPathToProperty: \.size)
        }
        .padding(.horizontal, 20)
    }
    
    var textView: some View {
        TextField("Your Message", text: $text)
            .padding(.leading)
            .padding(.trailing, 60)
            .frame(height: 60)
            .background(.gray, in: .rect(cornerRadius: 10))
            .foregroundStyle(.white)
            .overlay(alignment: .trailing) {
                Button {
                    withAnimation {
                        show.toggle()
                    }
                } label: {
                    Text("Play")
                        .bold()
                        .frame(width: 60, height: 55)
                        .background(.white, in: .rect(cornerRadius: 10))
                        .foregroundStyle(.black)
                }
            }
    }
}

//#Preview {
//    SettingView()
//}

extension Color {
    static func random() -> Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    static func createColorMap() -> [String: Color] {
        return [
            "tc":Color.random(),
            "tc2":Color.random(),
            "tc3":Color.random(),
            "tc4":Color.random(),
            "tc5":Color.random(),
            "bc":Color.random(),
            "bc2":Color.random(),
            "bc3":Color.random(),
            "bc4":Color.random(),
            "bc5":Color.random()
        ]
    }
}
