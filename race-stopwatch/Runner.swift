//
//  Runner.swift
//  race-stopwatch
//
//  Created by Trevor Cash on 4/19/24.
//


class Runner: Identifiable{
    var name: String
    var laps : [Double]
    var id: String {
        self.name
    }
    
    init(name: String) {
        self.name = name
        self.laps = []
    }
}
