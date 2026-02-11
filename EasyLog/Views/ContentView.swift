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
    @State var savedExerciseDefinitions: [ExerciseDefinition] = []

    
    init(){
        
        if let data = UserDefaults.standard.data(forKey: "AppData"), let decoded = try? JSONDecoder().decode(AppData.self, from: data){
            
            _savedWorkouts = State(initialValue: decoded.workouts)
            _savedCategories = State(initialValue: decoded.categories)
            _savedExerciseDefinitions = State(initialValue: decoded.exerciseDefinitions)
        } else {
            let categoryPresets = ["Push", "Pull", "Legs", "Cardio", "Full Body", "Chest and Back", "Back and Biceps", "Core"]

            let exercisePresets: [ExerciseDefinition] = [
                ExerciseDefinition(name: "Bench Press", categories: ["Push", "Full Body", "Chest and Back"]),
                ExerciseDefinition(name: "Incline Dumbbell Press", categories: ["Push", "Full Body", "Chest and Back"]),
                ExerciseDefinition(name: "Shoulder Press", categories: ["Push", "Full Body"]),
                ExerciseDefinition(name: "Lateral Raise", categories: ["Push", "Full Body"]),
                ExerciseDefinition(name: "Tricep Pushdown", categories: ["Push", "Full Body"]),
                ExerciseDefinition(name: "Pull-Ups", categories: ["Pull", "Back and Biceps", "Full Body", "Chest and Back"]),
                ExerciseDefinition(name: "Lat Pulldown", categories: ["Pull", "Back and Biceps", "Full Body", "Chest and Back"]),
                ExerciseDefinition(name: "Barbell Back Row", categories: ["Pull", "Back and Biceps", "Full Body", "Chest and Back"]),
                ExerciseDefinition(name: "Seated Cable Row", categories: ["Pull", "Back and Biceps", "Full Body", "Chest and Back"]),
                ExerciseDefinition(name: "Face Pull", categories: ["Pull", "Back and Biceps", "Full Body", "Chest and Back"]),
                ExerciseDefinition(name: "Bicep Curl", categories: ["Pull", "Back and Biceps", "Full Body"]),
                ExerciseDefinition(name: "Rear Delt Cable fly", categories: ["Pull", "Back and Biceps", "Full Body"]),
                ExerciseDefinition(name: "Rear Delt Machine fly", categories: ["Pull", "Back and Biceps", "Full Body"]),
                ExerciseDefinition(name: "Barbell Back Squat", categories: ["Legs", "Full Body"]),
                ExerciseDefinition(name: "Romanian Deadlift", categories: ["Legs", "Full Body"]),
                ExerciseDefinition(name: "Leg Press", categories: ["Legs", "Full Body"]),
                ExerciseDefinition(name: "Hamstring Curl", categories: ["Legs", "Full Body"]),
                ExerciseDefinition(name: "Calf Raise", categories: ["Legs", "Full Body"]),
                ExerciseDefinition(name: "Plank", categories: ["Core", "Full Body"]),
                ExerciseDefinition(name: "Hanging Leg Raise", categories: ["Core", "Full Body"]),
                ExerciseDefinition(name: "Cable Crunch", categories: ["Core", "Full Body"]),
            ]
            
            _savedWorkouts = State(initialValue: [])
            _savedCategories = State(initialValue: categoryPresets)
            _savedExerciseDefinitions = State(initialValue: exercisePresets)
            
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
            categories: savedCategories,
            exerciseDefinitions: savedExerciseDefinitions
        )
        
        if let encoded = try? JSONEncoder().encode(appData){
            UserDefaults.standard.set(encoded, forKey: "AppData")
        }
    }
    

    var body: some View {
        TabView{
            WorkoutView(savedWorkouts: $savedWorkouts, savedCategories: $savedCategories, savedExerciseDefinitions: $savedExerciseDefinitions)
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
