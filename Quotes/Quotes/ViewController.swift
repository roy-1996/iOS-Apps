//
//  ViewController.swift
//  Quotes
//
//  Created by RONIT NATH on 12/08/19.
//  Copyright © 2019 RONIT NATH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var changeAuthorImage: UIImageView!
    @IBOutlet weak var changeQuoteLabel: UILabel!
    
    
    let newQuotes : [String] = ["I have no special talent. I am only passionately curious. " + "\n" + "- Albert Einstein",
                                "Your time is limited. Do not waste it living someone else' life. " + "\n" +  "- Steve Jobs",
                                "If you judge people, you have no time to love them. " + "\n" + "- Mother Teresa",
                                "The weak can never forgive. Forgiveness is the attribute of the strong. " + "\n" + "- Mahatma Gandhi",
                                "God helps those that help themselves" + "\n" + "- Benjamin Franklin"  ]
    
    let authors : [String] = [ "einstein" , "steve-jobs-" , "mt1" , "mg1" , "befr1" ]
    var prev_num = 1
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        changeQuoteLabel.text = newQuotes[1]
        changeAuthorImage.image = UIImage(named: authors[1])
        
    }
    
    func generateRandomNumber() -> Int{
        
        let randomNumber = arc4random_uniform(UInt32(newQuotes.count))
        return Int(randomNumber)
    }


    
    @IBAction func inspireMeButton(_ sender: Any)
    {
        var num = generateRandomNumber()
        
        print("\(prev_num)" + " " + "\(num)")
        
        if ( prev_num == num )
        {
            while( prev_num == num )
            {
                num = generateRandomNumber()
            }
        }
        
        print(num)
        
        changeQuoteLabel.text = newQuotes[num]
        changeAuthorImage.image = UIImage(named: authors[num])
        prev_num = num
        
    }
    
}

