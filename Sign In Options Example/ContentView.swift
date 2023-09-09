//
//  ContentView.swift
//  Sign In Options Example
//
//  Created by Michael Hsieh on 9/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
                .opacity(0.5)
            
            VStack {
                Image("GoogleButton")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                Image("AppleButton")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                Button("Create an Account") {
                    
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
