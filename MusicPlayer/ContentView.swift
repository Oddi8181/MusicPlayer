//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Ivan Odrljin on 04.10.2025..
//

import SwiftUI




struct ContentView: View {
    var body: some View {
  
        ZStack{
            Color(.darkGray)
                .ignoresSafeArea()
            VStack{
                Image(.pocetna)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .position(x: 200, y: 300)
                // time of music
                HStack{
                    controlButton(title: "Play"
                                  ,systemImage: "play.fill",
                                  action: {print("Start music")})
                    controlButton(title: "Pause", systemImage: "pause.fill", action: {print("Pause")})
                    
                }
                    
            }
        }

    }
}


#Preview {
    ContentView()
}
