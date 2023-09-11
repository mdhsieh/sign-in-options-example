//
//  HomeView.swift
//  Sign In Options Example
//
//  Created by Michael Hsieh on 9/11/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            Text("Home Screen")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Log out") {
                            print("Log out tapped!")
                        }
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
