//
//  WorkoutView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import SwiftUI

struct HeaderSection: View{
    
    let savedWorkouts: [Workout]
    
    var body: some View{
        
        if let lastWorkout = savedWorkouts.last, Calendar.current.isDateInToday(lastWorkout.workoutDate){
            Text("Good Work Today")
                .font(.system(size: 34, weight: .bold))
                .padding(.top)
                .foregroundColor(Theme.textPrimary)
        } else {
            Text("Let's Train")
                .font(.system(size: 34, weight: .bold))
                .padding(.top)
                .foregroundColor(Theme.textPrimary)
        }
    }
}


struct WorkoutActionSection: View{
    
    @Binding var savedWorkouts: [Workout]
    @Binding var savedExerciseDefinitions: [ExerciseDefinition]
    @Binding var isStartingWorkout: Bool
    
    var body: some View{
        
        if let lastWorkout = savedWorkouts.last, Calendar.current.isDateInToday(lastWorkout.workoutDate){
            
            VStack(){
                                        
                Text("Today's Workout")
                    .font(.headline)
                    .foregroundColor(Theme.textPrimary)
                
                ForEach(lastWorkout.exercises){ exercise in
                    Text(exercise.definition.name)
                }
                .foregroundColor(Theme.textPrimary)
                
                NavigationLink{
                    ActiveWorkoutView(
                                      savedWorkouts: $savedWorkouts,
                                      savedExerciseDefinitions:      $savedExerciseDefinitions,
                                      selectedCategory: .constant(lastWorkout.category),
                                      isStartingWorkout: .constant(false),
                                      exercises: lastWorkout.exercises
                    )
                } label: {
                    Text("Edit Workout")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Theme.accent)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(Theme.card)
            .cornerRadius(16)
            
        } else {
            Button {
                isStartingWorkout = true
            } label: {
                Text("Start Workout")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Theme.accent)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
    }
}


struct WorkoutView: View{
    @Binding var savedWorkouts: [Workout]
    @Binding var savedCategories: [String]
    @Binding var savedExerciseDefinitions: [ExerciseDefinition]
    
    @State var selectedCategory: String? = nil
    @State var isStartingWorkout: Bool = false
    
    var body: some View{
        NavigationStack(){
            ZStack{
                
                Theme.bg.ignoresSafeArea(edges: .top)
                
                VStack{
                    
                    HeaderSection(savedWorkouts: savedWorkouts)
                    
                    Spacer()
                        .frame(height: 200)
                    
                    WorkoutActionSection(savedWorkouts: $savedWorkouts, savedExerciseDefinitions: $savedExerciseDefinitions, isStartingWorkout: $isStartingWorkout)
                    
                    Spacer()
                    
                }
                .navigationDestination(isPresented: $isStartingWorkout){
                if selectedCategory == nil{
                    CategorySelectionView(selectedCategory: $selectedCategory, savedCategories: $savedCategories)
                } else{
                    ActiveWorkoutView(
                        savedWorkouts: $savedWorkouts,
                        savedExerciseDefinitions: $savedExerciseDefinitions,
                        selectedCategory: $selectedCategory,
                        isStartingWorkout: $isStartingWorkout,
                        exercises: []
                        )
                }
            }
            }
        }
    }
}

#Preview {
    ContentView()
}
