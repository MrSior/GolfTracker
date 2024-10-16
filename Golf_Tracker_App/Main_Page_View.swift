//
//  Main_Page_View.swift
//  Golf_Tracker_App
//
//  Created by Семён Чубенко on 22.11.2020.
//  Copyright © 2020 Семён Чубенко. All rights reserved.
//

import UIKit

class Main_Page_View: UIViewController {
    
    @IBOutlet weak var isTrainLabel: UILabel!
    @IBOutlet weak var isTrainLabel1: UILabel!
    @IBOutlet weak var isTrainLabel2: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    @IBOutlet weak var BestScoreImage: UIImageView!
    @IBOutlet weak var GolferImage: UIImageView!
    
    
    var isFirstStart = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.view.frame.width == 428 && isFirstStart {
            bestScoreLabel.frame.origin.x = bestScoreLabel.frame.origin.x + 25
            GolferImage.frame.origin.x = GolferImage.frame.origin.x + 25
            isFirstStart = false
        }
        
        isChanged = Array(repeating: Array(repeating: false, count: 7), count: 18);
        if Games.count == 0{
            bestScoreLabel.text = ""
        } else{
            var min = 1000000000
            for game in Games {
                var sum = 0
                for i in game.Holes {
                    sum += i.shots
                }
                if sum < min {
                    min = sum
                }
            }
            let scr = min - 72
            if scr < 0 {
                bestScoreLabel.text = String(scr)
            } else{
                bestScoreLabel.text = String("+" + String(scr))
            }
        }
//        if Best_score == 100000 {
//            bestScoreLabel.text = ""
//        } else{
//            let scr:Int = Best_score - 72;
//            if scr < 0 {
//                bestScoreLabel.text = String(scr)
//            } else{
//                bestScoreLabel.text = String("+" + String(scr))
//            }
//        }
        if isTrainRange {
            isTrainLabel.text = "•Range"
            if isTrainChip {
                isTrainLabel1.text = "•Chip"
                if isTrainPut {
                    isTrainLabel2.text = "•Put"
                } else{
                    isTrainLabel2.text = ""
                }
            } else if isTrainPut{
                isTrainLabel1.text = "•Put"
                isTrainLabel2.text = ""
            } else{
                isTrainLabel1.text = ""
                isTrainLabel2.text = ""
            }
        } else if isTrainChip{
            isTrainLabel.text = "•Chip"
            if isTrainPut {
                isTrainLabel1.text = "•Put"
            }else {
                isTrainLabel1.text = ""
            }
        } else if isTrainPut{
            isTrainLabel.text = "•Put"
            isTrainLabel1.text = "";
            isTrainLabel2.text = "";
        } else{
            isTrainLabel.text = ""
            isTrainLabel1.text = "";
            isTrainLabel2.text = "";
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        self.viewDidLoad()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
