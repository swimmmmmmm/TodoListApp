//
//  TableViewCell.swift
//  TodoList
//
//  Created by 서수영 on 3/21/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let cellId = "CellId"

    let todoLabel = UILabel()

    let switchView = UISwitch()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpUI()
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        todoLabel.translatesAutoresizingMaskIntoConstraints = false
        switchView.translatesAutoresizingMaskIntoConstraints = false

        self.isUserInteractionEnabled = true

        switchView.addTarget(self, action: #selector(switchToggle), for: .valueChanged)
    }

    private func setUpHierarchy() {
        self.addSubview(todoLabel)
        self.contentView.addSubview(switchView)
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            todoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            todoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            todoLabel.widthAnchor.constraint(equalToConstant: 312),
            todoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),

            switchView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            switchView.leadingAnchor.constraint(equalTo: todoLabel.trailingAnchor, constant: 4),
            switchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
        ])
    }
}


extension TableViewCell {

    @objc
    private func switchToggle() {
        if switchView.isOn {
            todoLabel.attributedText = todoLabel.text?.strikeThrough()
        }else {
            todoLabel.attributedText = NSAttributedString(string: todoLabel.text!)
        }
    }
}
