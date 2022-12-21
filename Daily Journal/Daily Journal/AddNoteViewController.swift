//
//  AddNoteViewController.swift
//  Daily Journal
//
//  Created by Santos, Dario Ferreira on 21/12/2022.
//

import Foundation
import UIKit

// Create the delegate protocol
protocol AddNoteViewControllerDelegate {
    func addNote(note: Note)
}

class AddNoteViewController: UIViewController {
    var delegate: AddNoteViewControllerDelegate?
    
    var mainVC: NotesViewController?
    
    let datePicker = UIDatePicker()
    let noteText = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AddNoteViewController {
    func setup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
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
        noteText.backgroundColor = .opaqueSeparator
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
    @objc func handleDone(sender: UIButton) {
        let newNote = Note()
        newNote.date = datePicker.date
        newNote.text = noteText.text
        delegate?.addNote(note: newNote)
    }
}

extension AddNoteViewController {
    @objc func handleDelete(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
