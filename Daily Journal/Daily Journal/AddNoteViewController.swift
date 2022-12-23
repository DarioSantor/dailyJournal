//
//  AddNoteViewController.swift
//  Daily Journal
//
//  Created by Santos, Dario Ferreira on 21/12/2022.
//

import Foundation
import UIKit

class AddNoteViewController: UIViewController, UITextViewDelegate {

    var mainVC: NotesViewController?

    let datePicker = UIDatePicker()
    let noteText = UITextView()

    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setup()

        if note == nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                note = Note(context: context)
                note?.date = datePicker.date
                note?.text = noteText.text
                noteText.becomeFirstResponder()
            }
        }
        noteText.text = note?.text
        if let dateToBeShown = note?.date {
            datePicker.date = dateToBeShown}
        
        noteText.delegate = self
        
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }

    override func viewWillDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

extension AddNoteViewController {
    func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleDelete))
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
        if note != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(note!)
                try? context.save()
            }
        }
        let controller = NotesViewController()
        controller.tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        note?.text = textView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        note?.date = datePicker.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
