//
//  OnboardingScreen.swift
//  Restart
//
//  Created by Augustus Onyekachi on 12/07/2023.
//

import SwiftUI

struct OnboardingScreen: View {
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    var body: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            
            VStack {
                // MARK: HEADER SECTION
                
                Spacer()
                
                VStack (spacing: 0){
                    
                    Text("Share.")
                        .font(.system(size: 65))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    
                    Text("""
                       It's not how much we give out but
                       how much we put into giving.
                       """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }
                
                //MARK: SECTION - CENTER
                
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                }
                
                
                Spacer()
                
                
                //MARK: FOOTER SECTION
                
                ZStack{
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION  (STATIC)
                    Text("Get Started")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .offset(x:20)
                    // 3. CAPSULE - DYNAMIC WIDTH
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: 80)
                        Spacer()
                    }
                    
                    // 4. CIRCLE DRAGGABLE
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .onTapGesture {
                            isOnboardingActive = false
                        }
                        
                        Spacer()
                    }
                    
                    
                    
                    
                }
                .frame(height: 80, alignment: .center)
                .padding()
            }
            
            
        }
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
