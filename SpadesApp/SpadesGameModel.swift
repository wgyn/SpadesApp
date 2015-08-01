//
//  SpadesGameModel.swift
//  SpadesApp
//
//  Created by Ryan Wang on 8/1/15.
//  Copyright © 2015 Gnaw. All rights reserved.
//

import Foundation

enum SpadesGameError: ErrorType {
    case GameOver
}

class SpadesGame {
    let playUntil: Int!
    let teams: (Team, Team)
    var rounds: Array<SpadesRound>
    var currentScores: (Int, Int)
    var currentBags: (Int, Int)
    
    init(team1: Team, team2: Team, playUntil: Int) {
        self.playUntil = playUntil // TODO: Validate playUntil e.g. 250 / 500
        self.teams = (team1, team2)
        self.rounds = []
        self.currentScores = (0, 0)
        self.currentBags = (0, 0)
    }
    
    /**
    * @returns currentHighScoringTeam, currentHighScore
    */
    var highScore: (team: Team, score: Int) {
        if self.currentScores.0 > self.currentScores.1 {
            return (self.teams.0, self.currentScores.0)
        } else {
            return (self.teams.1, self.currentScores.1)
        }
    }
    
    var isOver: Bool {
        return self.highScore.score >= self.playUntil
    }
    
    var winner: Team? {
        if self.isOver {
            return self.highScore.team
        } else {
            return nil
        }
    }
    
    func addRound(round: SpadesRound) throws {
        if !self.isOver {
            self.rounds.append(round)
            self.updateScores(round)
            self.updateBags(round)
        } else {
            throw SpadesGameError.GameOver
        }
    }
    
    func updateScores(round: SpadesRound) {
        self.currentScores.0 += round.scores[0]
        self.currentScores.1 += round.scores[1]
    }
    
    func updateBags(round: SpadesRound) {
        // TODO: Clean this up...
        self.currentBags.0 += round.bags[0]
        self.currentBags.1 += round.bags[1]
        
        // If 10 bags accumulated, reset bags and and subtract 100 from score
        if self.currentBags.0 >= 10 {
            self.currentBags.0 %= 10
            self.currentScores.0 -= 100
        }
        
        if self.currentBags.1 >= 10 {
            self.currentBags.1 %= 10
            self.currentScores.1 -= 100
        }
    }
    
}