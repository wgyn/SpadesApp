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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NewRoundSegue" {
            let nav = segue.destinationViewController as! UINavigationController
            let newRound = nav.topViewController as! NewRoundController
            newRound.player1Name = self.game.teams.0.players.0.name
            newRound.player2Name = self.game.teams.0.players.1.name
            newRound.player3Name = self.game.teams.1.players.0.name
            newRound.player4Name = self.game.teams.1.players.1.name
            
        }
    }
    
    @IBAction
    func unwindToCurrentGame(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as! NewRoundController
        if source.newRound != nil {
            do {
                try self.game.addRound(source.newRound!)
            } catch {
                // TODO: Handle this...
            }
            
            let currentScores = self.game.currentScores
            let teams = self.game.teams
            
            self.gameSummary.text = formatGameSummary()
            if self.game.isOver {
                popupAlert(
                    "\(self.game.winner!.name) wins!",
                    message: "Final score... \(teams.0.name): \(currentScores.0) to \(teams.1.name): \(currentScores.1)"
                )
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