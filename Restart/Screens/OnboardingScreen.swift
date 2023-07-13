//
//  OnboardingScreen.swift
//  Restart
//
//  Created by Augustus Onyekachi on 12/07/2023.
//

import SwiftUI

struct OnboardingScreen: View {
    //MARK: - PROPERTIES
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    
    @State private var buttonWidth : Double = UIScreen.main.bounds.width - 80
    
    @State private var isAnimating : Bool = false
    
    @State private var buttonOffset : CGFloat = 0
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
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: SECTION - CENTER
                
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
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
                            .frame(width: buttonOffset + 80)
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
                        .offset(x:buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged {
                                    gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{_ in
                                    if buttonOffset > buttonWidth / 2 {
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingActive = false
                                        
                                    } else{
                                        buttonOffset = 0
                                    }
                                   
                                    
                                }
                        )
                        
                        Spacer()
                    }
                    
                    
                    
                    
                }
                .frame(width: buttonWidth,height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }
            
            
        }
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
