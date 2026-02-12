//
//  HelperFunctions.swift
//  MusicPlayer
//
//  Created by Ivan Odrljin on 04.10.2025..
//
import SwiftUI

//Buttons
func controlButton(title: String, systemImage: String, action: @escaping () -> Void) -> some View{
    Button(action: action){
        HStack{
            Image(systemName: systemImage)
        }
    }
    .font(.title2)
    .padding()
    .background(Color.black)
    .foregroundColor(.brown )
    .cornerRadius(12)
    


}

