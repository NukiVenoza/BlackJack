//
//  Onboarding.swift
//  NanoChallenge2
//
//  Created by Nuki Venoza on 25/05/23.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        
            TabView {
                VStack{
                    Image("onboard1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 304, height: 324)

                    Text("Play with friends")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 50)
                        
                    Text("Play blackjack with your friends with machine learning technology.")
                        .font(.headline)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                        .frame(width: 340)
                    
                    
                    HStack{
                        Circle()
                            .frame(width: 10)
                            .foregroundColor(Color(red: 42/255, green: 133/255, blue: 76/255))
                        
                        Circle()
                            .frame(width: 10)
                            .foregroundColor(Color(red: 159/255, green: 198/255, blue: 185/255))
                    }
                    .padding(.top, 50)
                    
                }
                
                .tabItem {
                    Text("page1")
                }
                
                VStack{
                    Image("onboard2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 324, height: 346)
                        .padding(.top, 50)

                    Text("Scan your cards")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                        
                    Text("The app will automatically scan your card and able to identify the value of the card inside the frame.")
                        .font(.headline)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                        .frame(width: 340)
                    
                    
                    HStack{
                        Circle()
                            .frame(width: 10)
                            .foregroundColor(Color(red: 159/255, green: 198/255, blue: 185/255))
                        
                        Circle()
                            .frame(width: 10)
                            .foregroundColor(Color(red: 42/255, green: 133/255, blue: 76/255))
                    }
                    .padding(.top, 30)
                    
                    NavigationLink(destination: HostedViewController().ignoresSafeArea()){
                        Spacer()
                        Text("Next")
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(width: .infinity, height: 60)
                    .background(Color(red: 140/255.0, green: 0/255.0, blue: 5/255.0))
                    .cornerRadius(12)
                    .padding(.horizontal, 55)
                    .padding(.top, 20)
                }
                .tabItem {
                    Text("page2")
                }
                
            }
//            .navigationDestination(for: String.self) { _ in
//                HostedViewController()
//                    .ignoresSafeArea()
//            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .navigationBarBackButtonHidden()
    }
    
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
