//
//  LoginView.swift
//  ESDiac_Auth
//
//  Created by Gbenga Abayomi on 13/06/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var checker: Checker
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: [], predicate: nil)
    private var users: FetchedResults<User>
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAuthenticating = false
    @State private var showInvalidCredentialsAlert = false
    @State private var isLoggedIn = false
    @State private var showingDetail = false
    var body: some View {
        NavigationView {
            Form {
                header
                loginField
                button
            }
            .navigationTitle("SignIn")
        }
        .environmentObject(checker)
    }
    
    private var isButtonEnabled: Bool {
        checker.isAuthenticating || username.isEmpty || password.isEmpty
    }
    
    var button: some View {
        HStack(alignment: .center){
            Spacer()
            Button(checker.isAuthenticating ? "Please wait" : "Log in") {
                
                showingDetail = true
                checker.newUser = checker.loggedInUser
                checker.await()
                logIn()
//                logIn()
            }
            .fullScreenCover(isPresented: $showingDetail) {

                    Button("Back to login") {
                        showingDetail = false
                    }
                    UserProfileView()
            }
            
            
            .alert(isPresented: $showInvalidCredentialsAlert) {
                Alert(title: Text("Login Failed"), message: Text("Invalid username or password."), dismissButton: .default(Text("OK")))
            }
            
            .frame(width: 100, height: 30)
            .background(Capsule().fill(Color.orange))
            .disabled(isButtonEnabled)
//            .onChange(of: isLoggedIn) { newValue in
//                if newValue {
//                    username = ""
//                    password = ""
//                }
//            }
            Spacer()
        }
    }
    
    var loginField: some View {
        VStack(alignment: .leading){
            TextField("👤 Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            SecureField("🔑 Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .padding(.bottom)
        }
    }
    
    var header: some View {
        HStack{
            Spacer()
            VStack{
                Image(systemName: "network.badge.shield.half.filled")
                    .resizable()
                    .frame(width: 50, height: 80)
                    .foregroundColor(.blue)
                Text("Sign in to get access")
                    .font(.title2)
            }
            Spacer()
        }
        .padding()
    }

    private func logIn() {
        let isUserValid = users.contains { $0.username == username && $0.password == password }
        if isUserValid {
            if let loggedInUser = users.first(where: { $0.username == username }) {
                checker.loggedInUser = loggedInUser
                isLoggedIn = true
            }
        } else {
            password = ""
            showInvalidCredentialsAlert = true
            showingDetail = false
        }
    }
}
