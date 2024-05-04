//
//  UserReposView.swift
//  Setvi_t
//
//  Created by Pavle on 4.5.24..
//

import SwiftUI

struct UserReposView: View {
    
    let viewModel: UserReposViewModel
    
    var body: some View {
        
        ZStack {
            Colours.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Hello!")
                Text(viewModel.userName)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Colours.background)
        }
    }
    
}

//#Preview {
//    UserReposView(viewModel: UserReposViewModel(userName: "pavlem"))
//}
