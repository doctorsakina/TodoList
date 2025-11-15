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
    
    var todoItems: [TodoItem] = [
        .init(name:"Купить сыр"),
        .init(name:"Банальные, но неопровержимые выводы, а также акционеры крупнейших компаний и по..."),
            .init(name: "Задание")
    ]
    
    lazy var  tableView : UITableView = {
        tableView.register(TodoListHeaderView.self, forHeaderFooterViewReuseIdentifier: "my header")
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: "my cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        return tableView
    } ()
     
    
    lazy var addButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "Plus"), for: .normal)
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

        let request: NSFetchRequest<TodoItemEntity> = todoItemEntity.fetchRequest()

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
                let entity = todoEntities(context: self.context)
                entity.isCompleted = sample.isCompleted
            }

            do {
                try self.context.save{
               
                }
                
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
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .none)                }
            } catch {
                print("Toggle save error: \(error)")
            }
        }
    }

    
    func presentDetailScreen( _ item: TodoItem? = nil) {
      let vc = TodoDetailViewController()
        vc.todoItem = item
        vc.onFinish = { newItem in
            self.todoItems.append(newItem)
            self.tableView.reloadData()
    }
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated:true)

    }

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
                    guard let self = self, let cell = cell ,let currentIndexRath = tableView.indexPath(for: cell)
                    else {return}
                    self.handleTodoCompletion(at: currentIndexPath.row)
                    self.todoItems[currentIndexPath.row].isCompleted.toggle()
                }
                return cell
            }
        }
        
        
        extension TodoListViewController: UITableViewDelegate {
        
            func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let view  = tableView.dequeueReusableHeaderFooterView( withIdentifier: "my header") as! TodoListHeaderView
            view.updateTaskCount( count: TodoItems.count)
            return view
               }
    }
