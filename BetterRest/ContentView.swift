//
//  ContentView.swift
//  BetterRest
//
//  Created by Veselin Stefanov on 16.09.20.
//  Copyright © 2020 Veselin Stefanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    
    var body: some View {
        Form{
            DatePicker("Please enter a date", selection: $date, in: Date()...)
                .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
