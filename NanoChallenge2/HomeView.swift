//
//  HomeView.swift
//  NanoChallenge2
//
//  Created by Nuki Venoza on 22/05/23.
//

import SwiftUI
import UIKit

struct HomeView: View {
    var body: some View {
         NavigationView{
            ZStack{
                Color(red: 17/255, green: 118/255, blue: 106/255)
                    .ignoresSafeArea()
                
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.3)
                    .ignoresSafeArea(.all)
                
                VStack {
                    Image("logoBlackjack")
                        .resizable()
                        .frame(width: 259, height: 275)
                    
                    NavigationLink(destination: Onboarding()){
                        Text("Start")
                    }
                    .padding()
                    .foregroundColor(Color(red: 241/255.0, green: 241/255.0, blue: 241/255.0))
                    .font(.title2)
                    .frame(width: 110, height: 60)
                    .border(.black, width: 2)
                    .background(Color(red: 140/255.0, green: 0/255.0, blue: 5/255.0))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.top, 70)
                    
                }
            
                
            }
            
        }
        .accentColor(Color(red: 140/255.0, green: 0/255.0, blue: 5/255.0))

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
