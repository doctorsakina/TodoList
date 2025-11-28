//
//  TodoDetailViewController.swift
//  TodoList
//
//  Created by MacBook Air on 03/11/25.
//

import UIKit
import SnapKit
import CoreData


final class TodoDetailViewController: UIViewController {
    
    var todoItem: TodoItemEntity?
    var context: NSManagedObjectContext!
    var onFinish: ((TodoItemEntity) -> Void)?
    
    private var selectedDate: Date?
    private var importance: Int = 1 // 0: низкая, 1: обычная, 2: высокая
    
    // MARK: -UI
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoToggle.self, forCellReuseIdentifier: "text view cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
        return tableView
    } ()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        makeConstraints()
        loadTodoItemData()
        cancelButtonTraped()
        
    }
    
    
    func configureNavigationBar() {
        navigationItem.title = "Todo"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTraped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadTodoItemData() {
        if todoItem != nil {
            // Загружаем существующие данные
            // importance = todoItem.importance
            // selectedDate = todoItem.deadline
        }
    }
    
    
    @objc func cancelButtonTraped() {
        dismiss(animated:true)
    }
    
//    @objc func saveButtonTapped() {
//        guard let textCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TodoToggle,
//              let taskText = textCell.getText(), !taskText.trimmingCharacters(in: .whitespaces).isEmpty else {
//            showAlert(message: "Введите название задачи")
//            return
//        }
//
//        saveTodoItem(name: taskText)
     //   dismiss(animated: true)
   // }
    //
    //    private func saveTodoItem(name: String) {
    //        if let todoItem = todoItem {
    //            todoItem.name = name
    //            todoItem.deadline = selectedDate
    //        } else {
    //            let newTodoItem = TodoItem(context: context)
    //            newTodoItem.name = name
    //            newTodoItem.isCompleted = false
    //            newTodoItem.createdAt = Date()
    //            newTodoItem.deadline = selectedDate
    //        }
    //
    //        do {
    //            try context.save()
    //        } catch {
    //            print("Error saving: \(error)")
    //        }
    //    }
    //
    // остальной код сохранения...
    //    private func saveTodoItem(name: String) {
    //        if let todoItem = todoItem {
    //            todoItem.name = name
    //            todoItem.deadline = selectedDate
    //        } else {
    //            let newTodoItem = TodoItem(context: context)
    //            newTodoItem.name = name
    //            newTodoItem.isCompleted = false
    //            newTodoItem.createdAt = Date()
    //            newTodoItem.deadline = selectedDate
    //        }
    //
    //        do {
    //            try context.save()
    //            print("✅ Todo item saved successfully")
    //        } catch {
    //            print("❌ Error saving: \(error)")
    //            showAlert(message: "Ошибка сохранения")
    //        }
    //    }
    
//    private func showAlert(message: String) {
//        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
    
    
    //
    //@objc func saveButtonTapped(_ sender: UIButton) {
    //    print("Save button tapped") // Добавьте для отладки
    //
    //    guard let name = nameTextField.text, !name.isEmpty else {
    //        showAlert(message: "Введите название задачи")
    //        return
    //    }
    //
    //    saveTodoItem(name: name)
    //    dismiss(animated: true)
    //}
    //
    //    private func saveTodoItem(name: String) {
    //        // Если редактируем существующую задачу
    //        if let todoItem = todoItem {
    //            todoItem.name = name
    //            todoItem.isCompleted = todoItem.isCompleted // сохраняем текущий статус
    //        } else {
    //            // Если создаем новую задачу
    //            let newTodoItem = todoItem(context: context)
    //            newTodoItem.name = name
    //            newTodoItem.isCompleted = false
    //            newTodoItem.createdAt = Date()
    //        }
    //    }
    //}
}
    extension TodoDetailViewController : UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell (withIdentifier: "text view cell", for: indexPath) as! TodoToggle
            cell.selectionStyle = .none
            return cell
        }
    }
    
    extension TodoDetailViewController : UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
    }
