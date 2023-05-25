//
//  ContentView.swift
//  NanoChallenge2
//
//  Created by Nuki Venoza on 20/05/23.
//

import SwiftUI
import UIKit
import AVFoundation

struct ContentView: View {
    var body: some View {
//        HostedViewController()
//            .ignoresSafeArea()
        
        HomeView()
            .preferredColorScheme(.light)
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
