//
//  HomeScreen.swift
//  Restart
//
//  Created by Augustus Onyekachi on 12/07/2023.
//

import SwiftUI

struct HomeScreen: View {
    // MARK: - PROPERTIES SECTION
    
    @AppStorage("onboarding") var isOnboardingActive: Bool = false
    
    @State private var isAnimating : Bool = false
    
    
    
    // MARK: - BODY SECTION
    var body: some View {
        
        VStack {
            
            
            
            // MARK: - HEADER SECTION
            Spacer()
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        Animation.easeInOut(
                        duration: 4)
                        .repeatForever(),
                        value: isAnimating)
            }
            
            
            // MARK: - CENTER SECTION
            
            Text("The time that leads to mastery is dependent on the intensity of our focus")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            
            // MARK: - FOOTER SECTION
            
            Spacer()
            
            Button{
                // PERFORM SOME FUNCTION
                
                withAnimation{
                    playSound(sound: "success", type: "m4a")
                    isOnboardingActive = true
                }
                
            }label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                isAnimating = true
            })
        })
        
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
