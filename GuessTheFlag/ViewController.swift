//
//  ViewController.swift
//  HwS Project2
//
//  Created by Shubham Lekhak on 14/02/2023.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var resetGame: UIButton!
    
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        finalScore()
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        questionsAsked += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased())       Score = \(score)"
        finalScore()
       
    }
    
    @objc func showScore() {
        let title = "Score"
        let scoreAC = UIAlertController(title: title, message: "Your present score is \(score)", preferredStyle: .alert)
        scoreAC.addAction(UIAlertAction(title: "OK", style: .default))
        present(scoreAC, animated: true)
    }
    
    func finalScore() {
        if questionsAsked > 10 {
            let title = "You Won"
           
            let newAC = UIAlertController(title: title, message: "Your final score is \(score)", preferredStyle: .alert)
                
            newAC.addAction(UIAlertAction(title: "Reset Game", style: .destructive,handler: resetGameTo))
            newAC.addAction(UIAlertAction(title: "OK", style: .default))
            present(newAC, animated: true)
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
        }
    }
    
    func resetGameTo(action: UIAlertAction! = nil) {
        score = 0
        questionsAsked = 0
        askQuestion()
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
            
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
            
        }
       
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
        
    }
    
    
    @IBAction func resetGame(_ sender: UIButton) {
        score = 0
        questionsAsked = 0
        askQuestion()
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
    }
    
}

