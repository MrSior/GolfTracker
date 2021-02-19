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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bestScoreLabel.textColor = UIColor(red: 35, green: 52, blue: 67, alpha: 1);
        bestScoreLabel.text = String(Best_score)
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
