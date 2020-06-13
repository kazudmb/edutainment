//
//  ContentView.swift
//  edutainment
//
//  Created by KazukiNakano on 2020/06/13.
//  Copyright © 2020 kazu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAnswer = ""
    @State private var numberOfQuestion = 0
    let numberOfQuestions = ["5", "10", "20", "ALL"]
    
    @State private var formula = ""
    @State private var dictionaryOffset = 0
    @State private var dictionary: [String: Int] = [:]
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        NavigationView{
            Form {
                // TODO: 指定した問題数に来たら、alertを出してResultを表示、その後Resetsさせる
                Section(header: Text("How much question do you want?")) {
                    Picker("Question", selection: $numberOfQuestion) {
                        ForEach(0 ..< numberOfQuestions.count) {
                            Text("\(self.numberOfQuestions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    Text("\(formula)")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .onAppear {
                            self.edutainmentResult()
                    }
                }
                
                Section {
                    TextField("Answer", text: $checkAnswer,
                              onCommit: {
                                self.answerEntered(Int(self.checkAnswer) ?? 0)
                    })
                }
                
                HStack {
                    Text("Your score is")
                        .foregroundColor(.black)
                    Text("\(score)")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
            }
            .navigationBarTitle("edutainment")
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                    // TODO: 九九の問題を次の問題に移す
                    self.dictionaryOffset += 1
                    self.checkAnswer = ""
                    })
            }
        }
    }
    
    func answerEntered(_ answer: Int) {
                if answer == dictionary[formula] {
                    scoreTitle = "Correct"
                    score += 1
                } else {
                    scoreTitle = "Wrong! Correct answer is \(dictionary[formula])"
                    score = 0
                }
        
                showingScore = true
    }
    
    func edutainmentResult() -> [String: Int] {
        
        for i in 1...9 {
            for j in 1...9 {
                let key = "\(i) × \(j)"
                let value = i * j
                dictionary[key] = value
            }
        }
        formula = dictionary.keys[dictionary.index(dictionary.startIndex, offsetBy: dictionaryOffset)]
        
        return dictionary
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
