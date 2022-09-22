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

        title = "Notes"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        let defaults = UserDefaults.standard
        
        if let previousData = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: previousData)
            } catch {
                print("Failed to load previous data")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let note = notes[indexPath.row]
        let noteDate = formatDate(notes[indexPath.row].updatedDate)
        
        var content = cell.defaultContentConfiguration()
        content.text = note.title
        content.secondaryText = "\(noteDate)  \(note.body)"      
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.delegate = self
            
            vc.note = notes[indexPath.row]
            vc.index = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            save()
        }
    }
    
    @objc func addNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let indexPath = IndexPath(row: 0, section: 0)
            let newNote = Note(title: "New Note", body: "")
            
            vc.delegate = self
            
            vc.note = newNote
            vc.index = indexPath.row
            
            navigationController?.pushViewController(vc, animated: true)
            
            dismiss(animated: true, completion: { [weak self] in
                self?.notes.insert(newNote, at: 0)
                
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
                self?.tableView.reloadData()
            })
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "MM/dd/yy h:mm a"
        let dateString = format.string(from: date)
        return dateString
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save notes")
        }
    }
}

extension ViewController: DetailViewControllerDelegate {
    func updateNote(_ note: Note, _ newTitle: String, _ newBody: String, _ index: Int) {
        let currentDate = Date()
        
        notes[index].title = newTitle
        notes[index].body = newBody
        notes[index].updatedDate = currentDate
        tableView.reloadData()
    }
    
    func saveNote() {
        save()
    }
}

