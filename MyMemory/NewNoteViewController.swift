//
//  NewNoteViewController.swift
//  MyMemory
//
//  Created by DAVY UONG on 8/21/15.
//  Copyright (c) 2015 DAVY UONG. All rights reserved.
//

import UIKit
import Parse

class NewNoteViewController: UIViewController {
    
    var currentNote: Note? {
        didSet {
            self.displayNote(currentNote)
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField?
    @IBOutlet weak var contentTextView: UITextView?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Save" {
            //all outlets resignFirstResponder, and save inputs to local instant
            titleTextField?.endEditing(true)
            let title = titleTextField?.text
            contentTextView?.endEditing(true)
            let content = contentTextView?.text
            
//            print("\ntitleTextField: \(titleTextField?.text)")
//            print("\ncontentTextView: \(contentTextView?.text)")
            
            if currentNote == nil {
                currentNote = Note()
                currentNote?.title = title
                currentNote?.content = content
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField?.layer.borderWidth = 1.0
        titleTextField?.layer.borderColor = UIColor.grayColor().CGColor
        
        contentTextView?.layer.borderWidth = 1.0
        contentTextView?.layer.borderColor = UIColor.grayColor().CGColor
        
        titleTextField?.text = ""
        contentTextView?.text = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayNote(currentNote)
        titleTextField?.returnKeyType = .Next
        titleTextField?.delegate = self
    }
    
    func displayNote(note: Note?) {
        if let note = note {
            print("\ndisplayedNote: \(note)")
            self.titleTextField?.text = note.title
            self.contentTextView?.text = note.content
        }
    }
}

extension NewNoteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == titleTextField {
            contentTextView?.becomeFirstResponder()
            contentTextView?.delegate = self
        }
        return true
    }
}

extension NewNoteViewController: UITextViewDelegate {
    
}

