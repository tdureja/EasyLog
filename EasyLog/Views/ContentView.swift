//
//  ContentView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 12/19/25.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    @State var savedWorkouts: [Workout] = []
    @State var savedCategories: [String] = []

    
    init(){
        if let data = UserDefaults.standard.data(forKey: "SavedData"){
            if let decoded = try? JSONDecoder().decode([Workout].self, from: data){
                _savedWorkouts = State(initialValue: decoded)
            }
        } else {
            _savedWorkouts = State(initialValue: [])
        }
    }
    

    var body: some View {
        TabView{
            WorkoutView(savedWorkouts: $savedWorkouts, savedCategories: $savedCategories)
                .tabItem{
                    Text("Workout")
                }
            CalendarView(savedWorkouts: $savedWorkouts)
                .tabItem{
                    Text("Calendar")
                }
            MotivationView()
                .tabItem{
                    Text("Motivation")
                }
        }
        .onChange(of: savedWorkouts) {
            if let encoded = try? JSONEncoder().encode(savedWorkouts){
                UserDefaults.standard.set(encoded, forKey: "SavedData")
            }
        }
    }
}

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter.string(from: date)
}



#Preview {
    ContentView()
}
