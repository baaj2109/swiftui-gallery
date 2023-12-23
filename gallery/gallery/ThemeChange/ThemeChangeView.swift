//
//  ThemeChangeView.swift
//  gallery
//
//  Created by kehwa weng on 2023/12/23.
//

import SwiftUI


struct ThemeChangeSettingView: View {
    @State private var changeTheme: Bool = false
        @Environment(\.colorScheme) private var scheme

    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault

    var body: some View {
        NavigationStack {
            List{
                Section("Appearance") {
                    Button("Change THeme") {
                        changeTheme.toggle()
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(userTheme.colorShceme)
        .sheet(isPresented: $changeTheme, content: {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
    }
}

struct ThemeChangeView: View {
//    @Environment(\.colorScheme) private var scheme
    var scheme: ColorScheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    /// for sliding effect
    @Namespace private var animation
    // view properties
    @State private var circleOffset: CGSize = .zero
    init (scheme: ColorScheme) {
        self.scheme = scheme
        let isDark = scheme == .dark
        self._circleOffset = .init(initialValue: CGSize(width: isDark ? 30: 150, height: isDark ? -25: -150))
    }
    var body: some View {
        VStackLayout(spacing: 15){
            Circle()
                .fill(userTheme.color(scheme).gradient)
                .frame(width: 150, height: 150)
                .mask {
                    // inverted mask
                        Rectangle()
                        .overlay {
                            Circle()
                                .offset(circleOffset)
                                .blendMode(.destinationOut)
                        }
                }
            
            Text("Choose a style")
                .font(.title2)
                .bold()
                .padding(.top,25)
            
            Text("Pop or subtle, day or night.\nCustomize your interface.")
                .multilineTextAlignment(.center)
            
            /// custom segmented picker
            HStack(spacing: 0, content: {
                ForEach(Theme.allCases, id: \.rawValue) { theme in
                    Text(theme.rawValue)
                        .padding(.vertical, 10)
                        .frame(width: 100)
                        .background(
                            ZStack {
                                if userTheme == theme {
                                    Capsule()
                                        .fill(Color("ThemeBG"))
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                }
                            }
                                .animation(.snappy, value: userTheme)
                        )
                        .contentShape(.rect)
                        .onTapGesture {
                            userTheme = theme
                        }
                }
            })
            .padding(3)
            .background(.primary.opacity(0.06), in: .capsule)
            .padding(.top, 20 )
        }
        // max height = 410
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 410)
        .background(Color("ThemeBG"))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal, 15)
        .environment(\.colorScheme, scheme)
        .onChange(of: scheme, initial: false ) {_, newValue in
            let isDark = newValue == .dark
            withAnimation(.bouncy) {
                circleOffset = CGSize(width: isDark ? 30: 150, height: isDark ? -25: 150)
            }
        }
    }
}

#Preview {
    ThemeChangeSettingView()
}

enum Theme : String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    func color(_ scheme: ColorScheme) -> Color {
        switch self {
        case .systemDefault:
            return scheme ==  .dark ? Color("Moon") : Color("Sun")
        case .light:
            return Color("Sun")
        case .dark:
            return Color("Moon")
        }
    }
    var colorShceme: ColorScheme? {
        switch self {
            
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
