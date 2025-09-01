//
//  HexCodeColorView.swift
//  Quiz
//
//  Created by Rafael Agayev on 01.09.25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b: Double
        switch hex.count {
        case 3:
            r = Double((int >> 8 & 0xF) * 17) / 255
            g = Double((int >> 4 & 0xF) * 17) / 255
            b = Double((int & 0xF) * 17) / 255
        case 6:
            r = Double(int >> 16 & 0xFF) / 255
            g = Double(int >> 8 & 0xFF) / 255
            b = Double(int & 0xFF) / 255
        default:
            r = 0; g = 0; b = 0
        }
        
        self.init(red: r, green: g, blue: b)
    }
}

struct HexColorView: View {
    @AppStorage("primaryHex") var hex: String = "#3498db"

    var body: some View {
        ZStack{
            Color(hex: hex)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
