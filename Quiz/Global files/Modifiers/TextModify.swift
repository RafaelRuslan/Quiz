//
//  TextModify.swift
//  Quiz
//
//  Created by Rafael Agayev on 24.08.25.
//

import SwiftUI

struct TextModify: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

extension View{
    func textModify() -> some View{
        self.modifier(TextModify())
    }
}
