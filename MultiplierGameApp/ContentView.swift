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
    @State private var questionsCount = 5
    
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
                Spacer()
                VStack(alignment: .leading) {
                    Text("Rounds counter")
                        .font(.title3.smallCaps())
                    Stepper("\(questionsCount) rounds",
                            value: $questionsCount,
                            in: 5...40,
                            step: 5)
                }
                .padding(.all, 20)
                Spacer()
                Button {
                    gameIsOpened = true
                } label: {
                    Text("Continue")
                }
                .frame(width: UIScreen.main.bounds.width / 2,
                       height: 50,
                       alignment: .center)
                .background(.blue)
                .cornerRadius(8)
                .padding(.bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Multiplier Game")
            .foregroundColor(.white)
            .background(Color.teal)
            .fullScreenCover(isPresented: $gameIsOpened) { GameView(multiplierNumber: activeMultiplierNumber ?? 1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
