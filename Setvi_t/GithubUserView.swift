//
//  ContentView.swift
//  Setvi_t
//
//  Created by Pavle on 30.4.24..
//

import SwiftUI

struct GithubUserView: View {
    
    @StateObject var viewModel: GithubUserViewModel
    
    var body: some View {
        
        if let errorMessage = viewModel.errorMessage {
            
            VStack {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.title2)
                    .padding()
            }
            
        } else {
            VStack {
                AsyncImage(url: URL(string: viewModel.avatarUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundColor (.secondary)
                    
                }
                .frame(width: 140)
                
                Text (viewModel.login)
                    .bold()
                    .font(.title3)
                
                Text(viewModel.bio)
                    .padding()
                
                Text (viewModel.company)
                    .bold()
                    .font(.title3)
                
                Spacer ()
                
            }
            .padding()
            .onAppear() {
                viewModel.getUser()
            }
        }
    }
}

