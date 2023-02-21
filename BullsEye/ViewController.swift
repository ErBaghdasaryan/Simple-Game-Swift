//
//  ViewController.swift
//  BullsEye
//
//  Created by Er Baghdasaryan on 19.01.23.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var raundLabel: UILabel!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var slider: UISlider!
    
    var targetValue = 0
    var currentValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }
    
    @IBAction func showAlert() {
        currentValue = Int(slider.value)
        var difference: Int
            if currentValue > targetValue {
                difference = currentValue - targetValue
            } else if targetValue > currentValue {
                difference = targetValue - currentValue
            } else {
                difference = 0
            }
        
        var points = 100 - difference
        score += points
        let title: String
          if difference == 0 {
              title = "Perfect!"
              points += 100
          } else if difference < 5 {
              title = "You almost had it!"
              if difference == 1 {
                  points += 50
              }
            } else if difference < 10 {
                title = "Pretty good!"
              } else {
                  title = "Not even close..."
                }
        score += points
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
      
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                self.startNewRound()
              })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
//        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        if (currentValue - targetValue) == 0 {
            round += 1
        }
        
        targetValue = Int.random(in: 1...100)
       // currentValue = 50
        slider.value = 50
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        raundLabel.text = String(round)
    }
    
    @IBAction func startNewGame() {
      score = 0
      round = 0
      startNewRound()
        let transition = CATransition()
          transition.type = CATransitionType.fade
          transition.duration = 1
          transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
          view.layer.add(transition, forKey: nil)
    }
    
    @IBAction func startOver() {
      startNewGame()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("done")
    }
}



