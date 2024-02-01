//
//  ComplexSideMenuView.swift
//  gallery
//
//  Created by kehwa weng on 2024/2/1.
//

import SwiftUI

struct ComplexSideMenuView: View {
    @State var index = 0
    @State var showSideMenu = false
    
    var body: some View {
        ZStack {
            HStack{
                VStack(alignment: .leading, spacing: 12, content: {
                    SideMenu()
                })
                .padding(.top, 25)
                .padding(.horizontal, 20)
                Spacer(minLength: 0)
            }
            VStack{
                Header()
                Pages().shadow(radius: 20)
            }
            .background(.black)
            .clipShape(
                RoundedRectangle(cornerRadius: self.showSideMenu ? 30: 0)
            )
            .scaleEffect(self.showSideMenu ? 0.9 : 1)
            .offset(x: self.showSideMenu ? UIScreen.main.bounds.width / 2 : 0,
                         y: self.showSideMenu ? 15 : 0)
            .rotationEffect(.init(degrees: self.showSideMenu ? -5: 0))
        }
        .shadow(radius: 20)
        .ignoresSafeArea(edges: .bottom)
        .background(self.showSideMenu ? .white : .black)
    }
    
    @ViewBuilder
    private func Pages() -> some View{
        GeometryReader {_ in
            VStack {
                switch self.index {
                case 0:
                    HomePage()
                case 1:
                    Cart()
                case 2:
                    Favorites()
                default:
                    Orders()
                }
            }
        }
    }
    
    @ViewBuilder
    private func Header() -> some View {
        HStack(spacing: 15, content: {
            Button {
                withAnimation {
                    self.showSideMenu.toggle()
                }
            } label: {
                Image(systemName: self.showSideMenu ? "xmark": "line.horizontal.3")
                    .resizable()
                    .frame(width: self.showSideMenu ? 18 : 22, height: 18)
                    .foregroundStyle(.white)
            }
            Text(self.index == 0 ? "Home" :
                    (self.index == 1 ? "Cart" : (self.index == 2 ? "Favorites" : "Orders")))
                .font(.title)
                .foregroundStyle(.white)
            Spacer()
        })
        .padding()
    }
    
    @ViewBuilder
    private func SideMenu() -> some View {
        SideMenuHeader()
        SideMenuListButton(buttonText: "Catalouge", icon: "catalogue", index: 0)
        SideMenuListButton(buttonText: "Cart", icon: "cart", index: 1)
        SideMenuListButton(buttonText: "Favorites", icon: "favorite", index: 2)
        SideMenuListButton(buttonText: "Your orders", icon: "orders", index: 3)
        Divider()
            .frame(width: 150, height: 1)
            .background(.blue)
            .padding(.vertical, 30)
        LogoutButton()
        Spacer()
    }
    @ViewBuilder
    private func SideMenuListButton(buttonText: String,
                                    icon: String, index: Int) -> some View {
        Button {
            self.index = index
            withAnimation {
                self.showSideMenu.toggle()
            }
        } label: {
            HStack(spacing: 15, content: {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .colorMultiply(self.index == index ? .yellow : .black)
                Text(buttonText)
                    .bold(self.index == index)
                    .foregroundStyle(self.index == index ? .yellow : .black)
            })
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(self.index == index ? .black : .clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }

    }
    @ViewBuilder
    private func SideMenuHeader() -> some View {
        Image("profile")
            .resizable()
            .frame(width: 100, height: 100)
            .colorInvert()
        Text("Hey")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.black)
            .padding(.top, 10)
        Text("Catherine")
            .fontWeight(.bold)
            .font(.title)
            .foregroundStyle(.black)
    }
    @ViewBuilder
    private func LogoutButton() -> some View {
        Button {
            //
        } label: {
            HStack(spacing: 25, content: {
                Image("logout")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .colorMultiply(.black)
                Text("sign out")
                    .foregroundStyle(.black)
            })
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ComplexSideMenuView()
}


private struct HomePage: View {
    var body: some View {
        ZStack {
            VStack{
                HeroImage()
                ProductList()
            }
        }
        .background(.black)
    }
    @ViewBuilder
    private func HeroImage() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .frame(width: 400, height: 400)
                .foregroundStyle(.white)
                .opacity(0.5)
                .offset(CGSize(width: 100.0, height: 10.0))
                .overlay(alignment: .bottomTrailing, content: {
                    Button {
                        //
                    } label: {
                        HStack{
                            Spacer()
                            RoundedRectangle(cornerRadius: 35)
                                .frame(width: 80, height: 80)
                                .foregroundStyle(.white)
                                .overlay {
                                    Image(systemName: "cart")
                                        .resizable()
                                        .colorMultiply(.black)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                }
                        }
                    }
                    .offset(CGSize(width: -20.0, height: 50.0))
                })
            VStack(spacing: -40, content: {
                Image("message")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .offset(CGSize(width: 0.0, height: -30.0))
                VStack(alignment: .leading, content: {
                    Text("Bell local helmet")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                        .bold()
                    Text("Orange Cycle helmet")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                    Divider()
                })
                .padding(.horizontal, 30)
            })
        }
    }
    @ViewBuilder
    private func ProductList() -> some View {
        VStack {
            Product(productName: "Xiaomi Ninebot", productCaption: "Black scooter helmet", image: "helmet 2")
            Product(productName:"Unbranded Helmet", productCaption: "Urban cycling helmet", image: "helmet 1")
        }
        .padding(.top, 20)
        
    }
    @ViewBuilder
    private func Product(productName: String, productCaption: String, image: String) -> some View {
        Button {
            //
        } label: {
            HStack(alignment: .center, spacing: 30, content: {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 100, height: 130)
                    .foregroundStyle(.white.opacity(0.5))
                    .overlay(alignment: .center) {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 110, height: 110)
                    }
                VStack(alignment: .leading, content: {
                    Text(productName)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                        .bold()
                    Text(productCaption)
                        .font(.system(size: 15))
                        .foregroundStyle(.white)
                        .opacity(0.3)
                })
                Spacer()
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.leading, 20)
        }

    }
}


private struct Cart: View {
    var body: some View {
        VStack(alignment: .center, content: {
            Text("Cart")
                .fontWeight(.bold)
                .font(.title)
                .foregroundStyle(.white)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct Orders: View {
    var body: some View {
        VStack(alignment: .center, content: {
            Text("Orders")
                .fontWeight(.bold)
                .font(.title)
                .foregroundStyle(.white)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
private struct Favorites: View {
    var body: some View {
        VStack(alignment: .center, content: {
            Text("Favorites")
                .fontWeight(.bold)
                .font(.title)
                .foregroundStyle(.white)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
