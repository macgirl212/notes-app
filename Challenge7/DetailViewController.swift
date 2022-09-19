//
//  DetailViewController.swift
//  Challenge7
//
//  Created by Melody Davis on 9/17/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var textBody: UITextView!
    var noteTitle: String?
    var noteBody: String?
    var index: Int?
    weak var delegate: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = noteTitle
        textBody.text = noteBody
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.updateNote(updatedNoteTitle: title!, updatedNoteBody: textBody.text!, index: index ?? 0)
        delegate?.save()
    }
}
