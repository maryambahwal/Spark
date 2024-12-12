import SwiftUI

struct TaskSheet: View {
    @Binding var tasks: [Task]
    @State private var duration: String = "15 min"
    @State private var date: String = "today"
    @State private var priority: String = "⚡️High"
    @State private var taskName: String = ""

    @Environment(\.presentationMode) var presentationMode // For dismissing the view

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    HStack {
                        Text("Task Name")
                        Divider().frame(width: 2, height: 30)
                        TextField("shower", text: $taskName)
                            .autocapitalization(.words)
                    }
                }

                    HStack {
                        Image(systemName: "clock")
                        Picker("Duration", selection: $duration) {
                            Text("15 min").tag("15 min")
                            Text("25 min").tag("25 min")
                            Text("30 min").tag("30 min")
                            Text("45 min").tag("45 min")
                            Text("60 min").tag("60 min")
                        }
                    }

                    HStack {
                        Image(systemName: "calendar")
                        Picker("Date", selection: $date) {
                            Text("today").tag("today")
                            Text("tomorrow").tag("tomorrow")
                        }
                    }

                    HStack {
                        Image(systemName: "flag")
                        Picker("Priority", selection: $priority) {
                            Text("⚡️ High").tag("High")
                            Text("💫 Mid").tag("💫 Mid")
                            Text("🌙 Low").tag("🌙 Low")
                        }
                    }
                
            }
            .navigationBarTitle("Add Task", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }

    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss() // Dismiss the view
        }
    }

    private var saveButton: some View {
        Button("Save") {
            guard !taskName.isEmpty else { return } // Ensure task name is not empty
            let newTask = Task(name: taskName, duration: duration, priority: priority, isChecked: false)
            tasks.append(newTask) // Add new task to the list
            print("Saved: \(taskName), Duration: \(duration), Priority: \(priority)")
            presentationMode.wrappedValue.dismiss() // Dismiss the view after saving
        }
        .disabled(taskName.isEmpty) // Disable if task name is empty
    }
}


