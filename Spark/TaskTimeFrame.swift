//
//  TaskTimeFrame.swift
//  Spark
//
//  Created by Maryam Bahwal on 09/06/1446 AH.
//

import SwiftUI
struct TaskTimeFrame: View {
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 1 // Start with fully filled circle
    var duration: TimeInterval = 3 // Task duration in seconds
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //---------------------------------------------------------------------------
    @State private var remainingTime: TimeInterval = 3 // Time remaining
    @State private var isTimeUp: Bool = false // Flag for when time is up
    @State private var taskTimer: Timer? = nil // Timer object
    //---------------------------------------------------------------------------
    @State private var showAlert = false
    
    var body: some View {
        VStack{
            Text("Shower")
                .font(.system(size: 50, weight: .medium, design: .default))
                .foregroundColor(.primary)
                .padding(.bottom, 5)
            //-------------------------------------------
            Text(formatTime(remainingTime))
                .font(.system(size: 50, weight: .ultraLight))
                .font(.custom("SFPro-Thin", size: 50))   // Custom font family and size
                .foregroundColor(.primary.opacity(0.94)) // Text color with 94% opacity
                .padding(.bottom , 60)
            //-------------------------------------------------------------------------
            ZStack {
                // Background Circle (Empty)
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.our)
                
                // Foreground Circle (Progress)
                Circle()
                    .trim(from: 0.0, to: progress) // Control the amount of the circle filled
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .foregroundColor(.our)
                    .rotationEffect(.degrees(-90)) // Start from top
                    .animation(.easeInOut, value: progress) // Smooth animation
                
                Image("spark_time_frame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 227.06, height: 110.76)
            }
            .frame(width: 330, height: 330)
            .padding(.bottom , 100)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.our)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startTimer(duration: remainingTime) // Start the timer when the view appears
        }
        .onChange(of: remainingTime) { newValue in
            if newValue <= 0 {
                showAlert = true
            }
        }
        
        .alert(isPresented: $showAlert) {
            
            Alert(
                title: Text("Time is up!"),
                message: Text("Tip: turn on back tap, so that you check the task off with ease!"),
                primaryButton: .default(
                    Text("Done")
                ) {
                    // Handle "Done" action here
                    
                },
                secondaryButton: .default(Text("+ 15 min")) {
                    // Handle "+ 15 min" action here
                    print("Added 15 more minutes.")
                    remainingTime += 900 // Adds 15 minutes
                    startTimer(duration: remainingTime)
                }
            )
        }
    }
    
    // Format time as MM:SS
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Start the timer
    func startTimer(duration: TimeInterval) {
        remainingTime = duration
        progress = 1.0 // Full progress initially
        taskTimer?.invalidate() // Cancel any existing timer
        taskTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
                progress = CGFloat(remainingTime / duration)
            } else {
                taskTimer?.invalidate()
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskTimeFrame() // Embed in a NavigationStack
    }
}
