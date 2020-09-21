//
//  ContentView.swift
//  BetterRest
//
//  Created by Veselin Stefanov on 16.09.20.
//  Copyright © 2020 Veselin Stefanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header: Text("When do you want to wake up?")){
                    
                    DatePicker("Pleaser enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")){
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake")){
                    
                    Picker("Daily cofee intake", selection: $coffeeAmount){
                        ForEach(1 ..< 21){
                            Text("\($0)")
                        }
                    }
                    .labelsHidden()
                }
                
                Section(header: Text("Recommended wake up time")){
                    
                    Text("\(recommendedWakeUpTime)").font(.largeTitle)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    private var recommendedWakeUpTime: String{
        
        let model = SleepCalculator()
        
        let componentsWakeUp = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hourWakeUp = (componentsWakeUp.hour ?? 0) * 60 * 60
        let minuteWakeUp = (componentsWakeUp.minute ?? 0) * 60
        
        do{
            let prediction = try model.prediction(wake: Double(hourWakeUp + minuteWakeUp), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        }
        catch{
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
