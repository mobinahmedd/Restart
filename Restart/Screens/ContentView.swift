//
//  ContentView.swift
//  Restart
//
//  Created by Apptycoons on 31/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: PROPERTIES
    
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = false
    
    // MARK: BODY

    var body: some View {
        ZStack{
            if isOnBoardingViewActive{
                OnBoardingView()
            }else{
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
