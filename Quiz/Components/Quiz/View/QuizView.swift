//
//  QuizView.swift
//  Quiz
//
//  Created by Rafael Agayev on 24.08.25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct QuizView: View {
    @StateObject private var vm = QuizViewModel()
    @State var language: String
    @Environment(\.dismiss) private var dismiss
    @State private var showLeaderBoard = false
    @AppStorage("primaryHex") var hex: String = "#ffffff"
    
    var body: some View {
        ZStack{
            Color(hex: hex)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                if vm.isLoading {
                    ProgressView("Questions \(language.uppercased()) Quiz...")
                } else if vm.model.isEmpty {
                    Text("Question not found...")
                        .font(.title)
                } else {
                    VStack(spacing: 20) {
                        Text("Question \(vm.currentIndex + 1)/\(vm.model.count)")
                            .questModify()
                        
                        let questions = vm.model[vm.currentIndex]
                        Text(questions.question)
                            .font(.title2)
                            .italic()
                        
                        let options = ([questions.correctAnswer] + questions.incorrectAnswers).shuffled()
                        ForEach(options, id: \.self) { option in
                            Button{
                                vm.answerSelected(option)
                            }label:{
                                Text(option)
                                    .buttonModify()
                                    .background(
                                        vm.selectedAnswer == option ? (vm.isCorrectAnswer == true ? Color.green : Color.red) : Color.blue
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            .disabled(vm.selectedAnswer != nil)
                        }
                        Spacer()
                        
                        Text("Score: \(vm.score)")
                            .scoreModify()
                    }
                    .animation(.interactiveSpring(duration: 2.99), value: vm.currentIndex)
                    .alert("Quiz finished!", isPresented: $vm.quizFinished) {
                        Button("Try again") {
                            
                            let userID = Auth.auth().currentUser?.uid ?? UUID().uuidString
                            let username = Auth.auth().currentUser?.email ?? "Unknown"
                            vm.saveScore(userID: userID, username: username)
                            vm.restartQuiz()
                        }
                    } message: {
                        Text("Your final score: \(vm.score)/\(vm.model.count)")
                    }
                }
            }
            .onAppear {
                vm.fetchQuestions(language: language)
                vm.getTopPlayer{ topUser, topScore in
                    print("Top user: \(topUser) - Score: \(topScore)")
                }
            }
            .navigationBarBackButtonHidden()
            .toolbar{
                toolbar
            }
            .sheet(isPresented: $showLeaderBoard){
                LeaderBoardView()
            }
            .frame(maxWidth: .infinity)
        }
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
        ToolbarItem(placement: .topBarTrailing) {
            Button{
                showLeaderBoard = true
            }label: {
                Text("🏆")
                    .font(.title)
            }
        }
    }
}
#Preview {
    QuizView(language: "")
}
