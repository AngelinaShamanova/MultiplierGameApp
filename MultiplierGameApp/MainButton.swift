//
//  MainButton.swift
//  MultiplierGameApp
//
//  Created by Ангелина Шаманова on 7.1.23..
//

import SwiftUI

struct MainButton: View {
    var title: String
    var action: (()->())? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
        }
        .frame(width: UIScreen.main.bounds.width - 40,
               height: 50,
               alignment: .center)
        .background(.blue)
        .cornerRadius(8)
        .padding(.bottom)
    }
}
