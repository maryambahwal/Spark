//
//  ContentView.swift
//  Spark
//
//  Created by Maryam Bahwal on 09/06/1446 AH.
//
//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var showCancelView = false
//    var body: some View {
//
//                    Text("Hello To Spark App")
//
//    }
//}
//
//#Preview {
//    ContentView()
//}
import Foundation
import SwiftUI

struct HomeView: View {
    var userName: String
    @State private var isTaskSheetPresented: Bool = false // حالة لفتح TaskSheet
    @State private var tasks: [Task] = [] // قائمة المهام

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                
                // النصوص
                Text("Hi \(userName)!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    
                Text("Add your today’s tasks to watch me grow!")
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                // الصورة
                Image("dogImage2")
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer()
            }
            
            // زر الإجراء العائم
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        isTaskSheetPresented = true // فتح TaskSheet
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.orng)
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                }
                Spacer()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $isTaskSheetPresented) { // عرض TaskSheet عند الضغط على الزر
            TaskSheet(tasks: $tasks) // تمرير قائمة المهام إلى TaskSheet
        }
    }
}

struct IntroduceView: View {
    @State private var name: String = ""
    @State private var isNextActive: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Image
            GIFImage(name: "dogGif")
                                    .frame(width: 200, height: 200)
                                    .edgesIgnoringSafeArea(.all)
                                    .offset(x: 0,y: 850)
                                    .scaleEffect(CGSize(width: 0.06, height: 0.06))
            
            // Text
            Text("Introduce yourself to me")
                .font(.title2)
                .foregroundColor(.white)
            
            // TextField
            TextField("Enter Your Name", text: $name)
                .padding(10)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Button
            Button(action: {
                if !name.isEmpty {
                    // Save the name in UserDefaults
                    UserDefaults.standard.set(name, forKey: "UserName")
                    isNextActive = true
                }
            }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(Color.orng)
                    .cornerRadius(10)
                    .padding(.horizontal, 140)
            }
            .disabled(name.isEmpty) // Disable button if name is empty
            
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .fullScreenCover(isPresented: $isNextActive) {
            HomeView(userName: name)
        }
    }
}

struct Homepage: View {
    @State private var userName: String? = UserDefaults.standard.string(forKey: "UserName")
    
    var body: some View {
        if let savedName = userName {
            // Go directly to HomeView if name is saved
            HomeView(userName: savedName)
        } else {
            // Show IntroduceView if no name is saved
            IntroduceView()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Homepage()
//    }
//}
#Preview {
    Homepage()
}
