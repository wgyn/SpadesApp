//
//  Utilities.swift
//  SpadesApp
//
//  Created by Ryan Wang on 8/23/15.
//  Copyright © 2015 Gnaw. All rights reserved.
//

import Foundation
import UIKit

func popupAlert(title: String, message: String) {
    let alert = UIAlertView()
    alert.title = title
    alert.message = message
    alert.addButtonWithTitle("Ok")
    alert.show()
}