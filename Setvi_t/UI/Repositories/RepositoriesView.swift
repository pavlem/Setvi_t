//
//  UserReposView.swift
//  Setvi_t
//
//  Created by Pavle on 4.5.24..
//

import SwiftUI

struct RepositoriesView: View {
    
    @StateObject var viewModel: RepositoriesViewModel
    
    var body: some View {
        
        List(viewModel.gitRepos) { repo in
            NavigationLink {
                CommitsView(viewModel: CommitsViewModel(user: viewModel.userName, repo: repo.name, networkManager: viewModel.networkManager))
            } label: {
                RepositoryCell(viewModel: RepositoryCellViewModelImpl(repo: repo))
            }
            .listRowBackground(Colours.background)
        }
        .navigationTitle(viewModel.title)
        .listStyle(PlainListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colours.background.edgesIgnoringSafeArea(.all))
        .loadingView(isLoading: $viewModel.isLoading)
    }
}
