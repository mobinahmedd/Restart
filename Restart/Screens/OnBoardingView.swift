//
//  OnBoardingView.swift
//  Restart
//
//  Created by Apptycoons on 31/03/2024.
//

import SwiftUI

struct OnBoardingView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true
    @State private var buttonWidth : Double = UIScreen.main.bounds.width-80
    @State private var buttonOffset : CGFloat = 0
    @State private var isAnimating : Bool = false
    //    @State private var imageOffset : CGSize = CGSize(width: 0, height: 0)
    @State private var imageOffset : CGSize = .zero //same as above line
    @State private var indicatorOpacity : Double = 1.0
    @State private var textTitle : String = "Share."
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    // MARK: BODY
    
    var body: some View {
        
        ZStack {
            
            Color(.colorBlue)
                .ignoresSafeArea(.all , edges:.all)
            
            VStack (spacing:20){
                
                Spacer()
                
                // MARK: - HEADER
                VStack(spacing:0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                    //  .id(textTitle) // used to tell swiftUI that  view is no longer the same view
                    
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                    
                }//: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y :isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1),value: isAnimating)
                
                // MARK: - CENTER
                ZStack{
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1:0)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width*1.2,y:0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged{gesture in
                                    if abs(imageOffset.width) <= 180{
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)){
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                        
                                    }
                                }
                        )
                        .animation(.easeOut(duration: 1),value: imageOffset)
                }//: CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44,weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y:20)
                        .opacity(isAnimating ? 1:0)
                        .animation(.easeOut(duration: 1).delay(2),value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                // MARK: - FOOTER
                
                ZStack(){
                    
                    // 1. BACKGROUND STATIC
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    
                    
                    
                    // 2. CAPSULE (DYNAMIC WIDTH)
                    
                    HStack{
                        Capsule()
                            .fill(Color.colorRed)
                            .frame(width:buttonOffset+80)
                        Spacer()
                    }
                    
                    // 3. CTA STATIC
                    
                    Text("GET STARTED")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .offset(x:20)
                    
                    // 4. CIRCLE DRAGGABLE
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color.colorRed)
                            
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size:24,weight: .bold))
                            
                        }//" ZSTACK
                        .foregroundColor(.white)
                        .frame(width: 80,height: 80,alignment: .center)
                        .offset(x:buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged(){gesture in
                                    if gesture.translation.width > 0 && gesture.translation.width <= buttonWidth-80{
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{_ in
                                    withAnimation(.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type:"mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnBoardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )//: GESTURE
                        
                        Spacer()
                    }//: HSTACK
                }//: FOOTER
                .frame(width:buttonWidth,height: 80,alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0 )
                .offset(y : isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1),value: isAnimating)
                
                Spacer()
                
                
            }//: VSTACK
        }//: ZSTACK
        .onAppear(){
            isAnimating = true
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        
    }
}

#Preview {
    OnBoardingView()
}
