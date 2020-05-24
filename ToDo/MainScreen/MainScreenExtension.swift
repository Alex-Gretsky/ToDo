//
//  MainScreenExtension.swift
//  ToDo
//
//  Created by a.gretsov on 20.05.2020.
//  Copyright © 2020 a.gretsov. All rights reserved.
//

import UIKit

extension MainScreenTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainScreenTableViewController.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainScreenTableViewCell", for: indexPath) as! MainScreenTableViewCell
        cell.titleLabel.text = MainScreenTableViewController.tasks[indexPath.row].title
        cell.dateLabel.text = MainScreenTableViewController.tasks[indexPath.row].date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            DispatchQueue.global(qos: .default).sync {
                let commit = MainScreenTableViewController.tasks[indexPath.row]
                let context = getContext()
                context.delete(commit)
                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
            MainScreenTableViewController.tasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}
