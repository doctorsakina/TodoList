//
//  TodoItemTableViewCell.swift
//  TodoList
//
//  Created by MacBook Air on 15/11/25.
//

import SwiftUI
import SnapKit
import CoreData

class TodoItemTableViewCell: UITableViewCell {
    
    let checkButton = UIImageView(image: UIImage(systemName: "circle"))
    let titleLabel = UILabel()
    let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(checkButton)
        
        setupUI()
        
        setNeedsUpdateConstraints()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override var isSelected : Bool{
        didSet {
//            circleImageView.image = isSelected
        }
    }

    func setupUI() {
        checkButton.tintColor = .tertiaryLabel
        checkButton.contentMode = .scaleAspectFit
        
        chevronImageView.tintColor = .tertiaryLabel
        chevronImageView.contentMode = .scaleAspectFit
        
        checkButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    func configure(_ title: String, isCompleted:Bool) {
        
        if isCompleted {
            //
            checkButton.tintColor = UIColor(named:"successColor")
            
            titleLabel.textColor = .tertiaryLabel
            
            let attributeString = NSMutableAttributedString(string: title)
            attributeString.addAttribute(
                .strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: title.count)
            )
            
            titleLabel.attributedText = attributeString
            
        } else {
            checkButton.image = (UIImage(contentsOfFile: "circle"))
            checkButton.tintColor = .tertiaryLabel
            
            titleLabel.textColor = .label
            titleLabel.attributedText = NSAttributedString(string: title)
        }
    }
           
    
    override func updateConstraints() {
        checkButton.snp.updateConstraints { make in make.leading.verticalEdges.equalToSuperview().inset(16)
            make.size.equalTo(22)
        }
    
        checkButton.snp.updateConstraints { make in
        make.leading.equalTo(checkButton.snp.trailing).offset(8)
        make.verticalEdges.equalToSuperview().inset(16)
        }
        
        chevronImageView.snp.updateConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(16)
            }
        super.updateConstraints()
    }
    
    @objc func handleTap() {
        checkButton.setImage(UIImage(systemName: "checkmark.circle.image") , for: .normal)
            checkButton.tintColor = UIColor(named: "successColor")
    }
}

        // REVOLUT
    // Identificator

//UITableViewCell
