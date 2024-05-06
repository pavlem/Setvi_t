//
//  UserAvatarView.swift
//  Setvi_t
//
//  Created by Pavle on 3.5.24..
//

import SwiftUI

struct UserAvatarView: View {
    
    @StateObject var viewModel: UserViewModel
    
    struct Constants {
        static let imageFrameWH = CGFloat(120)
        static let imageName = "person.crop.circle.fill"
        static let scaleEffect = CGFloat(1.5)
        static let circlePlaceHolderColour = Color.black.opacity(0.5)
    }
    
    var body: some View {
        
        ZStack {
            
            AsyncImage(url: URL(string: viewModel.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: Constants.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Colours.primary)
            }
            .clipShape(Circle())
            .frame(width: Constants.imageFrameWH)
            
            if viewModel.isLoading {
                ZStack {
                    Circle()
                        .frame(width: Constants.imageFrameWH)
                        .foregroundColor(Constants.circlePlaceHolderColour)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(Constants.scaleEffect)
                        .tint(Colours.primary)
                }
            }
        }
    }
}
