//
//  TodoDetailViewController.swift
//  TodoList
//
//  Created by MacBook Air on 03/11/25.
//

import UIKit
import SnapKit


final class TodoDetailViewController: UIViewController {
    
    var todoItem: TodoItem?
    
       var onFinish: ((TodoItem) -> Void)?

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
    
    
    @objc func cancelButtonTraped() {
        dismiss(animated:true)
    }
    
    @objc func saveButtonTapped() {
        //TODO: Save task
    }
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
