//
//  SpadesMetadataModel.swift
//  SpadesApp
//
//  Created by Ryan Wang on 8/1/15.
//  Copyright © 2015 Gnaw. All rights reserved.
//

import Foundation

class Player {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Team {
    let players: (Player, Player)
    let name: String
    
    init(player1: String, player2: String, teamName: String) {
        self.players = (Player(name: player1), Player(name: player2))
        self.name = teamName
    }
    
    init(player1: Player, player2: Player, teamName: String) {
        self.players = (player1, player2)
        self.name = teamName
    }
}