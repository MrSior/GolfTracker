//
//  Prev_Game_Results_View.swift
//  Golf_Tracker_App
//
//  Created by Семён Чубенко on 21.02.2021.
//  Copyright © 2021 Семён Чубенко. All rights reserved.
//

import UIKit

class Prev_Game_Results_View: UIViewController {
    
    @IBOutlet weak var labelShots: UILabel!
    @IBOutlet weak var labelPuts: UILabel!
    @IBOutlet weak var labelUpDowns: UILabel!
    @IBOutlet weak var labelGreenReg: UILabel!
    @IBOutlet weak var labelExits: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    
    @IBOutlet weak var shotsResLabel: UILabel!
    @IBOutlet weak var putsResLabel: UILabel!
    @IBOutlet weak var upDownsResLabel: UILabel!
    @IBOutlet weak var greenRegResLabel: UILabel!
    @IBOutlet weak var exitsResLabel: UILabel!
    @IBOutlet weak var pointsResLabel: UILabel!
    @IBOutlet weak var HCPresLabel: UILabel!
    
    
    @IBOutlet weak var golfCourseNameLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        golfCourseNameLabel.text = prevGameInfo.field_name
        var shotsSum = 0, putsSum = 0, upDownsSum = 0, greenRegSum = 0, exitsSum = 0;
        Sum(shots: &shotsSum, puts: &putsSum, upDowns: &upDownsSum, greenReg: &greenRegSum, exits: &exitsSum)
        labelShots.text = String(shotsSum)
        labelShots.textAlignment = .left
        labelPuts.text = String(putsSum)
        labelUpDowns.text = String(upDownsSum)
        labelGreenReg.text = String(greenRegSum)
        labelExits.text = String(exitsSum)
        let points = CalculatingPoints()
        labelPoints.text = String(points)
        
        if shotsSum < 72 {
            shotsResLabel.text = String(shotsSum - 72)
        } else if shotsSum >= 72{
            shotsResLabel.text = "+" + String(shotsSum - 72)
        }
        if points >= 33 {
            shotsResLabel.textColor = UIColor.systemGreen
            pointsResLabel.text = "Ok";
            pointsResLabel.textColor = UIColor.systemGreen
            HCPresLabel.text = "⏤";
            HCPresLabel.textColor = UIColor.systemGreen
            if points > 36 {
                HCPresLabel.text = "↓";
                HCPresLabel.textColor = UIColor.systemGreen
            }
        } else{
            shotsResLabel.textColor = UIColor.red
            HCPresLabel.text = "↑";
            HCPresLabel.textColor = UIColor.red
            pointsResLabel.text = "Bad";
            pointsResLabel.textColor = UIColor.red
        }
        
        if putsSum > 36 {
            putsResLabel.text = "Bad"
            putsResLabel.textColor = UIColor.red
        } else{
            putsResLabel.text = "Ok"
            putsResLabel.textColor = UIColor.systemGreen
        }
        
        if greenRegSum == 18 - prevGameInfo.handicap_points{
            greenRegResLabel.text = "Ok"
            greenRegResLabel.textColor = UIColor.systemGreen
        } else if greenRegSum > 18 - prevGameInfo.handicap_points{
            greenRegResLabel.text = "Good"
            greenRegResLabel.textColor = UIColor.systemGreen
        } else{
            greenRegResLabel.text = "Bad"
            greenRegResLabel.textColor = UIColor.red
        }
        
        if upDownsSum == 18 - prevGameInfo.handicap_points{
            upDownsResLabel.text = "Ok"
            upDownsResLabel.textColor = UIColor.systemGreen
        } else if upDownsSum > 18 - prevGameInfo.handicap_points{
            upDownsResLabel.text = "Good"
            upDownsResLabel.textColor = UIColor.systemGreen
        } else{
            upDownsResLabel.text = "Bad"
            upDownsResLabel.textColor = UIColor.red
        }
        
        
//        if greenRegSum + upDownsSum < 18 {
//            greenRegResLabel.text = "Bad"
//            greenRegResLabel.textColor = UIColor.red
//            upDownsResLabel.text = "Bad"
//            upDownsResLabel.textColor = UIColor.red
//        } else{
//            greenRegResLabel.text = "Ok"
//            greenRegResLabel.textColor = UIColor.green
//            upDownsResLabel.text = "Ok"
//            upDownsResLabel.textColor = UIColor.green
//        }
        
        if exitsSum < 17 {
            exitsResLabel.text = "Bad"
            exitsResLabel.textColor = UIColor.red
        } else{
            exitsResLabel.text = "Ok"
            exitsResLabel.textColor = UIColor.systemGreen
        }
        
        // Do any additional setup after loading the view.
    }
    
    func Sum(shots: inout Int, puts: inout Int, upDowns: inout Int, greenReg: inout Int, exits: inout Int){
        for i in prevGameInfo.Holes {
            shots += i.shots;
            puts += i.puts;
            if i.UpDown {
                upDowns += 1
            }
            if i.greenReg {
                greenReg += 1
            }
            if i.exit == 1 {
                exits += 1;
            }
        }
        return;
    }
    
    func CalculatingPoints() -> Int {
        let p = prevGameInfo.handicap_points
        var res = 0;
        for i in prevGameInfo.Holes {
            if prevGameInfo.handicap_points > 18 {
                var fors = p / 18;
                if i.HCP <= p % 18 {
                    fors += 1;
                }
                if i.shots - fors == i.par {
                    res += 2
                } else if i.shots - fors == i.par - 1{
                    res += 3
                } else if i.shots - fors == i.par - 2{
                    res += 4
                } else if i.shots - fors == i.par + 1{
                    res += 1
                }
            } else{
                if i.HCP <= prevGameInfo.handicap_points {
                    if i.shots - 1 == i.par + 1{
                        res += 1
                    } else if i.shots - 1 == i.par{
                        res += 2
                    } else if i.shots - 1 == i.par - 1{
                        res += 3
                    } else if i.shots - 1 == i.par - 2{
                        res += 4
                    }
                } else{
                    if i.shots == i.par + 1{
                        res += 1
                    } else if i.shots == i.par{
                        res += 2
                    } else if i.shots == i.par - 1{
                        res += 3
                    } else if i.shots == i.par - 2{
                        res += 4
                    }
                }
            }
        }
        return res;
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
