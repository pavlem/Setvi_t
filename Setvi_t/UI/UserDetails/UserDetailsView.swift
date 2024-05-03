//
//  UserDetailsView.swift
//  Setvi_t
//
//  Created by Pavle on 30.4.24..
//

import SwiftUI

struct UserDetailsView: View {
    
    @StateObject var viewModel: UserDetailsViewModel
    
    @State private var searchText = ""
    @State private var navigateToDetail = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            UserAvatarView(viewModel: viewModel)
            
            if viewModel.isNotEmptyScreen {
                
                VStack(spacing: 4) {
                    
                    userDescription(viewModel: viewModel)
                        .padding()
                    
                    NavigationLink {
                        Text(viewModel.username)
                    } label: {
                        
                        HStack {
                            Text(viewModel.moreDetails)
                            Image(systemName: "chevron.right")
                                .bold()
                        }
                        .foregroundColor(Colours.primary)
                    }
                }
            }
            
            Spacer ()
            
            HStack {
                userSearchTextField(viewModel: viewModel)
                
                Spacer()
                
                SearchButton {
                    guard searchText.isEmpty == false else { return }
                    viewModel.getUser(forName: searchText)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            
        }
        .navigationTitle(viewModel.navigationTitle)
        .modifier(FontSizeBoundaryModifier())
        .sheet(isPresented: $viewModel.showErrorAlert) {
            ErrorView(errorMessage: viewModel.errorMessage)
        }
        .background(Colours.background)
    }
    
    //  Sample of a custom ViewBuilder function instead of a separate view struct allowing us to inject the view directly without creating a standalone component.
    @ViewBuilder
    private func userDescription(viewModel: UserDetailsViewModel) -> some View {
        VStack(spacing: 4) {
            Text(viewModel.username)
                .font(.title)
            Group {
                Text(viewModel.biography)
                Text(viewModel.company)
            }
            .font(.footnote)
        }
        .bold()
    }
    
    @ViewBuilder
    private func userSearchTextField(viewModel: UserDetailsViewModel) -> some View {
        
        let characterLimit = 10
        
        TextField(viewModel.enterUser, text: $searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .keyboardType(.alphabet)
            .textContentType(.oneTimeCode)
            .autocorrectionDisabled(true)
            .onReceive(searchText.publisher.collect()) { inputValue in
                let filtered = inputValue.compactMap { $0.isWhitespace ? nil : $0 }
                if filtered.count > characterLimit {
                    searchText = String(filtered.prefix(characterLimit))
                } else {
                    searchText = String(filtered)
                }
            }
            .onSubmit {
                guard searchText.isEmpty == false else { return }
                viewModel.getUser(forName: searchText)
            }
    }
}

