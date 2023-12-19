//
//  ViewController.swift
//  TicTacToe
//
//  Created by Grace Salazar on 12/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case X
        case O
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var xsScoreValue: UILabel!
    @IBOutlet weak var osScoreValue: UILabel!
    
    // first turn gets Xs
    var firstTurn = Turn.X
    var currentTurn = Turn.X
    
    var EX = "X"
    var OH = "O"
    var board = [UIButton]()
    
    var xsScore = 0
    var osScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if (checkForWin(EX)) {
            xsScore += 1
            updateScoreBoard()
            resultAlert(title: "Xs Win!")
        }
        if (checkForWin(OH)) {
            osScore += 1
            updateScoreBoard()
            resultAlert(title: "Os Win!")
        }
        
        if (fullBoard()) {
            resultAlert(title: "Draw")
        }
        
    }
    
    func checkForWin(_ s :String) -> Bool {
        let wins: [[UIButton]] = [[a1, a2, a3], [b1, b2, b3], [c1, c2, c3], // horizontals
                                 [a1, b1, c1], [a2, b2, c2], [a3, b3, c3], // verticals
                                 [a1, b2, c3], [a3, b2, c1]] // diagnols
        for scenario in 0..<wins.count {
            if thisSymbol(wins[scenario][0], s) && thisSymbol(wins[scenario][1], s) && thisSymbol(wins[scenario][2], s) {
                return true
            }
        }
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let message = "\nOs " + String(osScore) + "\nXs " + String(xsScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true // enable use of buttons again
        }
        if (firstTurn == Turn.O) {
            firstTurn = Turn.X
            turnLabel.text = EX
        }
        else if (firstTurn == Turn.X) {
            firstTurn = Turn.O
            turnLabel.text = OH
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if (sender.title(for: .normal) == nil) {
            if (currentTurn == Turn.O) {
                sender.setTitle(OH, for: .normal)
                currentTurn = Turn.X
                turnLabel.text = EX
            }
            else if (currentTurn == Turn.X) {
                sender.setTitle(EX, for: .normal)
                currentTurn = Turn.O
                turnLabel.text = OH
            }
            sender.isEnabled = false // disable use of button after it has been set
        }
    }
    
    func updateScoreBoard() {
        xsScoreValue.text = String(xsScore)
        osScoreValue.text = String(osScore)
        if (xsScore > osScore) { // make xs score label text bold
            
        }
        if (osScore > xsScore) { // make os score label bold
            
        }
    }
    
}
