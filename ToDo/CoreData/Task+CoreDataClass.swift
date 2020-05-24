//
//  Task+CoreDataClass.swift
//  ToDo
//
//  Created by a.gretsov on 18.04.2020.
//  Copyright © 2020 a.gretsov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    
    @NSManaged public var date: String
    @NSManaged public var title: String
    
    class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
}
