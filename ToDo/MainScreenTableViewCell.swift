//
//  MainScreenTableViewCell.swift
//  ToDo
//
//  Created by a.gretsov on 30.03.2020.
//  Copyright © 2020 a.gretsov. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {

    let dateLabel: UILabel = {
        let date = UILabel()
        date.font = UIFont(name: "Caveat", size: 22)
        date.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        date.textAlignment = .center
        return date
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Caveat", size: 22)
        title.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title.textAlignment = .center
        return title
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        addSubviews()
        titleLayout()
        dateLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout methods
    
    func addSubviews() {
        addSubview(dateLabel)
        addSubview(titleLabel)
    }
    
    func titleLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func dateLayout() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
