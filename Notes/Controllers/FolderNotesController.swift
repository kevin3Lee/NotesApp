//
//  FolderNotesController.swift

//  Notes
//
//  Created by Max Nelson on 3/15/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit

class FolderNotesController: UITableViewController {
    
    var noteFolder:NoteFolder! {
        didSet {
            self.navigationItem.title = noteFolder.title
            self.notes = noteFolder.notes
        }
    }
    
    var notes:[Note] = []
    
    fileprivate let CELL_ID = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.title = "Folder Notes"
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: CELL_ID)
        //        tableView.separatorStyle = .none
        //        tableView.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let items:[UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "5 Notes", style: .plain, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
        ]
        self.toolbarItems = items
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil), animated: false)
    }
}



// MARK:- TABLEVIEW DELEGATE & DATA SOURCE METHODS

extension FolderNotesController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        cell.note = note
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderDetailsController = NoteDetailController()
        let note = notes[indexPath.row]
        folderDetailsController.note = note
        navigationController?.pushViewController(folderDetailsController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
