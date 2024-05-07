//
//  RepositoryCell.swift
//  Setvi_t
//
//  Created by Pavle on 6.5.24..
//

import SwiftUI

struct RepositoryCell: View {
    
    var viewModel: RepositoryCellViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(viewModel.subtitle)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Colours.primary)
        }
        .modifier(FontSizeBoundaryModifier())
        .bold()
    }
}
