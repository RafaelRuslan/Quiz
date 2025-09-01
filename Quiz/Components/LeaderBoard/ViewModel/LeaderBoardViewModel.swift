//
//  LeaderBoardViewModel.swift
//  Quiz
//
//  Created by Rafael Agayev on 30.08.25.
//

import Foundation
import FirebaseFirestore

class LeaderBoardViewModel: ObservableObject{
    @Published var model: [LeaderBoardModel] = []
    private var db = Firestore.firestore()
    
    init(){
        fetchLeaderboard()
    }
    
    func fetchLeaderboard(){
        db.collection("users")
            .order(by: "score", descending: true)
            .limit(to: 20)
            .addSnapshotListener{ snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("no users data")
                    return
                }
                
                self.model = documents.map{ doc in
                    let data = doc.data()
                    let username = data["username"] as? String ?? "unknown"
                    let score = data["score"] as? Int ?? 0
                    return LeaderBoardModel(id: doc.documentID, username: username, score: score)
                }
            }
    }
    
    func medal(for index: Int) -> String{
        switch index{
        case 0:
            return "🥇"
        case 1:
            return "🥈"
        case 2:
            return "🥉"
        default:
            return "\(index + 1)"
        }
    }
}
