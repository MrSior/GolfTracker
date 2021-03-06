//
//  Model.swift
//  Golf_Tracker_App
//
//  Created by Семён Чубенко on 22.11.2020.
//  Copyright © 2020 Семён Чубенко. All rights reserved.
//

import Foundation

var HCP_of_player:Int = 0;
var Best_score:Int = 100000;
var whatTrain:String = ""
var isTrainRange:Bool = false;
var isTrainChip:Bool = false;
var isTrainPut:Bool = false;

struct Hole : Codable{   //добавил codable
    var par:Int = 0;
    var HCP:Int = 0;
    var shots:Int = 0;
    var exit:Int = 0;
    var greenReg:Bool = false;
    var puts:Int = 0;
    var UpDown:Bool = false;
    init(par:Int, HCP:Int, shots:Int) {
        self.par = par;
        self.HCP = HCP;
        self.shots = shots;
        self.exit = 0;
        self.greenReg = false;
        self.puts = 0;
        self.UpDown = false;
    }
}

struct Course : Codable{    //добавил codable
    var name:String = ""
    var field_name:String = ""
    var handicap_points:Int = 0
    var isFinished:Bool = false;
    var Holes = [Hole](repeating: Hole.init(par: 0 , HCP: 0, shots: 0), count: 18);
    
    init(name:String, field_name:String, handicap_points:Int) {
        self.name = name;
        self.field_name = field_name;
        self.handicap_points = handicap_points;
        isFinished = false;
    }
    
    init() {
        name = ""
        field_name = ""
        handicap_points = 18;
        isFinished = false
        Holes = [Hole](repeating: Hole.init(par: 0 , HCP: 0, shots: 0), count: 18)
    }
}
var Games:[Course] = []
var Current_game:Course = Course()
var currentHole:Int = 0;

var isChanged = Array(repeating: Array(repeating: false, count: 7), count: 18); // добавил сегодня

func NewGame(game:Course){
    Games.append(game);
}

func RemoveGame(index:Int){
    Games.remove(at: index);
}

func saveData(){
    let arr:[Course] = Games
    if let data = try? PropertyListEncoder().encode(arr) {
        UserDefaults.standard.set(data, forKey: "GamesData")
    }
    
    UserDefaults.standard.set(isTrainRange, forKey: "isTrainRangeData");
    UserDefaults.standard.set(isTrainChip, forKey: "isTrainChipData");
    UserDefaults.standard.set(isTrainPut, forKey: "isTrainPutData");
    UserDefaults.standard.set(Best_score, forKey: "bestScoreData");
    //UserDefaults.standard.set(Current_game, forKey: "Current_gameData");
    UserDefaults.standard.synchronize();
}

func loadData(){
    
    let defaults = UserDefaults.standard
    if let data = defaults.data(forKey: "GamesData") {
        Games =  try! PropertyListDecoder().decode([Course].self, from: data)
    }
    let a:Bool? = UserDefaults.standard.bool(forKey: "isTrainRangeData")
    if a != nil {
        isTrainRange = a!;
    }
    let b:Bool? = UserDefaults.standard.bool(forKey: "isTrainChipData")
    if b != nil {
        isTrainChip = b!;
    }
    let c:Bool? = UserDefaults.standard.bool(forKey: "isTrainPutData")
    if c != nil {
        isTrainPut = c!;
    }
    let scr:Int? = UserDefaults.standard.integer(forKey: "bestScoreData")
    if scr != nil && scr != 0{
        Best_score = scr!;
    }
//    if let arr = UserDefaults.standard.array(forKey: "GamesData") as? [Course] {
//        Games = arr;
//    } else{
//        let game:[Course] = []
//        Games = game;
//    }
}

