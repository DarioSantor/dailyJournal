//
//  AddNoteViewController.swift
//  Daily Journal
//
//  Created by Santos, Dario Ferreira on 21/12/2022.
//

import Foundation
import UIKit

class AddNoteViewController: UIViewController {
    
    var mainVC: NotesViewController?
    
    let datePicker = UIDatePicker()
    let noteText = UITextView()
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        if note == nil {
            // Create
        } else {
            noteText.text = note!.text
            if let dateToBeShown = note!.date {
                datePicker.date = dateToBeShown}
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if note == nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let newNote = Note(context: context)
                newNote.date = datePicker.date
                newNote.text = noteText.text
            }
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

extension AddNoteViewController {
    func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleDelete))
        datePicker.becomeFirstResponder()
        style()
        layout()
    }
    
    func style() {
        view.backgroundColor = .white
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        
        noteText.translatesAutoresizingMaskIntoConstraints = false
        noteText.font = .preferredFont(forTextStyle: .body)
        noteText.layer.cornerRadius = 10
        noteText.backgroundColor = .quaternarySystemFill
    }
    
    func layout() {
        view.addSubview(datePicker)
        view.addSubview(noteText)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            noteText.topAnchor.constraint(equalToSystemSpacingBelow: datePicker.bottomAnchor, multiplier: 1),
            noteText.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: noteText.trailingAnchor, multiplier: 1),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: noteText.bottomAnchor, multiplier: 4)
        ])
    }
}

// MARK: Actions
extension AddNoteViewController {
    @objc func handleDelete(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
