//
//  GameViewController.swift
//  barabara
//
//  Created by 南伊織 on 6/8/16.
//  Copyright © 2016 南伊織. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var imgView1: UIImageView! //top
    @IBOutlet var imgView2: UIImageView! //mid
    @IBOutlet var imgView3: UIImageView! //bottom
    
    @IBOutlet var resultLabel: UILabel! //Score label
    
    var timer: NSTimer! //Timer
    var score: Int = 1000 //Score
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults() //saving scores
    
    let width: CGFloat = UIScreen.mainScreen().bounds.size.width //screen width iPhoneのスクリーンサイズを取得している
    
    var positionX: [CGFloat] = [0.0,0.0,0.0] //image pos
    
    var dx: [CGFloat] = [1.0,0.5,-1.0] //the width of the movement
    
    func start(){
        resultLabel.hidden = true
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
    }
    func up(){
        for i in 0..<3{
            if positionX[i]>width || positionX[i] < 0{
                dx[i] = dx[i] * (-1)
            }
            positionX[i] += dx[i]
        }
        imgView1.center.x=positionX[0]
        imgView2.center.x=positionX[1]
        imgView3.center.x=positionX[2]
    }
    
    @IBAction func stop(){
        if timer.valid == true{
        timer.invalidate()
        }
        for i in 0..<3{
            score = score - abs(Int(width/2 - positionX[i]))*2
        }
        resultLabel.text = String(score)
        resultLabel.hidden = false
        
        var highscore1: Int = defaults.integerForKey("score1")
        var highscore2: Int = defaults.integerForKey("score2")
        var highscore3: Int = defaults.integerForKey("score3")
        
        if score > highscore1 {
            defaults .setInteger(score, forKey: "score1")
            defaults .setInteger(highscore1, forKey: "score2")
            defaults .setInteger(highscore2, forKey: "score3")
        }else if score > highscore2 {
            defaults .setInteger(score, forKey: "score2")
            defaults .setInteger(highscore2, forKey: "score3")
        }else if score > highscore3 {
            defaults .setInteger(score, forKey: "score3")
        }
        defaults .synchronize()
    }
    
    
    @IBAction func retry(){
    score = 1000
    positionX = [width/2, width/2, width/2]
    self.start()
    }
    
    @IBAction func top(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionX = [width/2, width/2, width/2]
        
        self.start()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
