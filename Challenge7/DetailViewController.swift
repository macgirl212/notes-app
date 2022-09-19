//
//  DetailViewController.swift
//  Challenge7
//
//  Created by Melody Davis on 9/17/22.
//

import UIKit

protocol DetailViewControllerDelegate {
    func updateNote(_ note: Note, _ newTitle: String, _ newBody: String, _ index: Int)
    
    func saveNote()
}

class DetailViewController: UIViewController {
    @IBOutlet var textBody: UITextView!
    var delegate: DetailViewControllerDelegate?
    
    var note: Note?
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = note?.title ?? "Untitled"
        textBody.text = note?.body ?? ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.updateNote(note!, title!, textBody.text!, index!)
        
        delegate?.saveNote()
    }
}
