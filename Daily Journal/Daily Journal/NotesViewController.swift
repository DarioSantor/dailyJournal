//
//  NotesViewController.swift
//  Daily Journal
//
//  Created by Santos, Dario Ferreira on 21/12/2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class NotesViewController: UIViewController {
    var notes: [Note] = []
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Daily Journal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleNewNote))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
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
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}

// MARK: Add Note Delegate
extension NotesViewController: AddNoteViewControllerDelegate {
    func addNote(note: Note) {
        self.dismiss(animated: true) {
            self.notes.append(note)
            self.tableView.reloadData()
        }
    }
}
