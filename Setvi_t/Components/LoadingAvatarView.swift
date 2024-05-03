//
//  UserAvatarView.swift
//  Setvi_t
//
//  Created by Pavle on 3.5.24..
//

import SwiftUI

struct UserAvatarView: View {
    
    @StateObject var viewModel: UserDetailsViewModel
    
    var body: some View {
        
        ZStack {
            
            AsyncImage(url: URL(string: viewModel.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Colours.primary)
            }
            .clipShape(Circle())
            .frame(width: 120)
            
            if viewModel.isFetchingUser {
                ZStack {
                    Circle()
                        .frame(width: 120)
                        .foregroundColor(Color.black.opacity(0.5))
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .tint(Colours.primary)
                }
            }
        }
    }
}
