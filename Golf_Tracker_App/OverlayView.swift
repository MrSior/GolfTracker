//
//  OverlayView.swift
//  Golf_Tracker_App
//
//  Created by Семён Чубенко on 25.01.2021.
//  Copyright © 2021 Семён Чубенко. All rights reserved.
//

import UIKit

class OverlayView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    var pickerData: [[String]] = [[String]]()
    
    @IBOutlet weak var slideIndicator: UIView!
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        slideIndicator.roundCorners(.allCorners, radius: 10)
        
        picker.center = CGPoint(x: 187, y: 142)
        self.picker.delegate = self
        self.picker.dataSource = self
        var s:Character = "↑"
        var str:String = String(s);
        s = "←"
        var str1:String = String(s);
        s = "→"
        var str2:String = String(s);
        pickerData = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18"],
                      ["3", "4", "5"],
                      ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
                      ["1", "2", "3", "4", "5", "6", "7", "8"],
                      ["+", "-"],
                      [str, str1, str2],
                      ["+", "-"]]
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 { //1300
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if component == 0 {
            Current_game.Holes[currentHole].HCP = row + 1;
            holeLables.HCP[currentHole].text = String(row + 1)
        }
        if component == 1 {
            Current_game.Holes[currentHole].par = row + 3;
            holeLables.par[currentHole].text = String(row + 3)
        }
        if component == 2 {
            Current_game.Holes[currentHole].shots = row + 1;
            holeLables.shots[currentHole].text = String(row + 1)
        }
        if component == 3 {
            Current_game.Holes[currentHole].puts = row + 1;
            holeLables.puts[currentHole].text = String(row + 1)
        }
        if component == 4 {
            var b:Bool;
            var s:String;
            if pickerData[component][row] == "+" {
                b = true
                s = "+"
            } else {
                b = false
                s = "-"
            }
            Current_game.Holes[currentHole].UpDown = b;
            holeLables.upDowns[currentHole].text = s
        }
        if component == 5 {
            var s:String = ""
            if row == 0 {
                s = "↑"
            }
            else if row == 1 {
                s = "←"
            }
            else if row == 2 {
                s = "→"
            }
            Current_game.Holes[currentHole].exit = row + 1;
            holeLables.exit[currentHole].text = s
        }
        if component == 6 {
            var b:Bool;
            var s:String;
            if pickerData[component][row] == "+" {
                b = true
                s = "+"
            } else {
                b = false
                s = "-"
            }
            Current_game.Holes[currentHole].greenReg = b;
            holeLables.greenReg[currentHole].text = s
        }
    }
}
