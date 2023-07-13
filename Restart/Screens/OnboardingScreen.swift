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
    
    @State private var imageOffset : CGSize = .zero
    
    @State private var indicatorOpacity : Double = 1.0
    
    @State private var textTitle : String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    
    // MARK: - BODY SECTION
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            
            VStack {
                // MARK: HEADER SECTION
                
                Spacer()
                
                VStack (spacing: 0){
                    
                    Text(textTitle)
                        .font(.system(size: 65))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    
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
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5 ))
                        .animation(.easeOut(duration: 1), value: isAnimating)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                            .onChanged{
                            
                            gesture in
                            if abs(imageOffset.width) <= 150{
                                imageOffset  = gesture.translation
                                withAnimation(.linear(duration: 0.25)){
                                    indicatorOpacity = 0
                                    textTitle = "Give."
                                }
                            }
                        }
                            .onEnded{
                                _ in
                                imageOffset = .zero
                                
                                withAnimation(.linear(duration: 0.25)){
                                    indicatorOpacity = 1
                                    textTitle = "Share."
                                }
                            }
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        
                        .foregroundColor(.white)
                        .font(.system(size: 44, weight: .ultraLight))
                        .offset(y:0)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    ,
                    alignment: .bottom
                
                )
                
                
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
                                    withAnimation(Animation.easeOut(duration: 1)){
                                        if buttonOffset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingActive = false
                                            
                                        } else{
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
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
        .preferredColorScheme(.dark)
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
