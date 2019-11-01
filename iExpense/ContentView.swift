//
//  ContentView.swift
//  iExpense
//
//  Created by Saif on 31/10/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpenseItemView = false
    @State var amountColor = Color(UIColor.lightGray)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        
                        Text("$\(item.amount)")
                            .foregroundColor(self.calculateColor(for: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle(Text("iExpense"))
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpenseItemView = true
                }, label: {
                    Image(systemName: "plus")
                })
            )
            .sheet(isPresented: $showingAddExpenseItemView) {
                    AddExpenseItemView(expenses: self.expenses)
            }
        }
    }
    
    func calculateColor(for Amount: Int) -> Color {
        if Amount < 10 {
            return Color.green
        }
        else if Amount < 100 {
            return Color.blue
        }
        else{
            return Color.red
        }
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets:offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
