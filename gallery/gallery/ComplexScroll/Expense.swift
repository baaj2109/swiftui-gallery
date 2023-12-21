//
//  Expense.swift
//  gallery
//
//  Created by kehwa weng on 2023/12/21.
//

import Foundation
struct Expense: Identifiable{
    var id: UUID = UUID()
    var amountSpent: String
    var product: String
    var spendType: String
}

var expenses: [Expense] = [
    Expense (amountSpent:
                "$128", product: "Amazon Purchase" , spendType: "Groceries"),
    Expense (amountSpent:
                "$10", product: "Youtube Premium", spendType: "Streaming"),
    Expense (amountSpent:
                "$10", product: "Dribbble", spendType: "Membership"),
    Expense (amountSpent:
                "$99", product:
                "Magic Keyboard", spendType: "Products"),
    Expense (amountSpent:
                "$9", product: "Patreon", spendType: "Membership"),
    Expense (amountSpent:
                "$100", product: "Instagram", spendType: "Ad Publish"),
    Expense (amountSpent:
                "$15", product: "Netflix", spendType: "Streaming"),
    Expense (amountSpent:
                "$348", product: "Photoshop", spendType: "Editing"),
    Expense (amountSpent:
                "$99", product:
                "Figma", spendType: "Pro Member"),
    Expense (amountSpent:
                "$89", product:
                "Magic Mouse", spendType: "Products"),
    Expense (amountSpent:
                "$1200", product: "Studio Display", spendType: "Products"),
    Expense (amountSpent:
                "$39", product: "Sketch Subscription", spendType: "Membership")
]
