//
//  ExerciseDefinition.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import Foundation

struct ExerciseDefinition: Codable, Identifiable, Equatable, Hashable{
    var id: UUID = UUID()
    var name: String
    var categories: [String] = []
}

