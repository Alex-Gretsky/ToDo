//
//  NavigationController.swift
//  ToDo
//
//  Created by a.gretsov on 30.03.2020.
//  Copyright © 2020 a.gretsov. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        nagationBarProperties()
    }
    
    private func nagationBarProperties() {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Artbrush", size: 24)]
        self.navigationBar.barStyle = .blackTranslucent
    }
}
