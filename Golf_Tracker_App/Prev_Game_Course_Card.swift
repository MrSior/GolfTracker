//
//  Prev_Game_Course_Card.swift
//  Golf_Tracker_App
//
//  Created by Семён Чубенко on 20.02.2021.
//  Copyright © 2021 Семён Чубенко. All rights reserved.
//

import UIKit

var holeLabelsOfPrevGame:Labeles = Labeles()

class Prev_Game_Course_Card: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...17{
            holeLabelsOfPrevGame.par[i].text = String(prevGameInfo.Holes[i].par)
            holeLabelsOfPrevGame.HCP[i].text = String(prevGameInfo.Holes[i].HCP)
            holeLabelsOfPrevGame.shots[i].text = String(prevGameInfo.Holes[i].shots)
            holeLabelsOfPrevGame.puts[i].text = String(prevGameInfo.Holes[i].puts)
            
            if prevGameInfo.Holes[i].UpDown {
                holeLabelsOfPrevGame.upDowns[i].text = "+"
            } else{
                holeLabelsOfPrevGame.upDowns[i].text = "-"
            }
            
            if prevGameInfo.Holes[i].greenReg {
                holeLabelsOfPrevGame.greenReg[i].text = "+"
            } else{
                holeLabelsOfPrevGame.greenReg[i].text = "-"
            }
            let ex = prevGameInfo.Holes[i].exit
            if ex == 1 {
                holeLabelsOfPrevGame.exit[i].text = "↑"
            } else if ex == 2{
                holeLabelsOfPrevGame.exit[i].text = "←"
            } else{
                holeLabelsOfPrevGame.exit[i].text = "→"
            }
        }
        
        for i in 0...17 {
            self.view.viewWithTag(2)?.addSubview(holeLabelsOfPrevGame.number[i]);
            self.view.viewWithTag(2)?.addSubview(holeLabelsOfPrevGame.par[i]);
            self.view.viewWithTag(2)?.addSubview(holeLabelsOfPrevGame.HCP[i]);
            self.view.viewWithTag(2)?.addSubview(holeLabelsOfPrevGame.shots[i]);
            self.view.viewWithTag(2)?.addSubview(holeLabelsOfPrevGame.puts[i]);
            self.view.viewWithTag(2)?.addSubview(holeLabelsOfPrevGame.upDowns[i]);
            self.view.viewWithTag(2)?.addSubview(holeLabelsOfPrevGame.exit[i]);
            self.view.viewWithTag(2)?.addSubview(holeLabelsOfPrevGame.greenReg[i]);
        }
        // Do any additional setup after loading the view.
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
