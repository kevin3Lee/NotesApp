//
//  FolderCell.swift
//  Notes
//
//  Created by Max Nelson on 3/16/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit

class FolderCell: UITableViewCell {
    
    fileprivate var label:UILabel = {
        let label = UILabel()
        label.text = "folder title"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    fileprivate var countLabel:UILabel = {
        let label = UILabel()
        label.text = "7"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    

    fileprivate lazy var stack:UIStackView = {
        let s = UIStackView(arrangedSubviews: [label, UIView(), countLabel])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        return s
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stack)
        stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        stack.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
