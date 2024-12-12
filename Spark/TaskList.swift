//
//  Untitled.swift
//  ch4
//
//  Created by ohoud on 10/06/1446 AH.
//

import SwiftUI

struct TaskList: View {
    @State private var tasks: [Task] = [] // State to hold tasks
    @State private var showAddTask = false // State to show the add task sheet

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    // Set the frame height of the List to half the screen height
                    List {
                        ForEach(tasks) { task in
                            TaskView(task: task, toggleAction: {
                                if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                    tasks[index].isChecked.toggle()
                                }
                            })
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: geometry.size.height / 2) // Set to half the screen height
                    Image("sittingSpark")
                        .resizable()
                        .frame(width: 200, height: 230)
                                           .scaledToFit()
                                           .frame(height: geometry.size.height / 2)
                    
                }
            }
            .navigationBarTitle("My Tasks")
            .navigationBarItems(trailing: addButton) // Add button in the navigation bar
            .sheet(isPresented: $showAddTask) {
                TaskSheet(tasks: $tasks) // Pass the binding to ContentView
            }
        }
    }

    private var addButton: some View {
        Button(action: {
            showAddTask.toggle()
        }) {
            Image(systemName: "plus")
                .foregroundColor(.our)
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    TaskList()
}
