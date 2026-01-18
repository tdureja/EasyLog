//
//  PastWorkoutView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import SwiftUI

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
