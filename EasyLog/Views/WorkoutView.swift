//
//  WorkoutView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import SwiftUI


struct WorkoutView: View{
    @Binding var savedWorkouts: [Workout]
    @Binding var savedCategories: [String]
    @Binding var savedExerciseDefinitions: [ExerciseDefinition]
    
    @State var selectedCategory: String? = nil
    @State var isStartingWorkout: Bool = false
    
    var body: some View{
        NavigationStack(){
            VStack{
                if let lastWorkout = savedWorkouts.last, Calendar.current.isDateInToday(lastWorkout.workoutDate){
                    VStack(){
                        Text("Today's Workout")
                            .font(.headline)
                        
                        // TODO: fix home screen exercise listing after coding add exercise flow
//                        ForEach(lastWorkout.exercises){exercise in
//                            Text(exercise.name)
//                                .font(.subheadline)
//                        }
                        
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
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    
                } else {
                    Button {
                        isStartingWorkout = true
                    } label: {
                        Text("Start Workout")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
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
