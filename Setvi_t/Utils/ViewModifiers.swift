//
//  FontSizeBoundaryModifier.swift
//  Setvi_t
//
//  Created by Pavle on 2.5.24..
//

import SwiftUI

struct FontSizeBoundaryModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .dynamicTypeSize(.medium ... .xxLarge)
    }
}

struct DismissKeyboardOnTap: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                hideKeyboard()
            }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
