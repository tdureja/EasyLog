//
//  Exercise.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import Foundation

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
