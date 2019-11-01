//
//  AddExpenseItemView.swift
//  iExpense
//
//  Created by Saif on 31/10/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//

import SwiftUI

struct AddExpenseItemView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    static let types = ["Personal","Business"]
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Expense Name: ",text:$name)
                Picker("Select Type",selection: $type) {
                    ForEach(Self.types,id:\.self) {
                        Text($0)
                    }
                }
                TextField("Amount: ",text:$amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing:
                Button("Save") {
                    if let amount = Int(self.amount) {
                        let expense = ExpenseItem(name: self.name, type: self.type, amount: amount)
                        self.expenses.items.append(expense)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    else{
                        self.showingAlert.toggle()
                    }
                }
            )
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Oops"), message: Text("Please enter the correct amount"), dismissButton: .default(Text("Got it!")))
        }
    }
}
