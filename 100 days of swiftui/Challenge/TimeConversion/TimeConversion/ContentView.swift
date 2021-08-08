//
//  ContentView.swift
//  TimeConversion
//
//  Created by Luis Genesius on 16/07/21.
//

import SwiftUI

enum Time {
    case second
    case minute
    case hour
    case day
    
    var timeValue: Int {
        switch self {
        case .second: return 60
        case .minute: return 60
        case .hour: return 24
        case .day: return 24
        }
    }
    
    var stringValue: String {
        switch self {
        case .second: return "Second"
        case .minute: return "Minute"
        case .hour: return "Hour"
        case .day: return "Day"
        }
    }
}

struct ContentView: View {
    let timeFormats: [Time] = [.second, .minute, .hour, .day]
    
    @State private var sourceTimeInput = ""
    @State private var sourceTimeFormat = 0
    
    @State private var endTimeFormat = 0
    
//    var endTimeResult: Int?
//
//    var endTimeOutput: String {
//        return endTimeResult == nil ? "No input yet" : String(endTimeResult!)
//    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Input Time Format")) {
                    
                    Picker("Input Time Format", selection: $sourceTimeFormat) {
                        ForEach(0 ..< timeFormats.count) {
                            Text("\(self.timeFormats[$0].stringValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Input the number", text: $sourceTimeInput)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Output Time Format")) {
                    Picker("Output Time Format", selection: $endTimeFormat) {
                        ForEach(0 ..< timeFormats.count) {
                            Text("\(self.timeFormats[$0].stringValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text(self.calculateEndTimeResult())
                }
                
            }
            .navigationBarTitle("Time Conversion")
        }
    }
    
    func calculateEndTimeResult() -> String {
        if sourceTimeInput == "" {
            return "No input yet"
        }
        
        if sourceTimeFormat == endTimeFormat {
            return sourceTimeInput
        }
        
        var endTimeResult = 0
        
        func calcInpFormMoreOutForm() -> Int {
            var tempCount = sourceTimeFormat
            var tempResult = Int(sourceTimeInput) ?? 0
            
            while tempCount != 0 {
                tempResult *= timeFormats[tempCount-1].timeValue
                
                tempCount -= 1
            }
            
            return tempResult
        }
        
        func calcInpFormLessOutForm() -> Int {
            var tempCount = sourceTimeFormat
            var tempResult = Int(sourceTimeInput) ?? 0
            
            while tempCount != endTimeFormat {
                tempResult /= timeFormats[tempCount].timeValue
                
                tempCount += 1
            }
            
            return tempResult
        }
        
        endTimeResult = sourceTimeFormat > endTimeFormat ? calcInpFormMoreOutForm() : calcInpFormLessOutForm()
        
        return String(endTimeResult)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
