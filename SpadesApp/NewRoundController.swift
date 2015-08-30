//
//  NewRoundController.swift
//  SpadesApp
//
//  Created by Ryan Wang on 8/1/15.
//  Copyright © 2015 Gnaw. All rights reserved.
//

import UIKit

class NewRoundController: UITableViewController {
    
    var newRound: SpadesRound?
    var player1Name: String!
    var player2Name: String!
    var player3Name: String!
    var player4Name: String!
    
    @IBOutlet weak var labelBid1: UILabel!
    @IBOutlet weak var labelBid2: UILabel!
    @IBOutlet weak var labelBid3: UILabel!
    @IBOutlet weak var labelBid4: UILabel!
    
    @IBOutlet weak var bid1: UITextField!
    @IBOutlet weak var bid2: UITextField!
    @IBOutlet weak var bid3: UITextField!
    @IBOutlet weak var bid4: UITextField!
    
    @IBOutlet weak var tricks1: UITextField!
    @IBOutlet weak var tricks2: UITextField!
    @IBOutlet weak var tricks3: UITextField!
    @IBOutlet weak var tricks4: UITextField!
    
    @IBOutlet weak var labelTricks1: UILabel!
    @IBOutlet weak var labelTricks2: UILabel!
    @IBOutlet weak var labelTricks3: UILabel!
    @IBOutlet weak var labelTricks4: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        self.labelBid1.text = self.player1Name
        self.labelBid2.text = self.player2Name
        self.labelBid3.text = self.player3Name
        self.labelBid4.text = self.player4Name
        
        self.labelTricks1.text = self.player1Name
        self.labelTricks2.text = self.player2Name
        self.labelTricks3.text = self.player3Name
        self.labelTricks4.text = self.player4Name
        // TODO: Add test that names get set correctly in NewRoundController
   }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "SaveSpadesRoundSegue" {
            let maybeInputs = [bid1, bid2, bid3, bid4, tricks1, tricks2, tricks3, tricks4]
            if maybeInputs.contains({$0.text!.isEmpty}) {
                popupAlert("Missing Fields", message: "Please fill in all the fields")
                return false
            }
            
            let round = SpadesRound(
                bid1: Int(bid1.text!)!,
                bid2: Int(bid2.text!)!,
                bid3: Int(bid3.text!)!,
                bid4: Int(bid4.text!)!,
                tricks1: Int(tricks1.text!)!,
                tricks2: Int(tricks2.text!)!,
                tricks3: Int(tricks3.text!)!,
                tricks4: Int(tricks4.text!)!
            )
            // TODO: Validation of individual entries
            if !round.hasValidBids() {
                popupAlert("Invalid Bids", message: "Please enter valid bids for each player")
                return false
            } else if !round.hasValidTricks() {
                popupAlert("Invalid Tricks", message: "Please enter valid tricks for each player")
                return false
            } else {
                self.newRound = round
                return true
            }
        } else {
            return true
        }
    }
}