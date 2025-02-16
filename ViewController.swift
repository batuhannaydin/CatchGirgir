//
//  ViewController.swift
//  GırgırıYakala
//
//  Created by Batuhan Aydın on 16.02.2025.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    
    var timer = Timer()
    var counter = 0
    
    var hideTimer = Timer()
    
    var girgirArray = [UIImageView]()
    
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var gırgır1: UIImageView!
    @IBOutlet weak var gırgır3: UIImageView!
    @IBOutlet weak var gırgır2: UIImageView!
    @IBOutlet weak var gırgır4: UIImageView!
    @IBOutlet weak var gırgır5: UIImageView!
    @IBOutlet weak var gırgır6: UIImageView!
    @IBOutlet weak var gırgır7: UIImageView!
    @IBOutlet weak var gırgır8: UIImageView!
    @IBOutlet weak var gırgır9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        girgirArray = [gırgır1, gırgır2, gırgır3, gırgır4, gırgır5, gırgır6, gırgır7, gırgır8, gırgır9]
        
        let CurrentHighScore = UserDefaults.standard.integer(forKey: "HighScore")
        
        if CurrentHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
            
        }
        
        if let newScore = CurrentHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
            
        }
        
        for i in girgirArray {
            i.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            i.addGestureRecognizer(gestureRecognizer)
        }

        
        counter = 15
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideGirgir), userInfo: nil, repeats: true)
        
        hideGirgir()
    }
    
    var gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "High Score: \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
        let alert = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            let replayButton = UIAlertAction(title: "Replay", style: .default) { (_) in
                self.score = 0
                self.counter = 15
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideGirgir), userInfo: nil, repeats: true)
            }
        
            alert.addAction(okButton)
            alert.addAction(replayButton)
            
            // alert'i gösterme
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func hideGirgir() {
        for girgir in girgirArray {
            girgir.isHidden = true
        }
        
        var random = Int(arc4random_uniform(UInt32(girgirArray.count - 1)))
        girgirArray[random].isHidden = false
    }

}

