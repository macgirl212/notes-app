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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = noteTitle
        textBody.text = noteBody
    }
}
