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
                notes = notesFromCoreData
                tableView.reloadData()
            }
        }
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 30
        
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let cell = UITableViewCell()
//        let note = notes[indexPath.row]
        cell.textLabel?.text = notes[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }
}

// MARK: Actions
extension NotesViewController {
    @objc func handleNewNote() {
        
        let controller = AddNoteViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
