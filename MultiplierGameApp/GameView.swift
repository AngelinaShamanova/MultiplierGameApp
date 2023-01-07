//
//  GameView.swift
//  MultiplierGameApp
//
//  Created by Ангелина Шаманова on 26.12.22..
//

import SwiftUI

struct GameView: View {
    private let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var multiplierNumber: Int
    var coreRoundsCount: Int
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var choosenRandomValue = 1
    @State private var correctAnswer = 0
    @State private var activeAnswer: Int?
    
    @State private var answers = [Int]()
    
    @State private var isAnimated = false

    @State private var attempts = 0
    @State private var score = 0
    
    @State private var showAlert = false
    
    @State private var roundsCount = 0
    
    func answerColor(_ value: Int, isActive: Bool) -> Color {
        if isActive {
            return value == correctAnswer ? .green : .red
        } else {
            return .indigo
        }
    }
    
    var body: some View {
        VStack() {
            Button {
                dismiss()
            } label: {
                Image(systemName: "multiply.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.black)
                    
            }
            .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
            .padding(.trailing)

            Text("Score: \(score)/\(coreRoundsCount)")
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .padding([.leading, .bottom])
            Text("\(multiplierNumber) x \(choosenRandomValue) = ...")
                .font(.title.bold())
                .padding()
            Text("\(message())")
                .padding()
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(answers, id: \.self) { value in
                    BlockItem(value: value,
                              isActiveBlock: activeAnswer == value,
                              forceColor: answerColor(value,
                                                      isActive: activeAnswer == value))
                        .onTapGesture {
                            activeAnswer = value
                            isAnimated = true
                            checkForAnswer()
                        }
                        .scaleEffect(activeAnswer == value && isAnimated ? 1.2 : 1)
                        .animation(.default, value: activeAnswer == value && isAnimated)
                }
            }
            .customGrid()
            Spacer()
            MainButton(title: "Continue") {
                startGame()
            }
        }
        .onAppear {
            startGame()
        }
        .alert("Game over", isPresented: $showAlert) {
            Button("Start again with same multiplier", role: .cancel) {
                resetGame()
            }
            Button("Finish", role: .destructive, action: {
                dismiss()
            })
        } message: {
            Text("Score: \(score)/\(coreRoundsCount)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.teal)
        .foregroundColor(.white)
    }
    
    func checkForAnswer() {
        roundsCount += 1
        attempts += 1
        if activeAnswer == correctAnswer && attempts == 1 {
            score += 1
        }
        checkForRounds()
    }
    
    func checkForRounds() {
        if roundsCount == coreRoundsCount {
            showAlert = true
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func message() -> String {
        activeAnswer == nil
        ?
        "Waiting for your answer..."
        : activeAnswer == correctAnswer ? "Well done!" : "Nope :("
    }
    
    func startGame() {
        answers = []
        attempts = 0
        activeAnswer = nil
        isAnimated = false
        
        let value = Int.random(in: 1...9)
        choosenRandomValue = value
        correctAnswer = multiplierNumber * choosenRandomValue
        for value in 1...8 {
            answers.append(correctAnswer + value)
        }
        answers.insert(correctAnswer, at: Int.random(in: 0...8))
    }
    
    func resetGame() {
        roundsCount = 0
        score = 0
        startGame()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(multiplierNumber: 2, coreRoundsCount: 2)
    }
}
