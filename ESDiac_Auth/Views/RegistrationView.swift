//
//  RegistrationView.swift
//  ESDiac_Auth
//
//  Created by Gbenga Abayomi on 13/06/2023.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var checker: Checker
    @State private var firstname: String = ""
    @State private var username: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isLoading: Bool = false
    @State private var alertMessage: String = ""
    @State private var isSuccessfulAlertShowed: Bool = false
    
    var body: some View {
        NavigationView{
            Form
            {
                header
                    .padding()
                formField
                button
                NavigationLink {
                    LoginView()
                } label: {
                    HStack{
                        Text("Old user? 👉🏽")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        Spacer()
                        Text("SignIn")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
            }
            .cornerRadius(8)
            .navigationTitle("Register...")
        }
        .environmentObject(checker)
    }
}

extension RegistrationView {
    private var isButtonEnabled: Bool {
            checker.isAuthenticating || username.isEmpty || password.isEmpty
    }
    var header: some View {
        VStack {
        HStack{
            Spacer()
            VStack {
                Image(systemName: "network.badge.shield.half.filled")
                    .resizable()
                    .frame(width: 50, height: 80)
                    .foregroundColor(.blue)
                
                Text("Join ESDIAC")
                    .foregroundColor(Color.gray)
            }
            Spacer()
        }
        Text("First, let's create your user account")
                .fontWeight(.semibold)
    }
    }
    

    var formField: some View {
        VStack(alignment: .leading){
            Text("Firstname: *")
                .fontWeight(.bold)
            TextField("👤 firstname", text: $firstname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.bottom)
            
            Text("Username: *")
                .fontWeight(.bold)
            TextField("👤 username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.bottom)
            
            Text("Email address: *")
                .fontWeight(.bold)
            TextField("📧 email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.bottom)
            
            Text("Telephone: *")
                .fontWeight(.bold)
            TextField("☎️ phone number", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.bottom)
            Group{
                Text("Password: *")
                    .fontWeight(.bold)
                SecureField("🔑 password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Text("Confirm Password: *")
                    .fontWeight(.bold)
                SecureField("🔑 password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
            }
        }
        
    }
    
    var button: some View {
        HStack(alignment: .center){
            Spacer()
            Button( checker.isAuthenticating ? "Please wait" : "Register")
            {
                register()
                checker.await()
            }
            .frame(width: 200, height: 30)
            .background(Capsule().fill(Color.orange))
            .disabled(isButtonEnabled)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(checker.isAuthenticating ? 1.0 : 0.0)
         Spacer()
        }
    }
    
    private func register() {
        guard password == confirmPassword else {
            isSuccessfulAlertShowed = true
                    alertMessage = "Passwords do not match."
                    return
                }
        
            let newUser = User(context: viewContext)
            newUser.username = username
            newUser.password = password
            newUser.firstname = firstname
            newUser.phone = phone
            newUser.email = email
        saveDatabase()
        }
    
    
    func saveDatabase() {
        guard viewContext.hasChanges else { return}
        do {
            try viewContext.save()
        } catch (let error) {
            isSuccessfulAlertShowed = true
            alertMessage = "Failed to register user."
            print(error.localizedDescription)
        }
    }
}
