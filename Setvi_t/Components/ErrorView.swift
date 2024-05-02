//
//  ErrorView.swift
//  Setvi_t
//
//  Created by Pavle on 2.5.24..
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    var body: some View {
        Text(errorMessage)
            .font(.title)
            .padding()
    }
}

