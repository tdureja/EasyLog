//
//  Theme.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 2/13/26.
//

import SwiftUI

struct Theme {
    static let bg = Color(hex: "#1b1c1c")
    static let card = Color(hex: "#3C3C41")
    static let textPrimary = Color.white
    static let textSecondary = Color.gray
    static let accent = Color(hex: "#E63946")
}

// extension to color for allowing use of hex values
extension Color{
    init(hex: String){
        let hex = hex.trimmingCharacters(in:  CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r = (int >> 16) & 0xFF
        let g = (int >> 8) & 0xFF
        let b = int & 0xFF
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}

