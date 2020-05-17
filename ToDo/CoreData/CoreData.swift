//
//  CoreData.swift
//  ToDo
//
//  Created by a.gretsov on 12.04.2020.
//  Copyright © 2020 a.gretsov. All rights reserved.
//

import CoreData
import UIKit

func saveTask(title: String, date: String) {
    let context = getContext()
    guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
    let taskObject = Task(entity: entity, insertInto: context)
    taskObject.title = title
    taskObject.date = date
    
    do {
        try context.save()
        MainScreenTableViewController.tasks.append(taskObject)
    } catch let error as NSError {
        print(error.description)
    }
}

func getTask() {
    let context = getContext()
    let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
    let sortDescriptor = NSSortDescriptor.init(key: "date", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    do {
        MainScreenTableViewController.tasks = try context.fetch(fetchRequest)
        print("получил данные")
    } catch let error as NSError {
        print(error.description)
    }
}

func deleteTask(){
    let context = getContext()
    let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
}

func getContext() -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}
