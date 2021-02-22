//
//  Result_View.swift
//  Golf_Tracker_App
//
//  Created by Семён Чубенко on 31.01.2021.
//  Copyright © 2021 Семён Чубенко. All rights reserved.
//

import UIKit

class Result_View: UIViewController {
    
    @IBOutlet weak var shotsLabel: UILabel!
    @IBOutlet weak var putsLabel: UILabel!
    @IBOutlet weak var upDownsLabel: UILabel!
    @IBOutlet weak var greenRegLabel: UILabel!
    @IBOutlet weak var exitsLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var hcpLabel: UILabel!
    
    
    @IBOutlet weak var resShotsLabel: UILabel!
    @IBOutlet weak var resPutsLabel: UILabel!
    @IBOutlet weak var resUpDownsLabel: UILabel!
    @IBOutlet weak var resGreenRegLabel: UILabel!
    @IBOutlet weak var resExitsLabel: UILabel!
    @IBOutlet weak var resPointLabel: UILabel!
    @IBOutlet weak var resHCPLabel: UILabel!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.setHidesBackButton(true, animated: true)
        var shotsSum = 0, putsSum = 0, upDownsSum = 0, greenRegSum = 0, exitsSum = 0;
        Sum(shots: &shotsSum, puts: &putsSum, upDowns: &upDownsSum, greenReg: &greenRegSum, exits: &exitsSum)
        shotsLabel.text = String(shotsSum)
        shotsLabel.textAlignment = .left
        putsLabel.text = String(putsSum)
        upDownsLabel.text = String(upDownsSum)
        greenRegLabel.text = String(greenRegSum)
        exitsLabel.text = String(exitsSum)
        let points = CalculatingPoints()
        pointsLabel.text = String(points)
        
        if shotsSum < Best_score {
            Best_score = shotsSum;
        }
        
        if shotsSum < 72 {
            resShotsLabel.text = String(shotsSum - 72)
        } else if shotsSum >= 72{
            resShotsLabel.text = "+" + String(shotsSum - 72)
        }
        if points >= 33 {
            resShotsLabel.textColor = UIColor.green
            resPointLabel.text = "Ok";
            resPointLabel.textColor = UIColor.green
            if points > 36 {
                resHCPLabel.text = "↑";
                resHCPLabel.textColor = UIColor.green
            }
        } else{
            resShotsLabel.textColor = UIColor.red
            resHCPLabel.text = "↓";
            resHCPLabel.textColor = UIColor.red
            resPointLabel.text = "Bad";
            resPointLabel.textColor = UIColor.red
        }
        
        if putsSum > 36 {
            resPutsLabel.text = "Bad"
            resPutsLabel.textColor = UIColor.red
        } else{
            resPutsLabel.text = "Ok"
            resPutsLabel.textColor = UIColor.green
        }
        
        if greenRegSum + upDownsSum < 18 {
            resGreenRegLabel.text = "Bad"
            resGreenRegLabel.textColor = UIColor.red
            resUpDownsLabel.text = "Bad"
            resUpDownsLabel.textColor = UIColor.red
        } else{
            resGreenRegLabel.text = "Ok"
            resGreenRegLabel.textColor = UIColor.green
            resUpDownsLabel.text = "Ok"
            resUpDownsLabel.textColor = UIColor.green
        }
        if exitsSum < 17 {
            resExitsLabel.text = "Bad"
            resExitsLabel.textColor = UIColor.red
        } else{
            resExitsLabel.text = "Ok"
            resExitsLabel.textColor = UIColor.green
        }
        
        
        if exitsSum < 17 {
            isTrainRange = true;
        }
        if greenRegSum + upDownsSum != 18{
            isTrainChip = true;
        }
        if putsSum >= 36 {
            isTrainPut = true;
        }
    }
    
    func Sum(shots: inout Int, puts: inout Int, upDowns: inout Int, greenReg: inout Int, exits: inout Int){
        for i in Current_game.Holes {
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
        let p = Current_game.handicap_points
        var res = 0;
        for i in Current_game.Holes {
            if Current_game.handicap_points > 18 {
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
                if i.HCP <= Current_game.handicap_points {
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
    
    func isComplete() -> Bool {
        for i in 0...17 {
            if holeLables.shots[i].text == "" {
                return false;
            }
            if holeLables.puts[i].text == "" {
                return false;
            }
            if holeLables.exit[i].text == "" {
                return false;
            }
            if holeLables.upDowns[i].text == "" {
                return false;
            }
            if holeLables.greenReg[i].text == "" {
                return false;
            }
        }
        return true;
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
        if isComplete() {
            //Games.append(Current_game)
            NewGame(game: Current_game);
            saveData();
            self.performSegue(withIdentifier: "unwindToMainPage", sender: self)
        } else{
            let alert =  UIAlertController(title: "Incomplete From", message: "Please fill out all information about holes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
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
