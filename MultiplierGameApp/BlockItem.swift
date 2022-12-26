//
//  BlockItem.swift
//  MultiplierGameApp
//
//  Created by Ангелина Шаманова on 26.12.22..
//

import SwiftUI

struct BlockItem: View {
    var value: Int
    var isActiveBlock: Bool
    var forceColor: Color?
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title.bold())
        }
        .frame(width: 80, height: 80)
        .background(forceColor == nil ? blockColor(value, isActiveBlock: isActiveBlock) : forceColor)
        .cornerRadius(4)
    }
    
    private func blockColor(_ value: Int, isActiveBlock: Bool) -> Color {
        if isActiveBlock {
            return Color.green
        } else {
            switch value {
            case 1...3:
                return Color.yellow
            case 4...6:
                return Color.blue
            default:
                return Color.indigo
            }
        }
    }
}
