//
//  ScoreModifier.swift
//  Quiz
//
//  Created by Rafael Agayev on 25.08.25.
//

import SwiftUI

struct ScoreModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .font(.title2)
            .italic()
    }
}

extension View{
    func scoreModify() -> some View{
        self.modifier(ScoreModifier())
    }
}
