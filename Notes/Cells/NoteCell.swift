//
//  NoteCell.swift
//  Notes
//
//  Created by Max Nelson on 3/16/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    var note:Note! {
        didSet {
            noteTitle.text = note.title
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM dd, yyyy"
            
            dateLabel.text = dateFormatter.string(from: note.date)
            previewLabel.text = note.text
        }
    }
    
    fileprivate var noteTitle:UILabel = {
        let label = UILabel()
        label.text = "Places to create JPEGs"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    fileprivate var dateLabel:UILabel = {
        let label = UILabel()
        label.text = "7/27/18"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor.gray.withAlphaComponent(1)
        return label
    }()
    
    
    fileprivate var previewLabel:UILabel = {
        let label = UILabel()
        label.text = "Laundromat"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = UIColor.gray.withAlphaComponent(0.8)
        return label
    }()
    
    
    fileprivate lazy var verticalStack:UIStackView = {
        let s = UIStackView(arrangedSubviews: [noteTitle, horizontalStack])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.spacing = 4
        s.axis = .vertical
        return s
    }()

    
    fileprivate lazy var horizontalStack:UIStackView = {
        let s = UIStackView(arrangedSubviews: [dateLabel, previewLabel, UIView()])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.spacing = 10
        s.alignment = .leading
        s.axis = .horizontal
        return s
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(verticalStack)
        verticalStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        verticalStack.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        verticalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
