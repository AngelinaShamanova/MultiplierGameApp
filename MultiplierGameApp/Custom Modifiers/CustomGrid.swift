//
//  CustomGrid.swift
//  MultiplierGameApp
//
//  Created by Ангелина Шаманова on 7.1.23..
//

import SwiftUI

struct CustomGrid: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: UIScreen.main.bounds.width - 20, alignment: .center)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
    }
}
