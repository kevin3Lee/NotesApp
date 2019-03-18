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
            self.filteredNotes = noteFolder.notes
            if let target = noteFolders.firstIndex(where: { (noteFolder) -> Bool in
                return noteFolder == self.noteFolder
            }) {
                noteFolders[target].notes = self.notes
                self.folderIndex = target
            }
         
        }
    }

    
    var folderIndex:Int = -1
    var notes:[Note] = []
    var filteredNotes:[Note] = []
    
    fileprivate var cachedText:String = ""
    
    fileprivate let CELL_ID = "CELL_ID"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.title = "Folder Notes"
        setupTableView()
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
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
            UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(self.handleWriteNewNote))
        ]
        self.toolbarItems = items
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil), animated: false)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let updatedFolder = noteFolders[folderIndex]
        if updatedFolder.notes.count > noteFolder.notes.count {
            noteFolder = updatedFolder
            let newIndexPath = IndexPath(row: noteFolder.notes.count - 1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        } else {
            noteFolder = updatedFolder
            tableView.reloadData()
        }


    }
    
    
    @objc fileprivate func handleWriteNewNote() {
        pushNoteDetail()
    }
    
    fileprivate func pushNoteDetail() {
        let folderDetailsController = NoteDetailController()
        folderDetailsController.noteFolderIndex = folderIndex
        navigationController?.pushViewController(folderDetailsController, animated: true)
    }
}

extension FolderNotesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNotes = notes.filter({ (note) -> Bool in
            return note.title.lowercased().contains(searchText.lowercased())
        })
//        searchText.isEmpty && filteredNotes.isEmpty ? filteredNotes = notes : ()
        if searchBar.text!.isEmpty && filteredNotes.isEmpty {
            filteredNotes = notes
        }
        cachedText = searchText
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.text!.isEmpty && filteredNotes.isEmpty ? filteredNotes = notes : ()

        if !cachedText.isEmpty && !filteredNotes.isEmpty {
            searchController.searchBar.text = cachedText
        }
        if searchBar.text!.isEmpty && filteredNotes.isEmpty {
            filteredNotes = notes
        }
        tableView.reloadData()
    }
    
}



// MARK:- TABLEVIEW DELEGATE & DATA SOURCE METHODS

extension FolderNotesController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! NoteCell
        let note = filteredNotes[indexPath.row]
        cell.note = note
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderDetailsController = NoteDetailController()
        let note = notes[indexPath.row]
        folderDetailsController.note = note
        folderDetailsController.noteFolderIndex = folderIndex
        navigationController?.pushViewController(folderDetailsController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print("delete logic goes here")
//            if var currentFolder = noteFolders.first(where: { $0.notes == self.notes }) {
//
//                currentFolder.notes.remove(at: indexPath.row)
//            }
          self.filteredNotes.remove(at: indexPath.row)
          self.notes.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .fade)
        
//            if let target = noteFolders.firstIndex(where: { (noteFolder) -> Bool in
//                return noteFolder == self.noteFolder
//            }) {
//                noteFolders[target].notes = self.notes
//            }

            
            noteFolders[self.folderIndex].notes = self.notes
     
      
            
        }
        return [deleteAction]
    }
}

