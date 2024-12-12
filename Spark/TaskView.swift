import SwiftUI

struct TaskView: View {
    var task: Task
    var toggleAction: () -> Void
    @State private var isNavigating = false // State variable to control navigation

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.title)
                    .foregroundColor(.primary)

                HStack(spacing: 4) {
                    displayComponent(" \(task.duration)", icon: "clock", textColor: .our)
                    displayComponent(" \(task.priority)", icon: "", textColor: .primary)
                }
            }
            .padding(.vertical, 5)

            // Button that triggers navigation
            Button(action: {
                isNavigating = true // Trigger navigation
            }) {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.our)
                        .cornerRadius(50)
                }
                .padding(40)
            }
            .background(
                NavigationLink(destination: TaskTimeFrame(duration: task.toSeconds() ?? 0), isActive: $isNavigating) {
                    EmptyView() // Use an empty view as the link
                }
                .hidden() // Hide the navigation link
            )
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0)))
    }

    private func displayComponent(_ text: String, icon: String, textColor: Color) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(textColor)
            Text(text)
                .foregroundColor(textColor)
        }
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 11).fill(Color.grey1))
    }
}

#Preview {
    NavigationStack { // Ensure this is within a NavigationStack for navigation to work
        TaskView(task: Task(name: "Shower", duration: "15 min", priority: "⚡️ High", isChecked: false), toggleAction: {})
    }
}
