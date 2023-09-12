//
//  AuthService.swift
//  Sign In Options Example
//
//  Created by Michael Hsieh on 9/11/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthService: ObservableObject {
    
    @Published var signedIn:Bool = false
    
    init() {
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.signedIn = true
                print("Auth state changed, is signed in")
            } else {
                self.signedIn = false
                print("Auth state changed, is signed out")
            }
        }
    }
    
    // MARK: - Google sign in
    // Single-sign-on with Google
    func googleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // As you’re not using view controllers to retrieve the presentingViewController, access it through
        // the shared instance of the UIApplication
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] authentication, error in

          if let error = error {
              print("Error doing Google Sign-In, \(error.localizedDescription)")
              return
          }

          guard
            let user = authentication?.user,
            let idToken = user.idToken?.tokenString
          else {
            print("Error getting user or ID token during Google Sign-In authentication")
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            // Authenticate with Firebase
            Auth.auth().signIn(with: credential) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                }

                // Allow proceed to next screen
                print("Successful google sign in")
            }
        }
    }
    
    // Sign out if used Single-sign-on with Google
    func googleSignOut() {
        GIDSignIn.sharedInstance.signOut()
        print("Google sign out")
    }
    
    // MARK: - Password Account
    func regularCreateAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
                
            } else {
                print("Successfully created password account")
            }
        }
    }
    
    //MARK: - Traditional sign in
    // Traditional sign in with password and email
    func regularSignIn(email:String, password:String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
            if let e = error {
                completion(e)
            } else {
                print("Login success")
                completion(nil)
            }
        }
    }
    
    // Regular password acount sign out.
    // Closure has whether sign out was successful or not
    func regularSignOut(completion: @escaping (Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
          completion(signOutError)
        }
    }
}
