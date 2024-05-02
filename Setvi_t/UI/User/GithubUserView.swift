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
    @State private var isDetailsView = false
    @State private var navigateToDetail = false
    
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
            .frame(width: 120)
            
            if viewModel.isNotEmptyScreen {
                
                Group {
                    Text(viewModel.login)
                        .bold()
                        .font(.title)
                    Text(viewModel.bio)
                        .font(.caption)
                    Text(viewModel.company)
                        .font(.caption)

                    NavigationLink {
                        Text(viewModel.login)
                    } label: {
                        HStack {
                            Text("More detail")
                            Image(systemName: "chevron.right")
                                .bold()
                        }
                        .foregroundColor(.blue)
                        
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
            }
            
            Spacer ()
            
            HStack {
                
                TextField("Enter search text", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                Spacer()
                
                SearchButton {
                    viewModel.getUser(forName: searchText)
                }
            }
            
        }
        .modifier(DismissKeyboardOnTap())
        .navigationTitle(viewModel.navigationTitle)
        .modifier(FontSizeBoundaryModifier())
        .padding()
        .sheet(isPresented: $viewModel.showErrorAlert) {
            ErrorView(errorMessage: viewModel.errorMessage)
        }
    }
}

