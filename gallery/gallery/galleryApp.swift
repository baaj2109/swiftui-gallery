//
//  galleryApp.swift
//  gallery
//
//  Created by kehwa weng on 2023/12/18.
//

import SwiftUI

@main
struct galleryApp: App {
    @State var show = false
    var body: some Scene {
        WindowGroup {
            ContentView()
//            ZStack {
//                if show {
//                    ContentView()
//                } else {
//                    LaunchView()
//                }
//            }
//            .onAppear() {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                    withAnimation {
//                        show = true
//                    }
//                }
//            }
        }
    }
}
