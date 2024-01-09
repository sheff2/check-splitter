//
//  ContentView.swift
//  swiftUIapp
//
//  Created by Shaun Heffernan on 12/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = tipSelection * (checkAmount/100)
        let total = tipValue + checkAmount
        return(total/peopleCount)
        
    }
    
    let tipPercentages = [0,10,15,20,25]
    
    var body: some View{
        NavigationStack{
            Form{
                Section{
                    TextField("amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section("Tip percentage"){
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                
                }
                
                Section("each person pays"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("Check Splitter")
            .toolbar {
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
            
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
        
