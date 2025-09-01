//
//  MainView.swift
//  Quiz
//
//  Created by Rafael Agayev on 26.08.25.
//

import SwiftUI

struct MainView: View {
    @State private var isLoggedIn = false
    @AppStorage("primaryHex") var hex: String = "#3498db"
    var body: some View {
        ZStack{
            Color(hex: hex)
                .edgesIgnoringSafeArea(.all)
            if isLoggedIn{
                HomeView(name: "")
            }else{
                LoginView()
            }
        }
    }
}

#Preview {
    MainView()
}
