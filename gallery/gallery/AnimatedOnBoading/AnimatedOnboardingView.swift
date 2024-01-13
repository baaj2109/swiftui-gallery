//
//  AnimatedOnboardingView.swift
//  gallery
//
//  Created by kehwa weng on 2024/1/13.
//

import SwiftUI

struct AnimatedOnboardingView: View {
    
    @State private var animateLeftPanel = false
    @State private var animateLeftPanelContents = false

    var body: some View {
        ZStack {
            LeftPanelView()
                .offset(x:animateLeftPanel ? (-UIScreen.main.bounds.width / 100) : -UIScreen.main.bounds.width)
                .animation(.interpolatingSpring(
                    mass: 1.0,
                    stiffness: 100,
                    damping: 10,
                    initialVelocity: 0
                ), value: animateLeftPanel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
        .onAppear{
            animateLeftPanel.toggle()
        }
    }
    
    @ViewBuilder
    private func LeftPanelView() -> some View {
        VStack {
            LeftPanelContents()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .padding(.trailing, 100)
    }
    
    @ViewBuilder
    private func LeftPanelContents() -> some View {
        VStack(alignment: .leading, spacing: 80) {
            Text("swiftui gallery")
                .font(.system(size: 30))
                .bold()
                .opacity(0.4)
                .offset(y:animateLeftPanelContents ? (-UIScreen.main.bounds.width / 100) : -UIScreen.main.bounds.width)
                .animation(.interpolatingSpring(
                    mass: 1.0,
                    stiffness: 30,
                    damping: 10,
                    initialVelocity: 0
                ), value: animateLeftPanelContents)


            Text("One stop for all app development")
                .font(.system(size: 40))
                .bold()
                .scaleEffect(animateLeftPanelContents ? CGSize(width: 1.0, height: 1.0) : CGSize(width: 0.0, height: 0.0))
                .animation(.interpolatingSpring(
                    mass: 1.0,
                    stiffness: 30,
                    damping: 10,
                    initialVelocity: 0
                ), value: animateLeftPanelContents)

            Button {
                //
            } label: {
                HStack {
                    Text("Get stated")
                        .foregroundStyle(.white)
                        .bold()
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 150, height: 50)
            .background(.black)
            .clipShape(Capsule())
            .offset(y:animateLeftPanelContents ? (UIScreen.main.bounds.width / 10) : UIScreen.main.bounds.width)
            .animation(.interpolatingSpring(
                mass: 1.0,
                stiffness: 30,
                damping: 10,
                initialVelocity: 0
            ), value: animateLeftPanelContents)

        }
        .padding()
        .onAppear{
            animateLeftPanelContents.toggle()
        }
    }
}

#Preview {
    AnimatedOnboardingView()
}
