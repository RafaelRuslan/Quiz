//
//  QuestionModifier.swift
//  Quiz
//
//  Created by Rafael Agayev on 25.08.25.
//

import SwiftUI

struct QuestionModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title)
            .bold()
    }
}

extension View{
    func questModify() -> some View{
        self.modifier(QuestionModifier())
    }
}
