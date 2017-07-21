//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import CoreData

class DisplayNoteViewController: UIViewController {
    var note: Note?
    var businesses: [Business]!
    var list: [Any?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
             // if note exists, update title and content
            let note = self.note ?? CoreDataHelper.newNote()
            note.title = noteTitleTextField.text ?? ""
            note.content = noteContentTextView.text ?? ""
            note.modificationTime = Date() as NSDate
            CoreDataHelper.saveNote()
            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//            var location = NSEntityDescription.insertNewObject(forEntityName: "", into: list)
            
            Business.searchWithTerm(term: note.title!, completion: { (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                if let businesses = businesses {
                      for business in businesses {
                        self.list.append(business.latitude!)
                        self.list.append(business.longitude!)
                    }
                }
            }
            )
        }
    }
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = note {
            // 2
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            // 3
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
    
}
