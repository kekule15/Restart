//
//  ContentView.swift
//  Restart
//
//  Created by Augustus Onyekachi on 12/07/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    var body: some View {
        if isOnboardingActive {
            OnboardingScreen()
        } else{
            HomeScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
