//
//  ContentView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 12/19/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            WorkoutView()
            CalendarView()
            MotivationView()
        }
    }
}

struct WorkoutView: View{
    var body: some View{
        NavigationStack(){
            VStack{
                Text("Workout")
                NavigationLink{
                    ActiveWorkoutView()
                } label: {
                    Text("Start Workout")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct ActiveWorkoutView: View{
    
    @Environment(\.dismiss) var dismiss
    @State private var exercises: [Exercise] = []
    
    var body: some View{
        VStack{
            Text("Active Workout")
                // id replaced later with real ids
            List(exercises, id: \.id) { exercise in
                NavigationLink{
                    ExerciseDetailView(exercise: exercise)
                } label: {
                    Text(exercise.name)
                }
            }
            
            Button("Add Exercise"){
                let nextId = exercises.count + 1
                exercises.append(Exercise(id: nextId, name: "Exercise \(nextId)"))
            }
            
            Button("End Workout"){
                print("Ending Workout")
                dismiss()
            }
        }
    }
}

struct Exercise{
    let id: Int
    let name: String
}

struct ExerciseDetailView: View{
    let exercise: Exercise
    
    @State private var sets: [SetEntry] = []
    
    var body: some View{
        VStack{
            Text("Exercise Detail")
            List{
                ForEach(Array(sets.enumerated()), id: \.element.id) { index, set in
                    NavigationLink{
                        SetDetailView(set: set)
                    } label: {
                        Text("Set \(index + 1)")
                    }
                }
            }
            
            Button("Add Set"){
                sets.append(SetEntry(id: UUID(), weight: 0, reps: 0))
            }
        }
    }
}

struct SetEntry{
    let id: UUID
    let weight: Double
    let reps: Int
}

struct SetDetailView: View{
    let set: SetEntry
    
    var body: some View{
        Text("Set Detail")
    }
}

struct CalendarView: View{
    var body: some View{
        Text("Calendar")
        
    }
}

struct MotivationView: View{
    var body: some View{
        Text("Motivation")
    }
}


#Preview {
    ContentView()
}
