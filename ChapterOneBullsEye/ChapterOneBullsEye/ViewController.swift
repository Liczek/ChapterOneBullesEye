//
//  ViewController.swift
//  ChapterOneBullsEye
//
//  Created by Paweł Liczmański on 25/10/16.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var curentValue: Int = 0
    var targetValue: Int = 0
    
    @IBOutlet weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewRound()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        var message = "The value of the slider is: \(curentValue)" + "\nThe target value is: \(targetValue)"
        
        let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default, handler: nil)
        let action2 = UIAlertAction(title: "Can't be", style: .destructive, handler: nil)
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        present(alert, animated: true, completion: nil)
        
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        curentValue = lroundf(slider.value)
        print("The value of the slider is now: \(slider.value)")
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        curentValue = 50
        slider.value = Float(curentValue)
    }


}

