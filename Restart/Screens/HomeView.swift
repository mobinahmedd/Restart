//
//  HomeView.swift
//  Restart
//
//  Created by Apptycoons on 31/03/2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: PROPERTIES
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = false
    @State private var isAnimating : Bool = false
    // MARK: BODY
    var body: some View {
        
        VStack(spacing:20) {
            
            Spacer()
            
            // MARK: - HEADER
            
            ZStack{
                CircleGroupView(shapeColor: .colorBlue, shapeOpacity: 0.2)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(.easeOut(duration: 4).repeatForever(autoreverses: true),value: isAnimating)
            }
            
            // MARK: - CENTER
            
            Text("The time that leads to mastery is dependent on the intensity of our focus")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .fontWeight(.light)
                .padding()
            
            // MARK: - FOOTER
            Spacer()
            Button(action: {
                withAnimation{
                    playSound(sound: "success", type: "m4a")
                    isOnBoardingViewActive = true
                }
            }
                   , label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3,design: .rounded))
                    .fontWeight(.bold)
            })//: BUTTON
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        }
    }
}

#Preview {
    HomeView()
}
