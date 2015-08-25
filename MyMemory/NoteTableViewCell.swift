//
//  NoteTableViewCell.swift
//  MyMemory
//
//  Created by DAVY UONG on 8/19/15.
//  Copyright (c) 2015 DAVY UONG. All rights reserved.
//

import Foundation
import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //initialize the date formatter only once, using a static computed property
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        //formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
        formatter.dateFormat = "'Date: 'yyyy'-'MM'-'dd' Time: 'HH':'mm':'ss"
        return formatter
    }()
}
