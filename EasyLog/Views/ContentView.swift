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
        
        if let data = UserDefaults.standard.data(forKey: "AppData"), let decoded = try? JSONDecoder().decode(AppData.self, from: data){
            
            _savedWorkouts = State(initialValue: decoded.workouts)
            _savedCategories = State(initialValue: decoded.categories)
        } else {
            let presets = ["Push", "Pull", "Legs", "Cardio", "Full Body", "Chest and Back", "Back and Biceps"]
            
            _savedWorkouts = State(initialValue: [])
            _savedCategories = State(initialValue: presets)
            
            saveAppData() // to be created
        }
        
        if let data = UserDefaults.standard.data(forKey: "AppData"){
            if let decoded = try? JSONDecoder().decode([Workout].self, from: data){
                _savedWorkouts = State(initialValue: decoded)
            }
        } else {
            _savedWorkouts = State(initialValue: [])
        }
    }
    
    func saveAppData(){
        let appData = AppData(
            workouts: savedWorkouts,
            categories: savedCategories
        )
        
        if let encoded = try? JSONEncoder().encode(appData){
            UserDefaults.standard.set(encoded, forKey: "AppData")
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
        } // needs to use saveappdata call once saveappdata is created
        .onChange(of: savedWorkouts) {
            saveAppData()
//            if let encoded = try? JSONEncoder().encode(savedWorkouts){
//                UserDefaults.standard.set(encoded, forKey: "SavedData")
//            }
        }
        .onChange(of: savedCategories){
            saveAppData()
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
