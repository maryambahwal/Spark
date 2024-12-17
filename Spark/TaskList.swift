import SwiftUI

// TaskList
struct TaskList: View {
    @Binding var tasks: [Task] // Receive tasks as a binding
    @State private var showAddTask = false // State to show the add task sheet

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    // Display list of tasks
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
                    
                    HStack{
                        Text("Complete your tasks, and watch me unleash my superpowers—just like you!")
                            .bold()
                            .frame(width: 255)
                            .padding(.leading, 5)
                        Image("sittingSpark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height / 7)
                    }
                }
            }
            .navigationBarTitle("My Tasks")
            .navigationBarItems(trailing: addButton) // Add button in the navigation bar
            .sheet(isPresented: $showAddTask) {
                TaskSheet(tasks: $tasks) // Pass the binding to add new tasks
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
