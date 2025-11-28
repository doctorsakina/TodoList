//
//  TodolistHeaderView.swift
//  TodoList
//
//  Created by MacBook Air on 29/10/25.
//

import UIKit
import SnapKit

class TodoListHeaderView: UITableViewHeaderFooterView {
    
    let taskName = UILabel()
    let showButton = UIButton()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(taskName)
        contentView.addSubview(showButton)
        
        setupUI()
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        taskName.text = "Заданий - 5"
        taskName.textColor = .lightGray
        
        showButton.setTitle ("Show", for: .normal)
        showButton.setTitleColor(.blue, for: .normal)
    }
   
    
    func updateTaskCount(count: Int) {
        taskName.text = "Tasks: \(count)"
    }
    
    override func updateConstraints() {
        
        taskName.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview()
        }
        
        showButton.snp.updateConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview()
        }
        super.updateConstraints()
    }
}


        // Data Sorce - количество айконов отоброжает
        // Делигат - отрабатывает нажатие (переход на страницу)
        // Header 
        // Footer +

// MVC - хаотичное все в одном
// MVCC - в отдельных
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
