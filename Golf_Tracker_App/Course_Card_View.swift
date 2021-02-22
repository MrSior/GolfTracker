//
//  Course_Card_View.swift
//  Golf_Tracker_App
//
//  Created by Семён Чубенко on 04.01.2021.
//  Copyright © 2021 Семён Чубенко. All rights reserved.
//

import UIKit

struct Labeles {
    var number:[UILabel] = [];
    var HCP:[UILabel] = [];
    var par:[UILabel] = [];
    var puts:[UILabel] = [];
    var shots:[UILabel] = [];
    var upDowns:[UILabel] = [];
    var exit:[UILabel] = [];
    var greenReg:[UILabel] = [];
    
    init() {
        var y = 131;
        for i in 1...18 {
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 33, height: 36))
            label.center = CGPoint(x: 28, y: y)
            y += 72
            label.textAlignment = .left
            label.text = String(i)
            label.font = label.font.withSize(29)
            number.append(label)
        }
        
        y = 138
        for i in 1...18 {
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 14, height: 27))
            label.center = CGPoint(x: 49, y: y)
            y += 72
            label.textAlignment = .left
            label.text = String(4)
            label.font = UIFont.boldSystemFont(ofSize: 22.0)
            //label.font = label.font.withSize(29)
            par.append(label)
            Current_game.Holes[i-1].par = 4;
        }
        
        y = 121
        for i in 1...18 {
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            if i > 9 {
                label.center = CGPoint(x: 50, y: y)
            } else {
                label.center = CGPoint(x: 50, y: y)
            }
            y += 72
            label.textAlignment = .center
            label.text = String(i)
            label.font = label.font.withSize(18)
            HCP.append(label)
            Current_game.Holes[i-1].HCP = i;
        }
        
        y = 131
        for i in 1...18 {
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 27, height: 46))
            label.center = CGPoint(x: 102, y: y)
            y += 72
            label.textAlignment = .center
            label.text = String("/")
            label.font = label.font.withSize(38)
            shots.append(label)
        }
        
        y = 131
        for i in 1...18 {
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 27, height: 46))
            label.center = CGPoint(x: 175, y: y)
            y += 72
            label.textAlignment = .center
            label.text = String("/")
            label.font = label.font.withSize(38)
            puts.append(label)
        }
        
        y = 131
        for i in 1...18 {
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 27, height: 46))
            label.center = CGPoint(x: 235, y: y)
            y += 72
            label.textAlignment = .center
            label.text = String("")
            label.font = label.font.withSize(38)
            upDowns.append(label)
        }
        
        y = 131
        for i in 1...18 {
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 46, height: 46))
            label.center = CGPoint(x: 289, y: y)
            y += 72
            label.textAlignment = .center
            label.text = String("")
            label.font = label.font.withSize(38)
            exit.append(label)
        }
        
        y = 131
        for i in 1...18 {
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 27, height: 46))
            label.center = CGPoint(x: 344, y: y)
            y += 72
            label.textAlignment = .center
            label.text = String("")
            label.font = label.font.withSize(38)
            greenReg.append(label)
        }
    }
}

let holeLables:Labeles = Labeles()

class Course_Card_View: UIViewController {
    
    //let holeLables:Labeles = Labeles()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        //self.navigationItem.backButtonTitle = "Back"
        
        //let holeLables:Labeles = Labeles()
        for i in 0...17 {
            holeLables.par[i].text = String(Current_game.Holes[i].par)
            holeLables.HCP[i].text = String(Current_game.Holes[i].HCP)
            if Current_game.Holes[i].puts == 0 {
                holeLables.puts[i].text = ""
            } else {
                holeLables.puts[i].text = String(Current_game.Holes[i].puts)
            }
            if Current_game.Holes[i].shots == 0 {
                holeLables.shots[i].text = ""
            } else {
                holeLables.shots[i].text = String(Current_game.Holes[i].shots)
            }
            if Current_game.Holes[i].shots == 0 {
                holeLables.upDowns[i].text = "";
            } else {
                if Current_game.Holes[i].UpDown {
                    holeLables.upDowns[i].text = "+";
                } else{
                    holeLables.upDowns[i].text = "-";
                }
            }
            
            if Current_game.Holes[i].shots == 0 {
                holeLables.greenReg[i].text = "";
            } else {
                if Current_game.Holes[i].greenReg {
                    holeLables.greenReg[i].text = "+";
                } else{
                    holeLables.greenReg[i].text = "-";
                }
            }
        }
        
        for i in 0...17 {
            self.view.viewWithTag(1)?.addSubview(holeLables.number[i]);
            self.view.viewWithTag(1)?.addSubview(holeLables.par[i]);
            self.view.viewWithTag(1)?.addSubview(holeLables.HCP[i]);
            self.view.viewWithTag(1)?.addSubview(holeLables.shots[i]);
            self.view.viewWithTag(1)?.addSubview(holeLables.puts[i]);
            self.view.viewWithTag(1)?.addSubview(holeLables.upDowns[i]);
            self.view.viewWithTag(1)?.addSubview(holeLables.exit[i]);
            self.view.viewWithTag(1)?.addSubview(holeLables.greenReg[i]);
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func showMiracle(){
        let slideVc = OverlayView()
        slideVc.modalPresentationStyle = .custom
        slideVc.transitioningDelegate = self
        self.present(slideVc, animated: true, completion: nil)
    }
    
    @IBAction func FirstHoleTapped(_ sender: Any) {
        currentHole = 0;
        showMiracle()
        
    }
    
    @IBAction func onButton(_ sender: Any){
        currentHole = 1;
        showMiracle()
    }
    
    @IBAction func ThirdHoleTapped(_ sender: Any) {
        currentHole = 2;
        showMiracle()
        
//        print("HCp = ")
//        print(Current_game.Holes[currentHole].HCP)
    }
    
    @IBAction func FouthHoleTapped(_ sender: Any) {
        currentHole = 3;
        showMiracle()
    }
    
    @IBAction func FithHoleTapped(_ sender: Any) {
        currentHole = 4;
        showMiracle()
    }
    
    @IBAction func SixthHoleTapped(_ sender: Any) {
        currentHole = 5;
        showMiracle()
    }
    
    @IBAction func SeventhHoleTapped(_ sender: Any) {
        currentHole = 6;
        showMiracle()
    }
    
    @IBAction func EighthHoleTapped(_ sender: Any) {
        currentHole = 7;
        showMiracle()
    }
    
    @IBAction func NinethHolePresented(_ sender: Any) {
        currentHole = 8;
        showMiracle()
    }
    
    @IBAction func TenthHolePresented(_ sender: Any) {
        currentHole = 9;
        showMiracle()
    }
    
    @IBAction func EleventhHolePresented(_ sender: Any) {
        currentHole = 10;
        showMiracle()
    }
    
    @IBAction func TwelfthHolePresented(_ sender: Any) {
        currentHole = 11;
        showMiracle()
    }
    
    @IBAction func ThirteenthHolePresented(_ sender: Any) {
        currentHole = 12;
        showMiracle()
    }
    
    @IBAction func FouteenthHolePresented(_ sender: Any) {
        currentHole = 13;
        showMiracle()
    }
    
    @IBAction func FifteenthHoleTapped(_ sender: Any) {
        currentHole = 14;
        showMiracle()
    }
    
    @IBAction func SixteenthHoleTapped(_ sender: Any) {
        currentHole = 15;
        showMiracle()
    }
    
    @IBAction func SeventeenthHoleTapped(_ sender: Any) {
        currentHole = 16;
        showMiracle()
    }
    
    @IBAction func EighteenthHoleTapped(_ sender: Any) {
        currentHole = 17;
        showMiracle()
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        performSegue(withIdentifier: "toResultSegue", sender: nil)
    }
    
    @IBAction func deleteCurrentGameTapped(_ sender: Any) {
        Current_game = Course()
        saveData()
        self.performSegue(withIdentifier: "unwindFromCourseToMainPage", sender: self)
    }
    
    
}

extension Course_Card_View: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
