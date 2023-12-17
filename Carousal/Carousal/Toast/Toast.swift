//
//  Toast.swift
//  Carousal
//
//  Created by kehwa weng on 2023/12/17.
//

import SwiftUI

struct RootView<Content:View>: View {
    @ViewBuilder var content : Content
    @State private var overlayWindow: UIWindow?
    var body: some View {
        content.onAppear{
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, overlayWindow == nil {
                let window = PassThroughWindow(windowScene: windowScene)
                window.backgroundColor = .clear
                // view controller
                let rootController = UIHostingController(rootView: ToastGroup())
                rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
                rootController.view.backgroundColor = .clear
                window.rootViewController = rootController
                window.isHidden = false
                window.isUserInteractionEnabled = true
                window.tag = 1009
                overlayWindow = window
            }
        }
    }
}

fileprivate class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else {return nil }
        return rootViewController?.view == view ? nil : view
    }
}

@Observable
class Toast {
    static let shared = Toast()
    fileprivate var toasts: [ToastItem] = []
    func present(title: String, symbol: String? ,
                 tint: Color = .primary, isUserInteractionEnabled: Bool = true,
                 timing :ToastTime = .medium) {
        
        withAnimation(.snappy){
            toasts.append(.init( title: title,
                                 symbol: symbol, tint: tint,
                                 isUserInteractionEnabled: isUserInteractionEnabled,
                                 timing: timing))
        }
    }
}
struct ToastItem : Identifiable {
    let id : UUID = .init()
    var title: String
    var symbol: String?
    var tint: Color
    var isUserInteractionEnabled :Bool
    var timing: ToastTime = .medium
}

enum ToastTime: CGFloat {
    case short = 1.0
    case medium = 2.0
    case long = 3.5
}
fileprivate struct ToastGroup: View {
    var model = Toast.shared
    var body: some View {
        GeometryReader{
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            ZStack {
                
                //                Text("\(model.toasts.count)")
                //                    .offset(y:-100)
                
                //                Text("\(model.toasts.count)")
                ForEach(model.toasts) { toast in
                    ToastView(size: size, item: toast)
                        .offset(y: offsetY(toast))
                        .scaleEffect(scale(toast))
                        .zIndex(Double(model.toasts.firstIndex(where: {$0.id == toast.id}) ?? 0))
                    //                        .animation(.easeInOut) {view in
                    //                            view
                    //                                .offset(y: offsetY(toast))
                    //                        }
                }
            }
            .padding(.bottom, safeArea.top == .zero ? 15: 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom )
        }
    }
    func offsetY(_ item: ToastItem) -> CGFloat {
        let index = CGFloat(model.toasts.firstIndex(where: {$0.id == item.id}) ?? 0)
        let totalCount = CGFloat(model.toasts.count) - 1
        return (totalCount - index) >= 2 ? -20: ((totalCount - index) * -10)
    }
    
    func scale(_ item: ToastItem) -> CGFloat {
        let index = CGFloat(model.toasts.firstIndex(where: {$0.id == item.id}) ?? 0)
        let totalCount = CGFloat(model.toasts.count) - 1
        return 1.0 - ((totalCount - index) >= 2 ? 0.2: ((totalCount - index) * 0.1))
    }
}


fileprivate struct ToastView: View {
    var size: CGSize
    var item: ToastItem
    //view properties
//    @State private var animateIn: Bool = false
//    @State private var animateOut: Bool = false
    @State private var delayTask: DispatchWorkItem?
    
    var body: some View {
        HStack(spacing: 0) {
            if let symbol = item.symbol {
                Image(systemName: symbol)
                    .font(.title3)
                    .padding(.trailing, 10)
            }
            //            Text("\(Toast.shared.toasts.count)")
            Text(item.title)
                .lineLimit(1)
        }
        .foregroundStyle(item.tint)
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(
            .background
                .shadow(.drop(color: .primary.opacity(0.06), radius: 5,x: 5,y: 5))
                .shadow(.drop(color: .primary.opacity(0.06), radius: 5,x: -5,y: -5)),
            in: .capsule
        )
        .containerShape(.capsule)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded({ value in
                    guard item.isUserInteractionEnabled else {return }
                    let endY = value.translation.height
                    let velocityY = value.velocity.height
                    if (endY + velocityY) > 100 {
                        /// removing toast
                        removeToast(0.5)
                    }
                })
        )
//        .offset(y: animateIn ? 0: 150)
//        .offset(y: !animateOut ? 0: 150)
//        .task {
////            guard !animateIn else {return}
////            withAnimation(.snappy) {
////                animateIn = true
////            }
//            try? await Task.sleep(for: .seconds(item.timing.rawValue))
//            removeToast()
//        }
        .onAppear {
            guard delayTask == nil else {return}
            delayTask = .init(block: {
                removeToast()
            })
            if let delayTask {
                DispatchQueue.main.asyncAfter(deadline: .now() + item.timing.rawValue, execute: delayTask)
            }
        }
        // limiting size
        .frame(maxWidth: size.width * 0.7)
        .transition(.offset(y: 150))
    }
    func removeToast(_ duration: TimeInterval = 5) {
//        guard !animateOut else {return}
//        withAnimation(.snappy, completionCriteria: .logicallyComplete) {
//            animateOut = true
//        } completion: {
//            removeToastItem()
//        }
        withAnimation(.easeInOut(duration: duration)) {
            if let delayTask {
                delayTask.cancel()
            }
            Toast.shared.toasts.removeAll(where: {$0.id == item.id})
        }
    }
//    func removeToastItem() {
//        Toast.shared.toasts.removeAll(where: {$0.id == item.id})
//    }
}


struct ToastContentView: View {
    
    var body: some View {
        VStack {
            Button("press toast") {
                Toast.shared.present(
                    title: "hellow",
                    symbol: "globe",
                    isUserInteractionEnabled: true,
                    timing: .long
                )
            }
        }
    }
}

#Preview {
    RootView{
        ToastContentView()
    }
}
