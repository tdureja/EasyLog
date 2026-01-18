//
//  SetEntry.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import Foundation

struct SetEntry: Codable, Identifiable, Equatable{
    let id: UUID
    var weight: Double
    var reps: Int
}
