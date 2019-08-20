//
//  StopWatchViewController.swift
//  StopWatch
//
//  Created by RONIT NATH on 11/08/19.
//  Copyright © 2019 RONIT NATH. All rights reserved.
//

import UIKit

class StopWatchViewController : UIViewController
{
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var timer = Timer()
    var isTimerRunning =  false      /* Checks whether the timer is running or not */
    var counter = 0.0               /* Counts the number of milliseconds the timer has run */
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        resetButton.isEnabled = false           /* Initially reset and pause button are not required, since timer is not running */
        pauseButton.isEnabled = false
        startButton.isEnabled = true            /* Enable the start button to start the timer */
        
        timerLabel.layer.cornerRadius = 5.0
        timerLabel.layer.masksToBounds = true
        
        resetButton.layer.cornerRadius = 4.0
        resetButton.layer.masksToBounds = true
        resetButton.alpha = 0.5
        
        startButton.layer.cornerRadius = startButton.bounds.width / 2.0
        startButton.layer.masksToBounds = true
        
        pauseButton.layer.cornerRadius = pauseButton.bounds.width / 2.0
        pauseButton.layer.masksToBounds = true
        pauseButton.alpha = 0.5
        
    }
    
    
    @IBAction func resetAction(_ sender: Any)
    {
        timer.invalidate()
        isTimerRunning = false
        
        counter = 0.0
        timerLabel.text = "00:00:00.0"
        
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        
        resetButton.alpha = 0.5
        startButton.alpha = 1.0
        pauseButton.alpha = 0.5
        
    }
    

    @IBAction func pauseAction(_ sender: Any)
    {
        resetButton.isEnabled = true
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        resetButton.alpha = 1.0
        startButton.alpha = 1.0
        pauseButton.alpha = 0.5
        
        isTimerRunning = false
        timer.invalidate()
    }
    
    
    @IBAction func startAction(_ sender: Any)
    {
        if ( !isTimerRunning )
        {
            timer = Timer.scheduledTimer(timeInterval: 0.1 , target : self , selector: #selector(runTimer), userInfo: nil, repeats: true)
        }
        
        isTimerRunning = true
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        resetButton.isEnabled = true
        
        resetButton.alpha = 1.0
        startButton.alpha = 0.5
        pauseButton.alpha = 1.0
    
    }
    
    
    @objc func runTimer()
    {
        counter += 0.1                                       /* Increase the timer count by 0.1 seconds */

        let floorCounter = Int( floor ( counter ) )
        let hour = floorCounter / 3600

        let minutes = ( floorCounter % 3600 ) / 60
        var minuteString = "\(minutes)"
        if ( minutes < 10 )
        {
            minuteString = "0\(minutes)"
        }

        let seconds = ( floorCounter % 3600 ) % 60
        var secondString = "\(seconds)"
        if ( seconds < 10 )
        {
            secondString = "0\(seconds)"
        }

        let decisecond = String( format : "%.1f" , counter ).components(separatedBy: ".").last!

        timerLabel.text = "0\(hour):\(minuteString):\(secondString).\(decisecond)"
        
    }
    
}
