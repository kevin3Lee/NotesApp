//
//  FoldersController
//  Notes
//
//  Created by Max Nelson on 3/15/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit

let notes = [
    Note(title: "Table Views", date: Date(), text: "table views use protocols to recieve data."),
    Note(title: "Collection Views", date: Date(), text: "collection views can be customized with flow layouts to create layouts like you see in the Pinterest app."),
    Note(title: "Flow Layouts", date: Date(), text: "custom layouts can be made with UICollectionViewFlowLayout"),
]

let notesTwo = [
    Note(title: "Instagram", date: Date(), text: "I have two instagram accounts. Maxcodes and maxcodes.io"),
    Note(title: "YouTube Channels", date: Date(), text: "I also have two youtube channels. One for iOS development videos, another for dev vlogs.s"),
]

var noteFolders:[NoteFolder] = [
    NoteFolder(title: "Course Notes", notes: notes),
    NoteFolder(title: "Social Media", notes: notesTwo)
]

class FoldersController: UITableViewController {
    
    fileprivate let CELL_ID = "CELL_ID"
    
    fileprivate let headerView:UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        let label = UILabel(frame: CGRect(x: 20, y: 15, width: 100, height: 20))
        label.text = "ICLOUD"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .darkGray
        headerView.addBorder(toSide: .bottom, withColor: UIColor.lightGray.withAlphaComponent(0.5).cgColor, andThickness: 0.3)
        headerView.addSubview(label)
        return headerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTableView()
    }

    
    fileprivate func setupTableView() {
        tableView.register(FolderCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.tableHeaderView = headerView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Folders"
        self.navigationController?.setToolbarHidden(false, animated: animated)
        self.navigationController?.toolbar.tintColor = .primaryColor
        
        let items:[UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "New Folder", style: .done, target: self, action: #selector(self.handleAddNewFolder))
        ]
        self.toolbarItems = items
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil), animated: false)
        
        setupTranslucentViews()
    }
    
    @objc fileprivate func handleAddNewFolder() {
        let addAlert = UIAlertController(title: "New Folder", message: "Enter a name for this folder.", preferredStyle: .alert)

        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            addAlert.dismiss(animated: true, completion: nil)
        }))
        
        
        var newTitleField:UITextField!
        
        addAlert.addTextField { (tf) in
            newTitleField = tf
        }
        
        addAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            addAlert.dismiss(animated: true, completion: {

            })
            guard let title = newTitleField.text else { return }
            print(newTitleField)
            let newFolder = NoteFolder(title: title, notes: [])
            noteFolders.append(newFolder)
            self.tableView.insertRows(at: [IndexPath(row: noteFolders.count - 1, section: 0)], with: .fade)
        }))
        
        present(addAlert, animated: true, completion: nil)
    }
    
    fileprivate func setupTranslucentViews() {
        let slightWhite = getImageWithColor(color: UIColor.white.withAlphaComponent(0.9), size: CGSize(width: 20, height: 20))
        self.navigationController?.toolbar.setBackgroundImage(slightWhite, forToolbarPosition: .any, barMetrics: .default)
        self.navigationController?.navigationBar.setBackgroundImage(slightWhite, for: UIBarMetrics.default)
        
        // REMOVES LINES
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
    }
}


// MARK:- TABLEVIEW DELEGATE & DATA SOURCE METHODS

extension FoldersController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! FolderCell
        let noteFolderForRow = noteFolders[indexPath.row]
        cell.noteFolder = noteFolderForRow
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderDetailsController = FolderNotesController()
        let noteFolderForRow = noteFolders[indexPath.row]
        folderDetailsController.noteFolder = noteFolderForRow
        navigationController?.pushViewController(folderDetailsController, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteFolders.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print("delete logic goes here")
            noteFolders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [deleteAction]
    }
}
