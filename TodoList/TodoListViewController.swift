//
//  ViewController.swift
//  TodoList
//
//  Created by MacBook Air on 27/10/25.
//

import UIKit
import SnapKit

class TodoListViewController: UIViewController , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell (withIdentifier: "my cell", for: indexPath) as! TodoItemTableViewCell
        cell.textLabel?.text = "My cell"
        return cell
    }
      
    
    let tableView = UITableView ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My tasks"
        
        // Транзишен
        // Стэк
        // Удаление стори боард
        // Snap kit
        view.backgroundColor = .white
        
        setupTableView()
        makeConstraints()
        
        
        func setupTableView() {
            tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: "my cell")
            tableView.dataSource = self
            
            view.addSubview(tableView)
        }
        
        func makeConstraints() {
            tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    
    }
}

