//
//  UserDetailsView.swift
//  Setvi_t
//
//  Created by Pavle on 30.4.24..
//

import SwiftUI

struct UserView: View {
    
    @StateObject var viewModel: UserViewModel
   
    @State private var enteredUser = "" {
        didSet { isSearchDisabled = enteredUser.count <= 3 }
    }
    @State private var navigateToDetail = false
    @State private var isSearchDisabled = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            UserAvatarView(viewModel: viewModel)
            
            VStack(spacing: 4) {
                
                userDescription(viewModel: viewModel)
                    .padding()
                
                NavigationLink {
                    RepositoriesView(
                        viewModel: RepositoriesViewModel(
                            user: viewModel.user,
                            networkManager: viewModel.networkManager
                        )
                    )
                } label: {
                    
                    Text(viewModel.moreDetails)
                        .foregroundColor(Colours.primary)
                }
            }
            
            Spacer ()
            
            HStack {
                userSearchTextField(viewModel: viewModel)
                
                Spacer()
                
                SearchButton(action: {
                    guard enteredUser.isEmpty == false else { return }
                    viewModel.getUser(forName: enteredUser)
                }, isDisabled: $isSearchDisabled)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            
        }
        .navigationTitle(viewModel.navigationTitle)
        .modifier(FontSizeBoundaryModifier())
        .sheet(isPresented: $viewModel.showErrorAlert) {
            ErrorView(message: viewModel.errorMessage)
        }
        .background(Colours.background)
    }
    
    //  Sample of a custom ViewBuilder function instead of a separate view struct allowing us to inject the view directly without creating a standalone component.
    @ViewBuilder
    private func userDescription(viewModel: UserViewModel) -> some View {
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
    private func userSearchTextField(viewModel: UserViewModel) -> some View {
        
        let characterLimit = 25
        
        TextField(viewModel.enterUser, text: $enteredUser)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .keyboardType(.alphabet)
            .textContentType(.oneTimeCode)
            .autocorrectionDisabled(true)
            .onReceive(enteredUser.publisher.collect()) { inputValue in
                let filtered = inputValue.compactMap { $0.isWhitespace ? nil : $0 }
                if filtered.count > characterLimit {
                    enteredUser = String(filtered.prefix(characterLimit))
                } else {
                    enteredUser = String(filtered)
                }
            }
            .onSubmit {
                guard enteredUser.isEmpty == false else { return }
                viewModel.getUser(forName: enteredUser)
            }
    }
}

