//
//  StartView.swift
//  Sign In Options Example
//
//  Created by Michael Hsieh on 9/11/23.
//

import SwiftUI
import FirebaseAuth

struct StartView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        if authService.signedIn {
            HomeView()
        } else {
            WelcomeView()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    @StateObject static var authService = AuthService()

    static var previews: some View {
        if authService.signedIn {
            HomeView()
        } else {
            WelcomeView()
        }
    }
}


    
