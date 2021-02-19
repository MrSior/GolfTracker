//
//  New_Game_View.swift
//  Golf_Tracker_App
//
//  Created by Семён Чубенко on 02.01.2021.
//  Copyright © 2021 Семён Чубенко. All rights reserved.
//

import UIKit

class New_Game_View: UIViewController {
    
    @IBOutlet weak var Name_TextField: UITextField!
    @IBOutlet weak var Golf_Course_name_TextField: UITextField!
    @IBOutlet weak var Handicap_Points_TextField: UITextField!
    
    
    @IBAction func Done_Tapped(_ sender: Any) {
        if Name_TextField.text == "" || Golf_Course_name_TextField.text == "" || Handicap_Points_TextField.text == "" {
            let alert =  UIAlertController(title: "Incomplete From", message: "Please fill out all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else{
            Current_game = Course()
            Current_game.name = Name_TextField.text!
            Current_game.field_name = Golf_Course_name_TextField.text!
            Current_game.handicap_points = Int(Handicap_Points_TextField.text!)!
            performSegue(withIdentifier: "toCourseCardSegue", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureTapGesture()
        // Do any additional setup after loading the view.
    }
    
    private func configureTextFields(){
        Name_TextField.delegate = self
        Golf_Course_name_TextField.delegate = self
        Handicap_Points_TextField.delegate = self
    }
    
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(New_Game_View.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
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

extension UIViewController: UITextFieldDelegate{
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
