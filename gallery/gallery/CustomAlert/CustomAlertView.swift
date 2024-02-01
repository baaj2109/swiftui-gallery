//
//  CustomAlertView.swift
//  gallery
//
//  Created by kehwa weng on 2024/2/1.
//

import SwiftUI

struct CustomAlertView: View {
    @State var animateCircle = false
    @Binding var show : Bool
    
    var imageName = "checkmark.circle"
    var text = "Error"
    var gridentColor: Color = .red
    var circleAColor: Color = .green
    var details : String = "your message"
    var corner: CGFloat = 30
    
    var body: some View {
        VStack {
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: corner)
                    .frame(height: 300)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [.clear, .clear, gridentColor]),
                            startPoint: .top,
                            endPoint: .bottom))
                    .opacity(0.4)
                    .offset(y: show ? -30: 300)
                ZStack {
                    RoundedRectangle(cornerRadius: corner)
                        .foregroundStyle(.white)
                        .frame(height: 280)
                        .shadow(color: .black.opacity(0.01),
                                radius: 20, x: 0.0, y: 0.0)
                        .shadow(color: .black.opacity(0.1),
                                radius: 30, x: 0.0, y: 0.0)
                    VStack (spacing: 20){
                        ZStack{
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(circleAColor)
                                .frame(width: 105, height: 105)
                                .scaleEffect(animateCircle ? 1.3: 0.90)
                                .opacity(animateCircle ? 0: 1)
                                .animation(.easeInOut(duration: 2).delay(1).repeatForever(autoreverses: false), value: animateCircle)
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(circleAColor)
                                .frame(width: 105, height: 105)
                                .scaleEffect(animateCircle ? 1.3: 0.90)
                                .opacity(animateCircle ? 0: 1)
                                .animation(.easeInOut(duration: 2).delay(1.5).repeatForever(autoreverses: false), value: animateCircle)
                                .onAppear() {
                                    animateCircle.toggle()
                                }
                            Image(systemName: imageName)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        Text(text)
                            .bold()
                            .font(.system(size: 30))
                        Text(details)
                            .opacity(0.5)
                    }
                }
                .padding(.horizontal, 10)
                .offset(y: show ? -30 : 300)
            }
            .onChange(of: show) {oldValue, newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            show = false
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
//    CustomAlertView(show: .constant(true))
    HomeView()
}



private struct HomeView: View {
    @State var show = false
    @State var show2 = false
    @State var show3 = false
    var body: some View {
        ZStack {
            HStack {
                Button {
                    withAnimation {
                        show.toggle()
                    }
                } label: {
                    Text("Error ")
                }
            }
            CustomAlertView(show: $show, imageName: "checkmark.circle", text:"success", gridentColor: .green, circleAColor: .green, details: "this is success message")
        }
    }
    
}

