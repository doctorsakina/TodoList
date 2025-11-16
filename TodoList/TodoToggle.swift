//
//  TextViewTableViewCell.swift
//  TodoList
//
//  Created by MacBook Air on 04/11/25.
//

import UIKit
import SnapKit

class TodoToggle: UITableViewCell, UITextViewDelegate {

    let placeholderText = "Something needs to be done..."

    let textView = UITextView()   // <-- вот так правильно

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground

        setupTextView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextView() {
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.backgroundColor = .systemBackground
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        textView.layer.cornerRadius = 11
        textView.textColor = .lightGray
        textView.text = placeholderText
        textView.delegate = self

        contentView.addSubview(textView)
    }

    private func setupConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }
}

//
//
//
//
//class TodoToggle: UITableViewCell , UITextViewDelegate {
//
//    // MARK: - Properties
//
//     let placeholderText = "Something needs to be done..."
//
//    var todoTextView: UITextView  {
//
//        lazy  var textView = UITextView()
//
//        textView.font = .systemFont(ofSize: 16, weight: .regular)
//        textView.backgroundColor = .systemBackground
//        textView.textContainerInset = .zero
//        textView.text = placeholderText
//        // textContainer.lineFragmentPadding ????
//        textView.textContainer.lineFragmentPadding = 0
//        textView.textContainerInset = .init(top:16, left:16, bottom:16, right:16)
//        textView.layer.cornerRadius = 11
//        textView.textColor = .lightGray
//        textView.delegate = self
//        contentView.addSubview(textView)
//
//        return textView
//
//
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .systemBackground
//        updateConstraints()        }
//
//    //setNeedsUpdateConstraints
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func updateConstraints() {
//
//        textView.snp.updateConstraints { make in
//            make.edges.equalToSuperview().inset(16)
//            make.height.equalTo(100)
//        }
//
//        super.updateConstraints()
//    }
//}

    extension TodoToggle : UITableViewDelegate {

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .lightGray {
                textView.text = nil
                textView.textColor = .black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = placeholderText
                textView.textColor = .lightGray
            }
        }
    }

