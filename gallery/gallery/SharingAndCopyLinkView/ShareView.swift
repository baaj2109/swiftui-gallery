//
//  ShareView.swift
//  gallery
//
//  Created by kehwa weng on 2024/2/1.
//

import SwiftUI

struct ShareView: View {
    @Binding var showShareView: Bool
    @State var copylink = false
    var link = "http://www.tmp.com"
    var link2 = "http://www.tmp2.com"
    var body: some View {
        VStack {
            Button {
                //
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .background(.gray.opacity(0.15), in: Circle())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .tint(.black)
            Spacer()
            Group{
                Text("Invite your friend\nto discover the app")
                    .bold()
                    .font(.largeTitle)
                Text("Your moments stay yours alone. opt to share with family. ganing insight into their lives as well-sharing is optional.")
                    .frame(width: 300)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            CellView()
                .frame(width: 300)
            Spacer()
            HStack(spacing: 14) {
                Button {
                    //
                    UIPasteboard.general.string = link
                   
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            copylink.toggle()
                        }
                    }
                } label: {
                    VStack{
                        Image(systemName: "doc.on.doc")
                            .font(.title)
                        Text("Copy link")
                            .font(.custom("BradleyHandITCTT-Bold", size: 20))
                    }
                    .frame(width: 160, height: 140)
                    .background(.gray.opacity(0.15), in: RoundedRectangle(cornerRadius: 30))
                    
                }
                ShareLink(item: (URL(string: link) ?? URL(string: link2))!) {
                    VStack{
                        Image(systemName: "doc.on.doc")
                            .font(.title)
                        Text("Copy link")
                            .font(.custom("BradleyHandITCTT-Bold", size: 20))
                    }
                    .frame(width: 160, height: 140)
                    .background(.gray.opacity(0.15), in: RoundedRectangle(cornerRadius: 30))
                }
            }
            .tint(.primary)
            Spacer()
            Button {
                //
            } label: {
                Text("Maybe later")
                    .font(.system(size: 25))
                    .opacity(0.5)
            }
            .tint(.primary)

        }
        .overlay(alignment: .bottom) {
            Text("Link Copied")
                .bold()
                .font(.headline)
                .frame(minWidth: 150, minHeight: 50)
                .background(.white, in: RoundedRectangle(cornerRadius: 30))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y:0)
                .offset(y: copylink ? 0 : 100)
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    ShareView(showShareView: .constant(false))
}
