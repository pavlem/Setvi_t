//
//  SearchButton.swift
//  Setvi_t
//
//  Created by Pavle on 2.5.24..
//

import SwiftUI

struct SearchButton: View {
    
    var action: () -> Void
    
    @State private var scale: CGFloat = 1.0
    @Binding var isDisabled: Bool

    var body: some View {
        Button {
            
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)) {
                scale += 0.1
                resetScale()
            }
        } label: {
            Image(systemName: "magnifyingglass")
                .foregroundColor(isDisabled ? .gray : Colours.primary)
                .font(.title)
        }
        .disabled(isDisabled)
        .scaleEffect(scale)
    }

    private func resetScale() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                scale = 1.0
                action()
            }
        }
    }
}


