//import SwiftUI
//
//struct TaskView: View {
//    var task: Task
//    var toggleAction: () -> Void
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(task.name)
//                    .font(.title)
//                    .foregroundColor(.primary)
//                
//                HStack(spacing: 4) {
//                    displayComponent("\(task.duration)", icon: "clock", textColor: .our)
//                        .padding(.trailing, 5)
//                    displayComponent("\(task.priority)", icon: "", textColor: .primary)
//                }
//            }
//            Spacer()
//            
//            // Navigation Link Button
//            NavigationLink(destination: TaskTimeFrame(duration: task.toSeconds() ?? 0, name: task.name)) {
//                Image(systemName: "play.fill")
//                    .foregroundColor(.white)
//                    .padding(20)
//                    .background(Color.our)
//                    .cornerRadius(50)
//            }
//            .buttonStyle(PlainButtonStyle())
//        }
//        .padding(.horizontal)
//        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0)))
//    }
//    
//    private func displayComponent(_ text: String, icon: String, textColor: Color) -> some View {
//        HStack(spacing: 4) {
//            if !icon.isEmpty {
//                Image(systemName: icon)
//                    .foregroundColor(textColor)
//            }
//            Text(text)
//                .foregroundColor(textColor)
//        }
//        .padding(5)
//        .background(RoundedRectangle(cornerRadius: 11).fill(Color.grey1))
//    }
//}
//
//#Preview {
//    NavigationStack {
//        TaskView(
//            task: Task(name: "Shower", duration: "15 min", priority: "⚡️ High", isChecked: false),
//            toggleAction: {}
//        )
//    }
//}


//New

//import SwiftUI
//
//struct TaskView: View {
//    var task: Task
//    var toggleAction: () -> Void
//    
//    @State private var navigateToTaskTimeFrame = false
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(task.name)
//                    .font(.title)
//                    .foregroundColor(.primary)
//                
//                HStack(spacing: 4) {
//                    displayComponent("\(task.duration)", icon: "clock", textColor: .our)
//                        .padding(.trailing, 5)
//                    displayComponent("\(task.priority)", icon: "", textColor: .primary)
//                }
//            }
//            Spacer()
//            
//            // Custom Navigation Button
//            Button(action: {
//                navigateToTaskTimeFrame = true
//            }) {
//                Image(systemName: "play.fill")
//                    .foregroundColor(.white)
//                    .padding(20)
//                    .background(Color.our)
//                    .cornerRadius(50)
//            }
//            .accessibilityLabel("Start Task: \(task.name)")
//        }
//        .padding(.horizontal)
//        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0)))
//        .navigationDestination(isPresented: $navigateToTaskTimeFrame) {
//            TaskTimeFrame(duration: task.toSeconds() ?? 0, name: task.name)
//        }
//    }
//    
//    private func displayComponent(_ text: String, icon: String, textColor: Color) -> some View {
//        HStack(spacing: 4) {
//            if !icon.isEmpty {
//                Image(systemName: icon)
//                    .foregroundColor(textColor)
//            }
//            Text(text)
//                .foregroundColor(textColor)
//        }
//        .padding(5)
//        .background(RoundedRectangle(cornerRadius: 11).fill(Color.grey1))
//    }
//}
//
//#Preview {
//    NavigationStack {
//        TaskView(
//            task: Task(name: "Shower", duration: "15 min", priority: "⚡️ High", isChecked: false),
//            toggleAction: {}
//        )
//    }
//}
import SwiftUI

// TaskView
struct TaskView: View {
    var task: Task
    var toggleAction: () -> Void
    @State private var isNavigating = false // State to trigger navigation

    var body: some View {
        HStack {
            // Task Information
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.title)
                    .foregroundColor(.primary)

                HStack(spacing: 4) {
                    displayComponent("\(task.duration)", icon: "clock", textColor: .our)
                        .padding(.trailing, 5)
                    displayComponent("\(task.priority)", icon: "", textColor: .primary)
                }
            }
            Spacer()

            // Custom Navigation Button
            Button(action: {
                isNavigating = true // Programmatically trigger navigation
            }) {
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.our)
                    .cornerRadius(50)
            }
            .background(
                NavigationLink(
                    destination: TaskTimeFrame(duration: task.toSeconds() ?? 0, name: task.name),
                    isActive: $isNavigating
                ) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0)))
    }

    // Helper to display duration and priority
    private func displayComponent(_ text: String, icon: String, textColor: Color) -> some View {
        HStack(spacing: 4) {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .foregroundColor(textColor)
            }
            Text(text)
                .foregroundColor(textColor)
        }
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 11).fill(Color.grey1))
    }
}

#Preview {
    NavigationStack {
        TaskView(
            task: Task(name: "Shower", duration: "15 min", priority: "⚡️ High", isChecked: false),
            toggleAction: {}
        )
    }
}
