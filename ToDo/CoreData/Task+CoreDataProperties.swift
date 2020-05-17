//
//  Task+CoreDataProperties.swift
//  ToDo
//
//  Created by a.gretsov on 18.04.2020.
//  Copyright © 2020 a.gretsov. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date: String
    @NSManaged public var title: String

}
