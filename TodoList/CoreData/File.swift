//
//  File.swift
//  TodoList
//
//  Created by MacBook Air on 10/11/25.
//

import Foundation
import CoreData

class PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TodoList")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Failed to load Core Data store: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    func saveContext() {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Core Data save error: \(error)")
            }
        }
    }
}

struct TodoListStore {

    static let context = PersistenceController.shared.viewContext

    static func createTodo(name: String) -> TodoItemEntity {
        let todo = TodoItemEntity(context: context)
        todo.name = name
        todo.isCompleted = false
        save()
        return todo
    }

    static func fetchTodos() -> [TodoItemEntity] {
        let req: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()

        do {
            return try context.fetch(req)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }

    static func toggleDone(_ todo: TodoItemEntity) {
        todo.isCompleted.toggle()
        save()
    }

    static func delete(_ todo: TodoItemEntity) {
        context.delete(todo)
        save()
    }

    static func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save error: \(error)")
            }
        }
    }
}
