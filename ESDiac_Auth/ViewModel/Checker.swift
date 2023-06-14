//
//  Checker.swift
//  ESDiac_Auth
//
//  Created by Gbenga Abayomi on 13/06/2023.
//

import Foundation

class Checker: ObservableObject {
    @Published var isAuthenticating: Bool
    @Published var needsAuthentication: Bool
    @Published var loggedInUser: User?
    @Published var newUser: User?
    init() {
        self.isAuthenticating = false
        self.needsAuthentication = true
        self.loggedInUser = nil
        self.newUser = nil 
    }
    
    func await() {
        self.isAuthenticating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.isAuthenticating = false
        }
    }
    
    func logout() {
      self.needsAuthentication = true
    }
}
