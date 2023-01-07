//
//  ContentView.swift
//  MultiplierGameApp
//
//  Created by Ангелина Шаманова on 26.12.22..
//

import SwiftUI

struct ContentView: View {
    private let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    @State private var isAnimated = false
    @State private var activeMultiplierNumber: Int?
    @State private var roundsCount = 5
    
    @State private var gameIsOpened = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose value")
                    .font(.title3.smallCaps())
                    .padding(.top)
                    .foregroundColor(.white)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1...9, id: \.self) { value in
                        BlockItem(value: value, isActiveBlock: activeMultiplierNumber == value)
                            .onTapGesture {
                                activeMultiplierNumber = value
                                isAnimated = true
                            }
                            .scaleEffect(activeMultiplierNumber == value && isAnimated ? 1.2 : 1)
                            .animation(.default, value: activeMultiplierNumber == value && isAnimated)
                    }
                }
                .customGrid()
                Spacer()
                VStack(alignment: .leading) {
                    Text("Rounds counter")
                        .font(.title3.smallCaps())
                    Stepper("\(roundsCount) rounds",
                            value: $roundsCount,
                            in: 5...40,
                            step: 5)
                }
                .padding(.all, 20)
                Spacer()
                MainButton(title: "Continue") {
                    gameIsOpened = true
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Multiplier Game")
            .foregroundColor(.white)
            .background(Color.teal)
            .fullScreenCover(isPresented: $gameIsOpened) {
                GameView(multiplierNumber: activeMultiplierNumber ?? 1, coreRoundsCount: roundsCount)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
