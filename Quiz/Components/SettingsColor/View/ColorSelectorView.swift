//
//  ColorSelectorView.swift
//  Quiz
//
//  Created by Rafael Agayev on 01.09.25.
//

import SwiftUI

struct ColorSelectorView: View {
    @AppStorage("primaryHex") var hex: String = "#ffffff"
    let colors = [
        "#ffffff",
        "#3498db",
        "f00",
        "ff5733",
        "#2ecc71",
        "#f1c40f",
        "#9b59b6",
        "#e91e63",
        "#1abc9c",
        "#7f8c8d",
        "#000000",
        "#8b4513",
        "#ff00ff",
        "#00ff00",
        "#FFDAB9",
        "#FFD700",
        "#98FF98"
    ]

    var body: some View {
        VStack {
            Text("Choose App color")
            List{
                ForEach(colors, id: \.self) { colorHex in
                    
                    Color(hex: colorHex)
                        .frame(width: 200, height: 40)
                        .cornerRadius(8)
                        .onTapGesture {
                            hex = colorHex
                        }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ColorSelectorView()
}
