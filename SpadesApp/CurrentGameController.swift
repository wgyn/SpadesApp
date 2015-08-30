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