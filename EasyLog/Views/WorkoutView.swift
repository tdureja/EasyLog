//
//  WorkoutView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import SwiftUI


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
