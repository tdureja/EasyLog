//
//  WorkoutExercise.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 2/6/26.
//
import Foundation

struct WorkoutExercise: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var definition: ExerciseDefinition
    var unit: WeightUnit = .lbs
    var sets: [SetEntry] = []
}

enum WeightUnit: String, Codable, CaseIterable, Identifiable {
    case lbs
    case kg
    
    var id: Self { self }
}
