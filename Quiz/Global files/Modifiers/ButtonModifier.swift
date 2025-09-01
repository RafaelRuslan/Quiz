//
//  ButtonModifier.swift
//  Quiz
//
//  Created by Rafael Agayev on 26.08.25.
//

import SwiftUI

struct ButtonModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 350)
            .foregroundStyle(.white)
    }
}

extension View{
    func buttonModify() -> some View{
        self.modifier(ButtonModifier())
    }
}
