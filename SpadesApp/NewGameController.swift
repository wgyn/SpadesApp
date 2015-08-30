//
//  NewGameController.swift
//  SpadesApp
//
//  Created by Ryan Wang on 8/23/15.
//  Copyright © 2015 Gnaw. All rights reserved.
//

import UIKit

class NewGameController: UITableViewController {
    
    @IBOutlet weak var team1Name: UITextField!
    @IBOutlet weak var team1Player1Name: UITextField!
    @IBOutlet weak var team1Player2Name: UITextField!
    
    @IBOutlet weak var team2Name: UITextField!
    @IBOutlet weak var team2Player1Name: UITextField!
    @IBOutlet weak var team2Player2Name: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NewGameSegue" {
            let team1Player1 = Player(name: team1Player1Name.text!)
            let team1Player2 = Player(name: team1Player2Name.text!)
            let team1 = Team(player1: team1Player1, player2: team1Player2, teamName: team1Name.text!)
            
            let team2Player1 = Player(name: team2Player1Name.text!)
            let team2Player2 = Player(name: team2Player2Name.text!)
            let team2 = Team(player1: team2Player1, player2: team2Player2, teamName: team2Name.text!)
            
            let destination = segue.destinationViewController as! CurrentGameController
            // TODO: Allow for modification of playUntil
            destination.game = SpadesGame(team1: team1, team2: team2, playUntil: 500)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "NewGameSegue" {
            let inputFields = [
                team1Player1Name, team1Player2Name, team1Name,
                team2Player1Name, team2Player2Name, team2Name,
            ]
            
            let allFieldsEntered = inputFields.map({!$0.text!.isEmpty}).reduce(true, combine: {$0 && $1})
            if !allFieldsEntered {
                popupAlert("Missing Fields", message: "Please enter a value for all fields")
                return false
            } else {
                return true
            }
        }
        
        return false
    }
    // TODO: Make sure all fields are filled before attempting to segue
}