//
//  CurrentGameController.swift
//  SpadesApp
//
//  Created by Ryan Wang on 8/1/15.
//  Copyright © 2015 Gnaw. All rights reserved.
//

import UIKit

class CurrentGameController: UITableViewController {
    
    var game: SpadesGame!
    @IBOutlet weak var gameSummary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Actually initialize player and teams
        let player1 = Player(name: "Andy")
        let player2 = Player(name: "Bob")
        let player3 = Player(name: "Charles")
        let player4 = Player(name: "David")
        let team1 = Team(player1: player1, player2: player2, teamName: "Team 1")
        let team2 = Team(player1: player3, player2: player4, teamName: "Team 2")
        
        self.game = SpadesGame(team1: team1, team2: team2, playUntil: 500)
        self.gameSummary.text = formatGameSummary()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.game.rounds.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SpadesRoundCell", forIndexPath: indexPath)
        let round = self.game.rounds[indexPath.row]
        cell.textLabel!.text = round.displayText(indexPath.row + 1)
        return cell
    }
    
    @IBAction
    func unwindToCurrentGame(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as! NewRoundController
        if source.newRound != nil {
            // TODO: Handle some kind of error?
            do {
                try self.game.addRound(source.newRound!)
            } catch {
                // TODO: Handle this...
            }
            
            let currentScores = self.game.currentScores
            let currentBags = self.game.currentBags
            
            self.gameSummary.text = formatGameSummary()
            if self.game.isOver {
                let alert = UIAlertView()
                alert.title = "\(self.game.winner!) wins!"
                alert.message = "Final score... Team 1: \(currentScores.0) to Team 2: \(currentScores.1)"
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        
        self.tableView.reloadData()
    }
    
    func formatGameSummary() -> String {
        let (score0, score1) = self.game.currentScores
        let (bags0, bags1) = self.game.currentBags
        let (team0, team1) = self.game.teams
        
        return "\n".join(["Score: ",
            "       \(team0.name): \(score0)",
            "       \(team1.name): \(score1)",
            "Bags: ",
            "       \(team0.name): \(bags0)",
            "       \(team1.name): \(bags1)"])
    }
}