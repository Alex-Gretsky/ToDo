//
//  MainScreenTableViewController.swift
//  ToDo
//
//  Created by a.gretsov on 30.03.2020.
//  Copyright © 2020 a.gretsov. All rights reserved.
//

import UIKit
import CoreData

class MainScreenTableViewController: UITableViewController {

    private let plusButton: UIButton = {
        var plus = UIButton()
        plus.setImage(#imageLiteral(resourceName: "plusButton2"), for: .normal)
        plus.layer.cornerRadius = 60.0
        plus.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        plus.layer.shadowOpacity = 0.6
        plus.layer.shadowRadius = 7.0
        plus.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
        return plus
    }()
    
    static var tasks = [Task]()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProperties()
        addSubviews()
        plusLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getTask()
    }
    
    // MARK: - Layout methods
    
    private func plusLayout() {
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 74).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 74).isActive = true
    }
    
    private func addSubviews() {
        view.addSubview(plusButton)
    }
    
    // MARK: - Selector methods
    
    @objc private func showPopup() {
        let newVC = PopupViewController()
        newVC.modalTransitionStyle = .crossDissolve
        newVC.modalPresentationStyle = .overCurrentContext
        present(newVC, animated: true)
    }
    
    @objc private func loadList(notification: NSNotification){
        DispatchQueue.global(qos: .default).sync {
            getTask()
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Internal methods
    
    private func tableViewProperties() {
        self.title = "My To Do"
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backgroundImage"))
        self.tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: "MainScreenTableViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
}

