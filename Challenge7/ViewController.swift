//
//  ViewController.swift
//  Challenge7
//
//  Created by Melody Davis on 9/17/22.
//

import UIKit

class ViewController: UITableViewController {
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Notes"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        /*
        let defaults = UserDefaults.standard
        
        if let previousData = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: previousData)
            } catch {
                print("Failed to load previous data")
            }
        }
        */
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title // textLabel will be depreciated soon
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.noteTitle = notes[indexPath.row].title
            vc.noteBody = notes[indexPath.row].body
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let newNote = Note(title: "New Note", body: "")
            vc.noteTitle = newNote.title
            vc.noteBody = newNote.body
            navigationController?.pushViewController(vc, animated: true)
            
            // new note is not saving -- fix later
            dismiss(animated: true, completion: { [weak self] in
                newNote.body = vc.noteBody ?? ""
                
                self?.notes.insert(newNote, at: 0)
                
                let indexPath = IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
                self?.tableView.reloadData()
            })
        }
    }
    /*
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save notes")
        }
    }
    */
}

