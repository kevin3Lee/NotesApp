//
//  FoldersController
//  Notes
//
//  Created by Max Nelson on 3/15/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Folders"
        self.navigationController?.setToolbarHidden(false, animated: animated)
        self.navigationController?.toolbar.tintColor = .primaryColor
        
        let items:[UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "New Folder", style: .done, target: nil, action: nil)
        ]
        self.toolbarItems = items
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil), animated: false)
        
        setupTranslucentViews()
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
//        cell.textLabel?.text = "note"
        cell.accessoryType = .disclosureIndicator
//        cell.addBorder(toSide: .bottom, withColor: UIColor.lightGray.withAlphaComponent(0.5).cgColor, andThickness: 0.3)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderDetailsController = FolderNotesController()
        navigationController?.pushViewController(folderDetailsController, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}