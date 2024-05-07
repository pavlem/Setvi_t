//
//  ErrorView.swift
//  Setvi_t
//
//  Created by Pavle on 2.5.24..
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    
    struct Constants {
        static let vStackSpacing = CGFloat(8)
        static let imageFrameWH = CGFloat(110)
        static let imageName = "exclamationmark.triangle.fill"
    }
    
    var body: some View {
        VStack(spacing: ErrorView.Constants.vStackSpacing) {
            Image(systemName: ErrorView.Constants.imageName)
                .resizable()
                .frame(width: ErrorView.Constants.imageFrameWH, height: ErrorView.Constants.imageFrameWH)
            Text(message)
                .font(.title2)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colours.background)
        .foregroundColor(Colours.error)
        .edgesIgnoringSafeArea(.all)
    }
}
