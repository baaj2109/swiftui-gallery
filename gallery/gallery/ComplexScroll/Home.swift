//
//  Home.swift
//  gallery
//
//  Created by kehwa weng on 2023/12/21.
//

import SwiftUI

struct Home: View {
    
    @State private var allExpense:[Expense] = []
    @State private var activeCard: UUID?
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {// card view rect min y
                    Text("hello aas")
                        .font(.largeTitle)
                        .frame(height: 45) // card view rect min y
                        .bold()
                        .padding(.horizontal, 15)
                    GeometryReader{
                        let rect = $0.frame(in: .scrollView)
                        let minY = rect.minY.rounded()
                        //card view
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 0) {
                                ForEach(cards) { card in
                                    ZStack {
                                        if minY == 75.0 {
                                            /// not scrolled
                                            /// shwoing all card
                                            CardView(card)
                                        } else {
                                            /// scrolled
                                            /// showing only selected card
                                            if activeCard == card.id {
                                                CardView(card)
                                            } else {
                                                Rectangle()
                                                    .fill(.clear)
                                            }
                                        }
                                    }
//                                    CardView(card)
                                        .containerRelativeFrame(.horizontal)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollPosition(id: $activeCard)
                        .scrollTargetBehavior(.paging)
                        .scrollClipDisabled()
                        .scrollDisabled(minY !=  75.0)
                        .scrollIndicators(.hidden)
                    }
                    .frame(height: 125)
                }
                LazyVStack(spacing: 15) {
                    Menu{
                        
                    } label: {
                        HStack(spacing: 4) {
                            Text("filter by")
                            Image(systemName: "chevron.dwon")
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    ForEach(allExpense) {expense in
                            ExpenseCardView(expense )
                    }
                }
                .padding(15) // card view rect min y
                .mask {
                    Rectangle()
                        .visualEffect  { content, proxy in
                            content
                                .offset(y: backgoundLimitOffset(proxy))
                        }
                }
                .background {
                    GeometryReader {
                        let rect = $0.frame(in: .scrollView)
                        let minY = min(rect.minY - 125, 0)
                        let progress = max(0,(min(-minY / 25, 1)))
                        RoundedRectangle(cornerRadius: 30 * progress, style: .continuous)
                            .fill(scheme == .dark ? .black: .white)
                            .overlay(alignment: .top, content: {
                                Text("\(minY), \(progress)")
                            })
                        // limiting backgound scroll below the header
                            .visualEffect  { content, proxy in
                                content
                                    .offset(y: backgoundLimitOffset(proxy))
                            }
                    }
                }
            }
            .padding(.vertical, 15)
        }
        .scrollTargetBehavior(CustomScrollBehaviour())
        .scrollIndicators(.hidden)
        .onAppear {
//            allExpense = expenses.shuffled()
            if activeCard == nil {
                activeCard = cards.first?.id
            }
        }
        .onChange(of: activeCard) { oldValue, newValue in
            withAnimation(.snappy) {
                allExpense = expenses.shuffled()
            }
        }
    }
    // backgound limit offset
    func backgoundLimitOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        return minY < 100 ? -minY + 100: 0
    }
    
    
    @ViewBuilder
    func CardView(_ card : Card) -> some View {
        GeometryReader {
            let rect = $0.frame(in: .scrollView(axis: .vertical))
            let minY = rect.minY
            let topValue: CGFloat = 75.0
            let offset = min(minY - 75, 0)
            let  progress = max(0, min(-offset / topValue, 1))
            let scale : CGFloat = 1 + progress
            ZStack {
//                RoundedRectangle(cornerRadius: 25, style: .continuous)
                Rectangle()
                    .fill(card.bgColor)
                    .overlay(alignment: .leading) {
                        Circle()
                            .fill(card.bgColor)
                            .overlay{
                                Circle()
                                .fill(.white)
                                .opacity(0.2)
                            }
                            .scaleEffect(2, anchor: .topLeading)
                        .offset(x:-50, y:-40)
                    }
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .scaleEffect(scale, anchor: .bottom)
                VStack(alignment: .leading, spacing: 4, content: {
                    Spacer()
                    Text("Current Balance \(progress): \(offset)")
                        .font(.callout)
                    Text(card.balance)
                        .font(.title)
                        .bold()
                })
                .foregroundStyle(.white)
                .padding(15)
                .offset(y: progress * -25)
            }
            .offset(y:-offset)
            /// moving til top value
            .offset(y: progress * -topValue)
        }
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func ExpenseCardView(_ expense: Expense) -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.product)
                    .font(.callout)
                    .fontWeight(.semibold)
                Text(expense.spendType)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(expense.amountSpent)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 6)
    }
}

#Preview {
    Home()
}

/// custom scroll target berhaviour
/// aka scrolwillenddragging in uikit
struct CustomScrollBehaviour: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < 75 {
            target.rect = .zero
        }
    }
}

internal struct Card: Identifiable {
    var id = UUID.init()
    var bgColor: Color
    var balance: String
}
internal var cards: [Card] = [
    Card(bgColor: .red, balance: "$125"),
    Card(bgColor: .blue, balance: "$15"),
    Card(bgColor: .yellow, balance: "$12"),
    Card(bgColor: .purple, balance: "$1")
]
