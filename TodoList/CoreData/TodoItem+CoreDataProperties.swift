//
//  TodoListCoreDataProperties.swift
//  TodoList
//
//  Created by MacBook Air on 16/11/25.
//

import Foundation
import CoreData

extension TodoItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var deadline: Date?
}
