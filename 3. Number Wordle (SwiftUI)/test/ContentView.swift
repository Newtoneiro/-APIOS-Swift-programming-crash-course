//
//  ContentView.swift
//  test
//
//  Created by apios on 26/04/2023.
//

import SwiftUI

class WordleLogic: ObservableObject {
    let wordLen: Int
    var word: Array<String>
    let rounds: Int
    @Published var currentRound: Int
    @Published var cursorPosition: Int
    @Published var gameOver: Bool
    @Published var fieldRows: Array<GuessingRow>
    
    init() {
        self.wordLen = 5
        self.word = []
        for _ in 0...(self.wordLen - 1) {
            self.word.append(String(Int.random(in: 0..<9)))
        }
        print(self.word)
        self.rounds = 4
        self.currentRound = 0
        self.cursorPosition = 0
        self.gameOver = false
        self.fieldRows = []
        for _ in (0 ..< self.rounds) {
            self.fieldRows.append(GuessingRow())
        }
    }
    
    func setFieldRowVal(newVal: String) {
        self.fieldRows[currentRound].setValue(i: cursorPosition, newValue: newVal)
    }
    
    func check(){
        if self.gameOver{
            return
        }
        var curCell: Int = 0
        var score: Int = 0
        for cell in self.fieldRows[currentRound].fields {
            if (cell.value == self.word[curCell]) {
                self.fieldRows[currentRound].fields[curCell].setColor(newColor: .green)
                score += 1
            }
            else if (self.word.contains(cell.value)){
                self.fieldRows[currentRound].fields[curCell].setColor(newColor: .yellow)
            }
            else {
                self.fieldRows[currentRound].fields[curCell].setColor(newColor: .red)
            }
            curCell += 1
        }
        if (score == wordLen || self.currentRound == self.rounds - 1) {
            self.gameOver = true
            return
        }
        self.currentRound += 1
    }
    
    func clear() {
        for i in (0 ..< 5) {
            self.fieldRows[currentRound].fields[i].setValue(newValue: "")
        }
    }
    
    func reset() {
        self.word = []
        for _ in 0...(self.wordLen - 1) {
            self.word.append(String(Int.random(in: 0..<9)))
        }
        print(self.word)
        self.currentRound = 0
        self.cursorPosition = 0
        self.gameOver = false
        self.fieldRows = []
        for _ in (0 ..< self.rounds) {
            self.fieldRows.append(GuessingRow())
        }
    }
}

struct Field: Hashable {
    var value: String
    var color: Color
    
    init() {
        self.value = ""
        self.color = .white
    }
    
    mutating func setValue(newValue: String) {
        self.value = newValue
    }
    
    mutating func setColor(newColor: Color) {
        self.color = newColor
    }
}

struct GuessingRow: View, Hashable {
    var fields : Array<Field>
    
    init() {
        self.fields = [Field(), Field(), Field(), Field(), Field()]
    }
    
    mutating func setValue(i: Int, newValue: String) {
        self.fields[i].setValue(newValue: newValue)
    }
    
    var body: some View {
        HStack {
            ForEach (self.fields, id: \.self) {
                field in Text("\(field.value)")
                    .frame(width: 50.0, height: 50.0)
                    .background(Rectangle().fill(field.color))
                    .border(.black)
                    .padding(10)
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var wordleLogic: WordleLogic

    init() {
        self.wordleLogic = WordleLogic()
    }
    
    func setCurCol(newCol: Int) {
        self.wordleLogic.cursorPosition = newCol
    }
    
    var body: some View {
        VStack {
            VStack{
                ForEach (0 ..< self.wordleLogic.fieldRows.capacity, id: \.self) {
                    index in self.wordleLogic.fieldRows[index]
                }
            }
            HStack {
                ForEach (0 ..< 5) {
                    col in Button(action: {self.setCurCol(newCol: col)}) {
                        Text("^")
                            .foregroundColor(self.wordleLogic.cursorPosition == col ? .red : .black)
                    }
                }
            }
            VStack {
                ForEach (0 ..< 2) {
                    row in HStack {
                        ForEach (0 ..< 5) {
                            col in Button(action: {self.wordleLogic.setFieldRowVal(newVal: String(5 * row + col))}) {
                                Text("\(5 * row + col)")
                            }
                        }
                    }
                }
            }
            HStack {
                Button(action: {self.wordleLogic.check()}) {
                    Text("Check")
                }
                Button(action: {self.wordleLogic.clear()}) {
                    Text("Clear")
                }
                Button(action: {self.wordleLogic.reset()}) {
                    Text("Reset")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
