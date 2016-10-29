//
//  ViewController.swift
//  ChapterOneBullsEye
//
//  Created by Paweł Liczmański on 25/10/16.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var curentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame()
        updateLabels()
        
        
        // Slider
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        
        slider.isEnabled = true
        let difference: Int = abs(curentValue - targetValue)
        var points = 100 - difference
        
        
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        }
        else if difference <= 10 {
            title = "You almost had it!"
            if difference == 1{
                points += 50
            }
        }
        else if difference <= 25{
            title = "Srsly ?!"
        }
        else {
            title = "Retard"
        }
        
        let message = "The value of the slider is: \(curentValue)" + "\nThe target value is: \(targetValue)" + "\nYou scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        score = score + points  // score += points
        
        let action1 = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
            self.updateLabels()
            
        })
        let action2 = UIAlertAction(title: "Can't be, I wanna check", style: .destructive, handler: {
            action in
            self.slider.isEnabled = false
            self.score = self.score - points})
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        curentValue = lroundf(slider.value)
        print("The value of the slider is now: \(slider.value)")
    }
    
    func startNewRound() {
        newTargetValue()
        curentValue = 50
        slider.value = Float(curentValue)
        round += 1
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
    }
    
    func startNewGame() {
        score = 0
        round = 0
        
        startNewRound()
    }
    
    func newTargetValue() {
        targetValue = 1 + Int(arc4random_uniform(100))
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    

}

