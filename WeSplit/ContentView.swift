//
//  ContentView.swift
//  WeSplit
//
//  Created by Prasanna Bhat on 27/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    // Index of People
    @State private var numberOfPeople = 0
    @State private var tipSelection: Int = 2
    @FocusState private var isAmountFocused: Bool
    
    let peopleRange: [Int] = Array(2..<10)
    let tipPercentageChoices = [0, 10, 15, 20, 25]
    
    private var currencyCode: String {
        Locale.current.currency?.identifier ?? "INR"
    }
    
    init() {
        tipSelection = tipPercentageChoices.count / 2
    }
    
    private var totalAmountPerPerson: Double {
        let tipAmount = ((Double(tipPercentageChoices[tipSelection])) / 100) * billAmount
        let totalAmount = billAmount + tipAmount
        return (Double(totalAmount)/Double(peopleRange[numberOfPeople]))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Bill Amount") {
                    TextField("Enter The Bill Amount", value: $billAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                }
                Section {
                    Picker("Number Of People", selection: $numberOfPeople) {
                        ForEach(0..<peopleRange.count, 
                                id: \.self) {
                            Text("\(peopleRange[$0])")
                        }
                    }
                }
                
                Section("Tip Percentage") {
                    Picker("Enter Tip Percentage", selection: $tipSelection) {
                        ForEach(0..<tipPercentageChoices.count,
                                id: \.self) {
                            Text("\(tipPercentageChoices[$0])")
                        }
                    }
                    .pickerStyle(.palette)
                }
                Section("Total Amount") {
                    Text(totalAmountPerPerson, format: .currency(code: currencyCode))
                }
            }
            .navigationTitle("WeSplit")
        }
        .toolbar {
            if isAmountFocused {
                Button("Done") {
                    // this makes the keyboard disappear as it's bound the focused state of the text field
                    isAmountFocused = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
