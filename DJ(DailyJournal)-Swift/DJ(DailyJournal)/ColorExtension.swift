//
//  ColorExtension.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/4/24.
//

import SwiftUI

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        let hexFormatted = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        let a, r, g, b: UInt64
        Scanner(string: hexFormatted).scanHexInt64(&int)
        
        switch hexFormatted.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    static var backgroundColor: LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color.topColor, Color.bottomColor]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    static let gray = Color(hex: "828282")
    static let lightYellow = Color(hex: "FFD27F")
    static let ivory = Color(hex: "FAF0E6")
    static let topColor = Color(hex: "030637")
    static let bottomColor = Color(hex: "3C0753")
}
