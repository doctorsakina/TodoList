//
//  ViewController.swift
//  TodoList
//
//  Created by MacBook Air on 27/10/25.
//

import SwiftUI
import CoreData


class TodoListViewController : UIViewController {
    
    let context: NSManagedObjectContext
       
    
    var todoEntities: [TodoItemEntity] = []
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(TodoListHeaderView.self, forHeaderFooterViewReuseIdentifier: "my header")
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: "my cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        return tableView
    } ()
    
    lazy var addButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 36/2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    } ()
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
        print("✅ TodoListViewController created with context")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isToolbarHidden = false
        navigationItem.title = "My tasks"
        
        makeConstraints()
        loadTodoEntities()
        
        //        view.backgroundColor = .systemBackground
        
        // Транзишен
        // Стэк
        // Удаление стори боард
        // Snap kit
        
        let addButton = UIBarButtonItem(customView: addButton)
        
        toolbarItems = [UIBarButtonItem(systemItem: .flexibleSpace), addButton, UIBarButtonItem(systemItem: .flexibleSpace)]
        
        
        
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addButton.snp.makeConstraints { make in make.size.equalTo(36)
        }
    }
    
    func loadTodoEntities() {
        
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()
        
        context.perform {
            
            do {
                let fetchedData = try self.context.fetch(request)
                DispatchQueue.main.async {
                    if fetchedData.isEmpty {
                        self.setInitialTodosIfNeeded()
                    } else {
                        self.todoEntities = fetchedData
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Fetch error: \(error)")
            }
        }
    }
    
    
    func setInitialTodosIfNeeded() {
        context.perform {
            for sample in self.todoEntities {
                let entity = TodoItemEntity(context: self.context)
                entity.isCompleted = sample.isCompleted
            }
            
            do {
                try self.context.save()
            } catch {
                print("Initial setting error: \(error)")
            }
            self.loadTodoEntities()
        }
    }
    
    func handleTodoCompletion (at index: Int) {
        let entity = todoEntities[index]
        
        context.perform {
            entity.isCompleted.toggle()
            
            do {
                try self.context.save()
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
                }
            } catch {
                print("Toggle save error: \(error)")
            }
        }
    }
    
    
    func presentDetailScreen( _ item: TodoItemEntity? = nil) {
        let vc = TodoDetailViewController()
        vc.todoItem = item
        vc.context = context
        
        vc.onFinish = { newItem in
            self.todoEntities.append(newItem)
            self.tableView.reloadData()
        }
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated:true)
        
    }
    
    // HOMEWORK
    
//      func addTodoItem() {
//        let alert = UIAlertController(title: "New TodoItem", message: nil, preferredStyle: .alert)
//        alert.addTextField { $0.placeholder = "Enter text" }
//        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
//            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
//            TodoListStore.todo(text: text)
//            self.todoEntities = PersistenceController.shared.fetchTodos()
//            self.tableView.reloadData()
//        } ))
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        present(alert, animated: true)
//    }
//
//
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
//                   forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let entity = todoEntities[indexPath.row]
//
//            // Удаляем из Core Data
//            TodoListStore.delete(TodoItemEntity)
//
//            // Удаляем из массива для UI
//            todoEntities.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
    //
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
    //                   forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            let todo = todoEntities[indexPath.row]
    //            TodoListStore.delete(TodoItemEntity)
    //            todoEntities.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .automatic)
    //        }
    //    }
    //
//        TodoListStore.toggleDone(todoEntities[indexPath.row])
//        tableView.reloadRows(at: [indexPath], with: .automatic)
//
//        let newTodo = TodoListStore.createTodo(name: "Новая заметка")
//    todoItem.append(newTodo)
//        tableView.reloadData()
//
    
    @objc func addTapped()  {
        presentDetailScreen()
        
    }
}
    
    extension TodoListViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return todoEntities.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell (withIdentifier: "my cell", for: indexPath) as! TodoItemTableViewCell
            
            let entity = todoEntities[indexPath.row]
            
            cell.selectionStyle = .none
            cell.configure(entity.name ?? "", isCompleted: entity.isCompleted)
            
            cell.onToggleCompletion = { [weak self, weak cell] in
                guard let self = self, let cell = cell ,
                      let currentIndexPath = tableView.indexPath(for: cell)
                else {return}
                self.handleTodoCompletion(at: currentIndexPath.row)
                self.todoEntities[currentIndexPath.row].isCompleted.toggle()
            }
            return cell
        }
    }

        extension TodoListViewController: UITableViewDelegate {
            
            func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                let view  = tableView.dequeueReusableHeaderFooterView( withIdentifier: "my header") as! TodoListHeaderView
                view.updateTaskCount( count: todoEntities.count)
                return view
            }
        }
        
