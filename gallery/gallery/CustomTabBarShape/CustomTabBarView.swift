//
//  CustomTabBarView.swift
//  gallery
//
//  Created by kehwa weng on 2024/2/7.
//

import SwiftUI

struct CustomTabBarView: View {
    @State var selectedTab : TabIcon = .home
    @State var xOffset = 0 * 70.0
    var body: some View {
        VStack {
            Spacer()
            HStack{
                ForEach(tabItems) { item in
                    Spacer()
                    Image(systemName: item.iconName)
                        .foregroundStyle(selectedTab == item.tab ? .orange: .gray)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = item.tab
                                xOffset = CGFloat(item.index * 70)
                            }
                        }
                    Spacer()
                    
                }
                .frame(width: 23)
            }
            .frame(width: 365, height: 70)
            .background(
                CustomShape(xAxis: xOffset + 12)
                    .clipShape(.rect(cornerRadius: 12))
            )
            .overlay(alignment: .topLeading) {
                Circle()
                    .frame(width: 10, height: 10)
                    .offset(x: 36)
                    .offset(x: xOffset)
            }
        }
    }
}

#Preview {
    CustomTabBarView()
}
