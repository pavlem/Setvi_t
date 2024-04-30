//
//  ContentView.swift
//  Setvi_t
//
//  Created by Pavle on 30.4.24..
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            
            Circle()
                .foregroundColor (.secondary)
                .frame(width: 140)
            
            Text ("Username")
                .bold()
                .font(.title3)
            
            Text("Bio of the user")
                .padding()

            Spacer ()
            
        }
        .padding()
    }
}

struct GitUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
    let company: String?
}
