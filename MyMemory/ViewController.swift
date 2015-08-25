//
//  ViewController.swift
//  MyMemory
//
//  Created by DAVY UONG on 8/19/15.
//  Copyright (c) 2015 DAVY UONG. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var selectedNote: Note?
    
    var notes: [Note] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    @IBAction func logoutAction(sender: AnyObject) {
        let alertController = UIAlertController(title: "Logout?", message: nil, preferredStyle: .ActionSheet)
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            PFUser.logOut()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.loginSetup()
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let noteQuery = PFQuery(className: "Note")
        noteQuery.whereKey("user", equalTo: PFUser.currentUser()!)
        //noteQuery.includeKey("objectId")
        noteQuery.includeKey("user")
        noteQuery.orderByDescending("updatedAt")
        noteQuery.findObjectsInBackgroundWithBlock { (result: [AnyObject]?, error: NSError?) -> Void in
            self.notes = result as? [Note] ?? []
            self.tableView.reloadData()
        }
    }
    
    func deleteNote(deletingNote: Note?)
    {
        notes = notes.filter({ (note) -> Bool in
            note != deletingNote
        })
        ParseHelper.deleteObject(PFUser.currentUser()!, object: deletingNote!)
    }
    
    //MARK: Navigation
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Save":
                let source = segue.sourceViewController as! NewNoteViewController
                let note = source.currentNote!

                if ParseHelper.isObjectExistedYesUpdateItWithObject(source.currentNote!) == false {
                    note.uploadNote()
                }                
            case "Delete":
                let source = segue.sourceViewController as! NewNoteViewController
                let deletingNote = source.currentNote!
                deleteNote(deletingNote)
            default:
                print("\nUnknown identifier: \(identifier)")
            }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowExistingNote" {
            let newNoteViewController = segue.destinationViewController as! NewNoteViewController
            //print("\nselectedNote: \(selectedNote)")
            newNoteViewController.currentNote = selectedNote
        }
    }
}

//MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! NoteTableViewCell
        let note = notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.dateLabel.text = NoteTableViewCell.dateFormatter.stringFromDate(note.updatedAt!)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedNote = notes[indexPath.row]
        self.performSegueWithIdentifier("ShowExistingNote", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let deletingNote = notes[indexPath.row] as Note
            deleteNote(deletingNote)
        }
    }
}
