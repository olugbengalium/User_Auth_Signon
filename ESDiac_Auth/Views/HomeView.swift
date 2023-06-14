//
//  HomeView.swift
//  ESDiac_Auth
//
//  Created by Gbenga Abayomi on 13/06/2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage ("onboarding") var isOnboarding: Bool = false
    @State var username = ""
    var body: some View {
        if isOnboarding{
            LoginView()
    }else
        {
        VStack{
            UserProfileView()
            Button("Back to Login"){
                isOnboarding.toggle()
            }
        }
    }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
