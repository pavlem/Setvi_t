//
//  CommitCell.swift
//  Setvi_t
//
//  Created by Pavle on 6.5.24..
//

import SwiftUI

struct CommitCell: View  {
    
    var viewModel: CommitCellViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.userName)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(viewModel.email)
                .font(.caption)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(viewModel.commitDate)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Colours.primary)
        }
        .modifier(FontSizeBoundaryModifier())
    }
}
