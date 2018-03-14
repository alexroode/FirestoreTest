//
//  ViewController.swift
//  FirestoreTest
//
//  Created by Alexander Roode on 3/13/18.
//  Copyright © 2018 Alex Roode. All rights reserved.
//


import UIKit
import FirebaseFirestoreUI
import FirebaseDatabaseUI

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var dataSource: FUIFirestoreTableViewDataSource!
    
    //    var dataSource: FUITableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //        let query = Database.database().reference(withPath: "tests")
        //        dataSource = FUITableViewDataSource(query: query, populateCell: { (tableView, indexPath, snapshot) -> UITableViewCell in
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        //            let data = snapshot.value as! [String: Any]
        //            cell.textLabel?.text = data["name"] as? String
        //            return cell
        //        })
        //        dataSource.bind(to: tableView)
        
        let query = Firestore.firestore().collection("tests")
        dataSource = FUIFirestoreTableViewDataSource(query: query, populateCell: { (tableView, indexPath, snapshot) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            let data = snapshot.data()!
            cell.textLabel?.text = data["name"] as? String
            return cell
        })
        dataSource.bind(to: tableView)
        
        query.addSnapshotListener { (snapshot, error) in
            print(snapshot!.documents.map { $0["name"] ?? "" } )
        }
    }
}


