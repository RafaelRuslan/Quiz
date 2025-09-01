//
//  HomeView.swift
//  Quiz
//
//  Created by Rafael Agayev on 26.08.25.
//

import SwiftUI

struct HomeView: View {
    @State private var showQuiz = false
    @Environment(\.dismiss) private var dismiss
    let name: String
    @AppStorage("primaryHex") var hex: String = "#ffffff"
    
    
    var body: some View {
            NavigationStack{
                ZStack{
                    Color(hex: hex)
                        .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20){
                    Text("Gracias \(name)")
                        .font(.title)
                    Button {
                        showQuiz = true
                    } label: {
                        Text("Start Quiz ➡️")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .background(
                                Color.blue
                                    .frame(width: 200, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            )
                    }
                }
            }
            .navigationDestination(isPresented: $showQuiz) {
                QuizView(language: "")
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                toolbar
            }
        }
        .ignoresSafeArea()
    }
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent{
        ToolbarItem(placement: .topBarLeading) {
            Button{
                dismiss()
            }label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
        }
        ToolbarItem(placement: .principal) {
            Text("Welcome to Quiz")
                .font(.largeTitle)
                .italic()
        }
    }
}

#Preview {
    HomeView(name: "")
}

