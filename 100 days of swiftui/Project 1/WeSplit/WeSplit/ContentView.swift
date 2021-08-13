//
//  ContentView.swift
//  WeSplit
//
//  Created by Luis Genesius on 11/07/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    
    // kalau pakai picker utk number of people maka:
    // @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        
        // kalau pakai picker utk number of people maka:
        // let peopleCount = Double(numberOfPeople + 2)
        
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // tanda $ berartikan this value should be its own binding property, which is a Binding, digunakan ketika mau nge read sekaligus nge write
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                    
                }
                
                Section(header:
                            Text("How much tip do you want to leave ?")
                            .blueTitleStyle()
                ) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header:
                            Text("Amount per person")
                            .blueTitleStyle()
                ) {
                    /*
                     You should find that because all the values that make up our total are marked with @State, changing any of them will cause the total to be recalculated automatically.
                     */
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header:
                            Text("Total Amount")
                            .conditionalTitleStyle(tipPercentage: tipPercentage)
                ) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
            
        }
    }
    
}

struct Title: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(color)
    }
}

extension View {
    func blueTitleStyle() -> some View {
        self.modifier(Title(color: .blue))
    }
    
    func conditionalTitleStyle(tipPercentage: Int) -> some View {
        self.modifier(tipPercentage == 4 ? Title(color: .red) : Title(color: .blue))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
