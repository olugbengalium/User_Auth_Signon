import SwiftUI
struct UserProfileView: View {
    @EnvironmentObject var checker: Checker
    @State private var isLoggedOut = false
    
    var body: some View {
        ZStack {
            if let user = checker.loggedInUser {
                   Form {
                       Text("Login Succcessful, confirm your details below")
                           .font(.title)
                           .foregroundColor(.purple)
                        Text("Username: \(user.username ?? "")")
                            .padding()
                        Text("Password: \(user.password ?? "")")
                            .padding()
                        Text("First Name: \(user.firstname ?? "")")
                            .padding()
                        Text("Phone Number: \(user.phone ?? "")")
                            .padding()
                        Text("Email: \(user.email ?? "")")
                            .padding()
                    }
                   
            } else {
                Text("User not found. Please log in with correct credentials.")
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(checker)
    }
}
