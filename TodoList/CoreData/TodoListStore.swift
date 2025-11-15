//
//  TodoListStore.swift
//  TodoList
//
//  Created by MacBook Air on 11/11/25.
//

import Foundation
import CoreData

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
