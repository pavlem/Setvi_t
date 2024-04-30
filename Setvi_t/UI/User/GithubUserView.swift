//
//  ContentView.swift
//  Setvi_t
//
//  Created by Pavle on 30.4.24..
//

import SwiftUI

struct GithubUserView: View {
    
    @StateObject var viewModel: GithubUserViewModel
    @State private var searchText = ""
    
    var body: some View {
        
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
            
            Text(viewModel.login)
                .bold()
                .font(.title3)
            
            Text(viewModel.bio)
                .padding()
            
            Text (viewModel.company)
                .bold()
                .font(.title3)
            
            TextField("Enter search text", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding()
            
            Button {
                viewModel.getUser(forName: searchText)
            } label: {
                Text("Search")
            }
            .padding()
            
            Spacer ()
        }
        .modifier(FontSizeBoundaryModifier())
        .padding()
//        .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorAlert) {
//            Button("OK", role: .cancel) { }
//        }
        .sheet(isPresented: $viewModel.showErrorAlert) {
            ErrorView(errorMessage: viewModel.errorMessage)
        }
    }
}

struct ErrorView: View {
    let errorMessage: String
    var body: some View {
        Text(errorMessage)
            .font(.title)
            .padding()
    }
}
