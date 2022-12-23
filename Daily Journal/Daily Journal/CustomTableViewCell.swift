//
//  CustomTableViewCell.swift
//  Daily Journal
//
//  Created by Santos, Dario Ferreira on 23/12/2022.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    let monthView = UILabel()
    let dayView = UILabel()
    let previewView = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension CustomTableViewCell {
    private func setup() {
        contentView.addSubview(monthView)
        contentView.addSubview(dayView)
        contentView.addSubview(previewView)
        
        monthView.translatesAutoresizingMaskIntoConstraints = false
        monthView.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        monthView.textAlignment = .center
        monthView.text = "MAR"
        
        dayView.translatesAutoresizingMaskIntoConstraints = false
        dayView.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        dayView.textAlignment = .center
        dayView.textColor = .systemRed
        dayView.text = "30"
        
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.font = UIFont.preferredFont(forTextStyle: .body)
        previewView.textAlignment = .left
        previewView.lineBreakMode = NSLineBreakMode.byWordWrapping
        previewView.numberOfLines = 0
        
        previewView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        
        NSLayoutConstraint.activate([
            monthView.widthAnchor.constraint(equalToConstant: 100),
            monthView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            monthView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            dayView.widthAnchor.constraint(equalToConstant: 100),
            bottomAnchor.constraint(equalToSystemSpacingBelow: dayView.bottomAnchor, multiplier: 1),
            dayView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            previewView.leadingAnchor.constraint(equalToSystemSpacingAfter: monthView.trailingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: previewView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: previewView.bottomAnchor, multiplier: 1)
        ])
    }
}
