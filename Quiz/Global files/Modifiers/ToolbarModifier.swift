//
//  ToolbarModifier.swift
//  Quiz
//
//  Created by Rafael Agayev on 29.08.25.
//

import SwiftUI

struct ToolbarModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 39))
            .italic()
            .foregroundStyle(.white)
            .background(
                Color.blue
                    .opacity(0.75)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: 230)
            )
            .underline(true, color: .black)
    }
}

extension View{
    func toolbarModify() -> some View{
        self.modifier(ToolbarModifier())
    }
}
