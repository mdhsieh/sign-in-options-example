//
//  WelcomeView.swift
//  Sign In Options Example
//
//  Created by Michael Hsieh on 9/8/23.
//

import SwiftUI


struct WelcomeView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authService: AuthService

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                    .opacity(0.5)
                
                VStack {
                    Button {
                        print("Tapped google sign in")
                        authService.googleSignIn()
                    } label: {
                        Image("GoogleButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                    }
                    
                    
                    Button {
                        print("Tapped apple sign in")
                        authService.startSignInWithAppleFlow()
                    } label: {
                        Image("AppleButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                    }
                    
                    Text("OR")
                    
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Create an Account") {
                        authService.regularCreateAccount(email: email, password: password)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    
                    HStack {
                        Text("Already have an account? ")
                        
                        NavigationLink(destination: LoginView()) {
                            Text("Login").foregroundColor(.blue)
                        }
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
