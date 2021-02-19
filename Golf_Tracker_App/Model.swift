//
//  Model.swift
//  Golf_Tracker_App
//
//  Created by Семён Чубенко on 22.11.2020.
//  Copyright © 2020 Семён Чубенко. All rights reserved.
//

import Foundation

var HCP_of_player:Int = 0;
var Best_score:Int = 0;
var whatTrain:String = ""
var isTrainRange:Bool = false;
var isTrainChip:Bool = false;
var isTrainPut:Bool = false;


struct Hole{
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

struct Course{
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

var Games:[Course] = [];
var Current_game:Course = Course()
var currentHole:Int = 0;

func NewGame(game:Course){
    Games.append(game);
}

func RemoveGame(index:Int){
    Games.remove(at: index);
}


