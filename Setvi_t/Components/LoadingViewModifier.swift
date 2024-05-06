//
//  LoadingViewModifier.swift
//  Setvi_t
//
//  Created by Pavle on 6.5.24..
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .tint(Colours.primary)
            } else {
                content
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colours.background.edgesIgnoringSafeArea(.all))
    }
}

extension View {
    func loadingView(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
