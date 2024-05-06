//
//  CommitsView.swift
//  Setvi_t
//
//  Created by Pavle on 6.5.24..
//

import SwiftUI

struct CommitsView: View {
    
    @StateObject var viewModel: CommitsViewModel
    
    var body: some View {
        
        List(viewModel.commits) { commit in
            CommitCell(viewModel: CommitCellViewModelImpl.create(from: commit))
                .listRowBackground(Colours.background)
        }
        .navigationTitle(viewModel.title)
        .listStyle(PlainListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colours.background.edgesIgnoringSafeArea(.all))
        .loadingView(isLoading: $viewModel.isLoading)
    }
}


