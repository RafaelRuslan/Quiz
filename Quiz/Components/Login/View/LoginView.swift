//
//  LoginView.swift
//  Quiz
//
//  Created by Rafael Agayev on 26.08.25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()
    @AppStorage("primaryHex") var hex: String = "#ffffff"
    @State private var showColorSettings = false
    var body: some View {
        ZStack{
            Color(hex: hex)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Please Login or Register")
                    .font(.largeTitle)
                    .bold()
                    .underline(true, color: .blue)
                
                TextField("Enter e-mail", text: $vm.email)
                    .textfieldModify()
                
                SecureField("Enter password", text: $vm.password)
                    .textfieldModify()
                
                HStack(spacing: 50) {
                    Button("Login") {
                        vm.loginUser()
                    }
                    .registerOrLoginModify()
                    Button("Register") {
                        vm.registerUser()
                    }
                    .registerOrLoginModify()
                }
            }
            .padding()
            .toolbar{
                toolbar
            }
            .alert(isPresented: $vm.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(vm.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
                
            }
            
            .navigationDestination(isPresented: $vm.showWelcome) {
                HomeView(name: vm.email)
            }
            .sheet(isPresented: $showColorSettings) {
                ColorSelectorView()
            }
        }
    }
    @ToolbarContentBuilder
    private var toolbar : some ToolbarContent{
        ToolbarItem(placement: .principal) {
            Text("Quiz App")
                .toolbarModify()
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button{
                showColorSettings = true
            }label: {
                Image(systemName: "gear")
                    .foregroundStyle(.black)
                    .font(.system(size: 20))
            }
        }
    }
}

#Preview {
    LoginView()
        
}
