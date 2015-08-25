//
//  Note.swift
//  MyMemory
//
//  Created by DAVY UONG on 8/20/15.
//  Copyright (c) 2015 DAVY UONG. All rights reserved.
//

import UIKit
import Parse

class Note: PFObject, PFSubclassing {
    
    //Next, define each property that you want to access on this Parse class.
    @NSManaged var content: String?
    @NSManaged var user: PFUser?
    @NSManaged var title: String?
    
    // MARK: PFSubclassing protocol
    //By implementing the parseClassName you create a connection between the Parse class and your Swift class.
    static func parseClassName() -> String {
        return "Note"
    }
    
    //init and initialize are pure boilerplate code - copy these two into any custom Parse class that you're creating.
    override init() {
        super.init()
    }
    override class func initialize() {
        var onceToken: dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            //inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
    
    dynamic var modificationDate = NSDate()
    
    var uploadTask: UIBackgroundTaskIdentifier?
    
    func uploadNote() {
        uploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.uploadTask!)
        })
        
        self.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.uploadTask!)
        }
        
        user = PFUser.currentUser()
        saveInBackgroundWithBlock(nil)
    }
    
    func updateNote(updateNote: Note?)
    {
        if let updateNote = updateNote {
            self[title!] = updateNote.title
            self[content!] = updateNote.content
        }
    }
}
