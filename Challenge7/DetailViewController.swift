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
    
    let titleView = UILabel()
    var note: Note?
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleView.text = note?.title ?? "Untitled"
        titleView.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        titleView.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: width, height: 500))
        navigationItem.titleView = titleView
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(changeTitle))
        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(recognizer)
        
        textBody.text = note?.body ?? ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.updateNote(note!, titleView.text!, textBody.text!, index!)
        
        delegate?.saveNote()
    }
    
    @objc func changeTitle() {
        let ac = UIAlertController(title: "Edit title", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitTitle = UIAlertAction(title: "Enter", style: .default) { [weak self] _ in
            guard var newTitle = ac.textFields?[0].text else { return }
            if newTitle == "" {
                newTitle = "Untitled"
            }
            self?.titleView.text = newTitle
        }
        
        ac.addAction(submitTitle)
        present(ac, animated: true)
    }
}
