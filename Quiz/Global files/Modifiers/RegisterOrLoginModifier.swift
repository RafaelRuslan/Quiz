//
//  RegisterOrLoginModifier.swift
//  Quiz
//
//  Created by Rafael Agayev on 29.08.25.
//

import SwiftUI

struct RegisterOrLoginModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 10)
            .foregroundStyle(.white)
            .padding()
            .italic()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
}

extension View{
    func registerOrLoginModify() -> some View{
        self.modifier(RegisterOrLoginModifier())
    }
}
