//
//  TodoItemTableViewCell.swift
//  TodoList
//
//  Created by MacBook Air on 27/10/25.
//

import UIKit
import SnapKit

class TodoItemTableViewCell: UITableViewCell {
    
    let myLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        
        myLabel.text = "Cell row"
        myLabel.textColor = .black
        
        contentView.addSubview(myLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        myLabel.snp.updateConstraints { make in make.leading.equalToSuperview().inset(24)
        }
        super.updateConstraints()
    }
}

        
        
        
    // Identificator

