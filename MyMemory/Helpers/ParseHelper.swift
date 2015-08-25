//
//  ParseHelper.swift
//  MyMemory
//
//  Created by DAVY UONG on 8/24/15.
//  Copyright (c) 2015 DAVY UONG. All rights reserved.
//

import Foundation
import Parse

class ParseHelper {
    //Note Relation
    static let ParseNoteClass = "Note"
    
    //Generic
    static let ParseUser = "user"
    static let ParseUpdatedAt = "updatedAt"
    static let ParseObjectId = "objectId"
    
    //User Relation
    static let ParseUserUsername = "username"
    
    static func deleteObject(user: PFUser, object: PFObject)
    {
        let query = PFQuery(className: ParseNoteClass)
        query.whereKey(ParseUser, equalTo: user)
        query.whereKey(ParseObjectId, equalTo: object.objectId!)
        query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
            if let results = results as? [PFObject] {
                print("\nresult.count \(results.count)")
                for deletingObject in results {
                    deletingObject.delete()
                    //deletingObject.deleteInBackgroundWithBlock(nil)
                }
            }
        }
    }
}

extension PFObject: Equatable {
    
}

public func ==(lhs: PFObject, rhs: PFObject) -> Bool {
    //consider any two Parse objects equal if they have the same objectId.
    return lhs.objectId == rhs.objectId
}