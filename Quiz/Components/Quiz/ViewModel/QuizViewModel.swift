//
//  QuizViewModel.swift
//  Quiz
//
//  Created by Rafael Agayev on 24.08.25.
//

import Foundation
import SwiftUI
import Alamofire
import FirebaseFirestore

class QuizViewModel: ObservableObject{
    @Published var model: [TriviaQuestion] = []
    @Published var score = 0
    @Published var currentIndex = 0
    @Published var isLoading = true
    @Published var quizFinished = false
    @Published var selectedAnswer: String? = nil
    @Published var isCorrectAnswer: Bool? = nil

    
    func fetchQuestions(language: String){
        let url = "https://opentdb.com/api.php?amount=50&type=multiple&lang=\(language)"
        AF.request(url).responseDecodable(of: TriviaResponse.self){ response in
            switch response.result{
            case .success(let data):
                self.model = data.results
                self.isLoading = false
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
    }
    func answerSelected(_ answer: String){
        let question = model[currentIndex]
        selectedAnswer = answer
        if answer == question.correctAnswer{
            score += 1
            isCorrectAnswer = true
        }else{
            isCorrectAnswer = false
        }
            if self.currentIndex < self.model.count - 1{
                self.currentIndex += 1
            }else{
                self.quizFinished = true
            }
            self.isCorrectAnswer = nil
            self.selectedAnswer = nil
    }
    func restartQuiz(){
        score = 0
        currentIndex = 0
        quizFinished = true
        selectedAnswer = nil
        isCorrectAnswer = nil
    }
}


extension QuizViewModel {
    private var db: Firestore {
        return Firestore.firestore()
    }
    
    func saveScore(userID: String, username: String) {
        let ref = db.collection("users").document(userID)
        let data: [String: Any] = [
            "username": username,
            "score": Int(score),
            "updatedAt": FieldValue.serverTimestamp()
        ]
        
        ref.setData(data, merge: true) { error in
            if let error = error {
                print("❌ Error saving score: \(error.localizedDescription)")
            } else {
                print("✅ Score saved successfully for \(username) with \(self.score) points")
            }
        }
    }
    
    func getTopPlayer(completion: @escaping (String, Int) -> Void){
        let ref = db.collection("users").order(by: "score", descending: true).limit(to: 1)
        ref.getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let doc = snapshot?.documents.first {
                let username = doc.data()["username"] as? String ?? "Unknown"
                let score = doc.data()["score"] as? Int ?? 0
                completion(username, score)
            }
        }
    }
}
