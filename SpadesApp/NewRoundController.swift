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
    @IBOutlet weak var bid1: UITextField!
    @IBOutlet weak var bid2: UITextField!
    @IBOutlet weak var bid3: UITextField!
    @IBOutlet weak var bid4: UITextField!
    
    @IBOutlet weak var tricks1: UITextField!
    @IBOutlet weak var tricks2: UITextField!
    @IBOutlet weak var tricks3: UITextField!
    @IBOutlet weak var tricks4: UITextField!
    
    @IBOutlet weak var bidPlayer1: UILabel!
    @IBOutlet weak var bidPlayer2: UILabel!
    @IBOutlet weak var bidPlayer3: UILabel!
    @IBOutlet weak var bidPlayer4: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    func popupAlert(title: String, message: String) {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle("Ok")
        alert.show()
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