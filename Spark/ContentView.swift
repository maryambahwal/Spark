//
//  ContentView.swift
//  Spark
//
//  Created by Maryam Bahwal on 09/06/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var showCancelView = false
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: TaskTimeFrame()) {
                    Text("Hello To Spark App")
                }
            }
            .navigationTitle("Hello To Spark App")
        }
    }
}

#Preview {
    ContentView()
}
