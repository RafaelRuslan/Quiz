//
//  LeaderBoardView.swift
//  Quiz
//
//  Created by Rafael Agayev on 30.08.25.
//

import SwiftUI

struct LeaderBoardView: View {
    @StateObject private var vm = LeaderBoardViewModel()
    @AppStorage("primaryHex") var hex: String = "#3498db"
    
    var body: some View {
        ZStack{
            Color(hex: hex)
                .edgesIgnoringSafeArea(.all)
            Section("🏆 Leaderboard"){
                List(Array(vm.model.enumerated()), id:\.1.id){ index, user in
                    
                    HStack{
                        Text(vm.medal(for: index))
                            .font(.title2)
                        Text(user.username)
                            .font(.title2)
                        Spacer()
                        Text("\(user.score)")
                            .font(.title2)
                            .foregroundStyle(.blue)
                    }
                }
            }
            .onAppear{
                vm.fetchLeaderboard()
            }
        }
    }
}

#Preview {
    LeaderBoardView()
}
