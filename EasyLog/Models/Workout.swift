//
//  Workout.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import Foundation

struct Workout: Codable, Identifiable, Equatable{
    var id: UUID
    var workoutDate: Date
    let category: String
    let exercises: [WorkoutExercise]
}
