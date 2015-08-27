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
    @IBOutlet weak var searchBar: UISearchBar!
    // the current parse query
    var query: PFQuery? {
        didSet {
            oldValue?.cancel()
        }
    }
    // this view can be in two different states
    enum State {
        case DefaultMode
        case SearchMode
    }
    // whenever the state changes, perform one of the two queries and update the list
    var state: State = State.DefaultMode {
        didSet {
            switch state {
            case State.DefaultMode:
                query = ParseHelper.getQueryForAllObjects(updateList)
            case State.SearchMode:
                let searchText = searchBar.text ?? ""
                query = ParseHelper.searchObjectWithSearchText(searchText, completionBlock: updateList)
            }
        }
    }
    
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
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func deleteNote(deletingNote: Note?)
    {
        notes = notes.filter({ (note) -> Bool in
            note != deletingNote
        })
        ParseHelper.deleteObject(PFUser.currentUser()!, object: deletingNote!)
    }
    
    // MARK: Update userlist
    
    /**
    Is called as the completion block of all queries.
    As soon as a query completes, this method updates the Table View.
    */
    func updateList(results: [AnyObject]?, error: NSError?) {
        self.notes = results as? [Note] ?? []
        self.tableView.reloadData()
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

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        state = State.SearchMode
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        state = State.DefaultMode
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        ParseHelper.searchObjectWithSearchText(searchText, completionBlock: updateList)
    }
}