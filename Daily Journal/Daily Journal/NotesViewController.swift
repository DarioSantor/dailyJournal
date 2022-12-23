//
//  NotesViewController.swift
//  Daily Journal
//
//  Created by Santos, Dario Ferreira on 21/12/2022.
//

import UIKit

class NotesViewController: UIViewController {
    var notes: [Note] = []
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Daily Journal"
        navigationItem.backButtonTitle = "Done"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleNewNote))
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let notesFromCoreData = try? context.fetch(Note.fetchRequest()) as? [Note] {
                print("antes \(notes)")
                notes = notesFromCoreData
                tableView.reloadData()
                print("depois \(notes)")
            }
        }
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell {
            let note = notes[indexPath.row]
            cell.previewView.text = note.text
            cell.monthView.text = note.month()
            cell.dayView.text = note.day()
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let controller = AddNoteViewController()
        controller.note = note
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: Actions
extension NotesViewController {
    @objc func handleNewNote() {
        
        let controller = AddNoteViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
