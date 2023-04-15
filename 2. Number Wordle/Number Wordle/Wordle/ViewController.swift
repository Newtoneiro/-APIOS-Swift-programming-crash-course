//
//  ViewController.swift
//  Wordle
//  Bartosz Latosek
//  Created by apios on 12/04/2023.
//

import Cocoa

class WordleLogic {
    let wordLen: Int
    var word: Array<String>
    let rounds: Int
    var currentRound: Int
    var cursorPosition: Int
    var gameOver: Bool
    
    init(rounds: Int) {
        self.wordLen = 5
        self.word = []
        for _ in 0...(self.wordLen - 1) {
            self.word.append(String(Int.random(in: 0..<9)))
        }
        print(self.word)
        self.rounds = rounds
        self.currentRound = 0
        self.cursorPosition = 0
        self.gameOver = false
    }
    
    func check(row: Array<NSTextField?>){
        if self.gameOver{
            return
        }
        var curCell: Int = 0
        var score: Int = 0
        for cell in row {
            if (cell!.stringValue == self.word[curCell]) {
                cell!.backgroundColor = NSColor.green
                score += 1
            }
            else if (self.word.contains(cell!.stringValue)){
                cell!.backgroundColor = NSColor.orange
            }
            else {
                cell!.backgroundColor = NSColor.red
            }
            curCell += 1
        }
        if (score == wordLen || self.currentRound == self.rounds - 1) {
            self.gameOver = true
            return
        }
        self.currentRound += 1
    }
}

class ViewController: NSViewController {
    
    @IBOutlet weak var label11: NSTextField!
    @IBOutlet weak var label12: NSTextField!
    @IBOutlet weak var label13: NSTextField!
    @IBOutlet weak var label14: NSTextField!
    @IBOutlet weak var label15: NSTextField!
    
    @IBOutlet weak var label21: NSTextField!
    @IBOutlet weak var label22: NSTextField!
    @IBOutlet weak var label23: NSTextField!
    @IBOutlet weak var label24: NSTextField!
    @IBOutlet weak var label25: NSTextField!
    
    @IBOutlet weak var label31: NSTextField!
    @IBOutlet weak var label32: NSTextField!
    @IBOutlet weak var label33: NSTextField!
    @IBOutlet weak var label34: NSTextField!
    @IBOutlet weak var label35: NSTextField!
    
    @IBOutlet weak var label41: NSTextField!
    @IBOutlet weak var label42: NSTextField!
    @IBOutlet weak var label43: NSTextField!
    @IBOutlet weak var label44: NSTextField!
    @IBOutlet weak var label45: NSTextField!
    
    var wordleLogic: WordleLogic!
    
    var roundsRows: Array<Array<NSTextField?>>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let row1 = [label11, label12, label13, label14, label15]
        let row2 = [label21, label22, label23, label24, label25]
        let row3 = [label31, label32, label33, label34, label35]
        let row4 = [label41, label42, label43, label44, label45]
        self.roundsRows = [row1, row2, row3, row4]
        self.wordleLogic = WordleLogic(rounds: self.roundsRows.count)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func handleChangeCursor(_ sender: NSButton) {
        self.wordleLogic.cursorPosition = sender.tag
    }
    
    @IBAction func handleInput(_ sender: NSButton) {
        let roundRow: Array<NSTextField?> = self.roundsRows[self.wordleLogic.currentRound]
        let currentCell: NSTextField? = roundRow[self.wordleLogic.cursorPosition]
        currentCell?.stringValue = String(sender.tag)
    }
    
    @IBAction func handleCheck(_ sender: NSButton) {
        self.wordleLogic.check(row: self.roundsRows[self.wordleLogic.currentRound])
    }
    
    @IBAction func handleClear(_ sender: Any) {
        for cell in self.roundsRows[self.wordleLogic.currentRound] {
            cell?.stringValue = ""
        }
    }
    
    @IBAction func handleRestart(_ sender: Any) {
        let row1 = [label11, label12, label13, label14, label15]
        let row2 = [label21, label22, label23, label24, label25]
        let row3 = [label31, label32, label33, label34, label35]
        let row4 = [label41, label42, label43, label44, label45]
        self.roundsRows = [row1, row2, row3, row4]
        
        for row in self.roundsRows {
            for cell in row {
                cell?.stringValue = ""
                cell?.backgroundColor = NSColor.white
            }
        }
                        
        self.wordleLogic = WordleLogic(rounds: self.roundsRows.count)
    }
}

