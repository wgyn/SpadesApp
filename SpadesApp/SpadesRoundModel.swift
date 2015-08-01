//
//  SpadesRoundModel.swift
//  SpadesApp
//
//  Created by Ryan Wang on 8/1/15.
//  Copyright © 2015 Gnaw. All rights reserved.
//

import Foundation

class SpadesRound {
    
    // TODO: Keep track of teams, currently assume (P1, P3) and (P2, P4)
    // TODO: Split up entry of bids and tricks
    // TODO: These should not be arrays...
    
    var bids: [Int]
    var tricks: [Int]
    var scores: [Int]
    var bags: [Int]
    
    init(bid1: Int, bid2: Int, bid3: Int, bid4: Int,
        tricks1: Int, tricks2: Int, tricks3: Int, tricks4: Int) {
            let outcome1 = SpadesRound.scoreTeamBidsAndTricks(
                bid1: bid1, bid2: bid3,
                tricks1: tricks1, tricks2: tricks3
            )
            let outcome2 = SpadesRound.scoreTeamBidsAndTricks(
                bid1: bid2, bid2: bid4,
                tricks1: tricks2, tricks2: tricks4
            )
            
            self.bids = [bid1, bid2, bid3, bid4]
            self.tricks = [tricks1, tricks2, tricks3, tricks4]
            self.scores = [outcome1.score, outcome2.score]
            self.bags = [outcome1.bags, outcome2.bags]
            // TODO: Run the validation on object creation...
    }
    
    class Outcome {
        var score, bags: Int
        
        init(score: Int, bags: Int) {
            self.score = score
            self.bags = bags
        }
        
        func hit() -> Bool {
            return self.score > 0
        }
        
        func plus(other: Outcome) -> Outcome {
            return Outcome(
                score: self.score + other.score,
                bags: self.bags + other.bags
            )
        }
    }
    
    class func scoreTeamBidsAndTricks(bid1 bid1: Int, bid2: Int, tricks1: Int, tricks2: Int) -> Outcome {
        // TODO: Handle blind nil
        // TODO: Get rid of duplication, de-obfuscate the scoring...
        let o1, o2: Outcome
        
        switch (bid1, bid2) {
        case (0, 0):
            o1 = scoreNilBid(tricks1)
            o2 = scoreNilBid(tricks2)
            return o1.plus(o2)
        case (0, _):
            o1 = scoreNilBid(tricks1)
            o2 = scoreRegularBid(bid2, tricks: tricks2 + o1.bags)
            o1.score -= tricks1
            o1.bags = 0
            return o1.plus(o2)
        case (_, 0):
            o2 = scoreNilBid(tricks2)
            o1 = scoreRegularBid(bid1, tricks: tricks1 + o2.bags)
            o2.score -= tricks2
            o2.bags = 0
            return o1.plus(o2)
        case (_, _):
            return scoreRegularBid(bid1 + bid2, tricks: tricks1 + tricks2)
        }
    }
    
    private class func scoreNilBid(tricks: Int) -> Outcome {
        return Outcome(
            // Always take care of extra bag score in scoreRegularBid
            // TODO: De-obfuscate this
            score: (tricks == 0 ? 100 : -100) + tricks,
            bags: tricks
        )
    }
    
    private class func scoreRegularBid(bid: Int, tricks: Int) -> Outcome {
        let tricksOverBid = tricks - bid
        let hit = tricksOverBid >= 0
        let bidScore = bid * 10
        return Outcome(
            score: (hit ? bidScore + tricksOverBid: -bidScore),
            bags: hit ? tricksOverBid : 0
        )
    }
    
    func displayText(roundNumber: Int) -> String {
        let score1 = self.scores[0]
        let score2 = self.scores[1]
        return "Round \(roundNumber). Team 1: \(score1) vs Team 2: \(score2)"
    }
    
    /**
    * Validators
    */
    func hasValidBids() -> Bool {
        let minBid = self.bids.reduce(Int.max, combine: min)
        return minBid >= 0
    }
    
    func hasValidTricks() -> Bool {
        let totaltricks = self.tricks.reduce(0, combine: +)
        let mintricks = self.tricks.reduce(Int.max, combine: min)
        return (totaltricks == 13) && (mintricks >= 0)
    }
    
}