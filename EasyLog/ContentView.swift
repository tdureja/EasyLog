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
            WorkoutView(savedWorkouts: $savedWorkouts)
                .tabItem{
                    Text("Workout")
                }
            CalendarView(savedWorkouts: savedWorkouts)
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

struct WorkoutView: View{
    @Binding var savedWorkouts: [Workout]
    
    var body: some View{
        NavigationStack(){
            VStack{
                if let lastWorkout = savedWorkouts.last, Calendar.current.isDateInToday(lastWorkout.workoutDate){
                    VStack(){
                        Text("Today's Workout")
                            .font(.headline)
                        
                        ForEach(lastWorkout.exercises){exercise in
                            Text(exercise.name)
                                .font(.subheadline)
                        }
                        
                        NavigationLink{
                            ActiveWorkoutView(savedWorkouts: $savedWorkouts, exercises: lastWorkout.exercises)
                        } label: {
                            Text("Edit Workout")
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    
                } else {
                    NavigationLink{
                        ActiveWorkoutView(savedWorkouts: $savedWorkouts, exercises: [])
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
}

struct ActiveWorkoutView: View{
    
    @Environment(\.dismiss) var dismiss
    @Binding var savedWorkouts: [Workout]
    @State var exercises: [Exercise]

    var body: some View{
        VStack{
            Text("Active Workout")
                // id replaced later with real ids
            List{
                ForEach($exercises){ $exercise in NavigationLink {
                        ExerciseDetailView(exercise: $exercise)
                } label: {
                    Text(exercise.name)
                }
            }
        }
            
            Button("Add Exercise"){
                let nextId = exercises.count + 1
                exercises.append(Exercise(id: nextId, name: "Exercise \(nextId)", sets: []))
            }
            
            Button("End Workout"){
                if let index = savedWorkouts.firstIndex(where: { workout in
                    Calendar.current.isDateInToday(workout.workoutDate)
                }){
                    // replace workout
                    savedWorkouts[index] = Workout(id: savedWorkouts[index].id, workoutDate: savedWorkouts[index].workoutDate, category: savedWorkouts[index].category, exercises: exercises)
                } else {
                    //append workout
                    savedWorkouts.append(Workout(id: UUID(), workoutDate: Date(), category: "Uncategorized", exercises: exercises))
                }
                dismiss()
                print(savedWorkouts.count)
            }
        }
    }
}

struct Workout: Codable, Identifiable, Equatable{
    var id: UUID
    var workoutDate: Date
    let category: String
    let exercises: [Exercise]
}


struct Exercise: Codable, Identifiable, Equatable{
    let id: Int
    let name: String
    var sets: [SetEntry]
    var unit: WeightUnit = .lbs
}

enum WeightUnit: String, Codable, CaseIterable, Identifiable {
    case lbs
    case kg
    
    var id: Self { self }
}

struct ExerciseDetailView: View{
    @Binding var exercise: Exercise
    
    var body: some View{
        VStack{
            Text("Exercise Detail")
            
            Picker("Unit", selection: $exercise.unit){
                ForEach(WeightUnit.allCases){ unit in
                    Text(unit.rawValue.uppercased())
                        .tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            List{
                ForEach(exercise.sets.indices, id: \.self){ index in
                    
                    let set = $exercise.sets[index]
                    
                    HStack {
                        Text("Set \(index + 1)")
                        
                        Spacer()
                        
                        TextField("0", value: set.reps, format: .number)
                            .keyboardType(.numberPad)
                            .frame(width:30)
                        
                        Text("x")
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 4){
                            TextField("0", value: set.weight, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 40)
                            Text(exercise.unit.rawValue)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                }
                .onDelete{ offsets in
                    exercise.sets.remove(atOffsets: offsets)}
            }
            
            Button("Add Set"){
                exercise.sets.append(
                    SetEntry(id: UUID(), weight: 0, reps: 0))
            }
        }
    }
}

struct SetEntry: Codable, Identifiable, Equatable{
    let id: UUID
    var weight: Double
    var reps: Int
}

struct SetDetailView: View{
    let set: SetEntry
    
    var body: some View{
        Text("Set Detail")
    }
}

struct CalendarView: View{
    let savedWorkouts: [Workout]
    
    var body: some View{
        VStack{
            Text("Workout History")
            
            NavigationStack{
                List{
                    ForEach(savedWorkouts){ workout in
                        NavigationLink{
                            PastWorkoutView(workout: workout)
                        } label: {
                            Text(workout.workoutDate.description) // placeholder; use date formatter later
                        }
                        
                    }
                }
            }
        }
        
    }
}

struct PastWorkoutView: View{
    let workout: Workout
    
    var body: some View{
        
        VStack{
            Text(workout.workoutDate.description)
            Text(workout.category)
            ForEach(workout.exercises){ exercise in
                Text(exercise.name)
                ForEach(exercise.sets){ set in
                    Text("\(set.reps) reps x \(set.weight) \(exercise.unit)")
                }
            }
        }
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
