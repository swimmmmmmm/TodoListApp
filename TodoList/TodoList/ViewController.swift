//
//  ViewController.swift
//  TodoList
//
//  Created by 서수영 on 3/21/24.
//

import UIKit



class ViewController: UIViewController {

    private let addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("추가하기", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)

        return btn
    }()


    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        Todo.listArr = [Todo(todoText: "할일1", isCompleted: Bool.random()),
                        Todo(todoText: "할일2", isCompleted: Bool.random()),
                        Todo(todoText: "할일3", isCompleted: Bool.random()),
                        Todo(todoText: "할일4", isCompleted: Bool.random()),
                        Todo(todoText: "할일5", isCompleted: Bool.random()),]

        setUpUI()
        setUpHierarchy()
        setUpLayout()
    }

    private func setUpUI() {
        view.backgroundColor = .white

        addBtn.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        addBtn.addTarget(self, action: #selector(addTodo), for: .touchUpInside)

        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setUpHierarchy() {
        view.addSubview(addBtn)
        view.addSubview(tableView)
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            addBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            addBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            addBtn.widthAnchor.constraint(equalToConstant: 68),
            addBtn.heightAnchor.constraint(equalToConstant: 16),

            tableView.topAnchor.constraint(equalTo: addBtn.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ViewController {
    @objc
    fileprivate func addTodo() {
        let alertController: UIAlertController = {
            let alert = UIAlertController(title: nil,
                                          message: "할 일 추가",
                                          preferredStyle: .alert)

            alert.addTextField { field in
                field.placeholder = "할 일을 입력하세요"
            }

            return alert
        }()

        let alertAddAction = UIAlertAction(title: "추가하기", style: .default) { action in
            if let text = alertController.textFields?.first?.text {
                Todo.addList(todo: Todo(todoText: text, isCompleted: false))
                self.tableView.reloadData()
            }
        }

        let alertCancellAction = UIAlertAction(title: "취소", style: .cancel)

        alertController.addAction(alertAddAction)
        alertController.addAction(alertCancellAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Todo.listArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellId, for: indexPath) as! TableViewCell

        let text = Todo.listArr[indexPath.row].todoText
        cell.switchView.isOn = Todo.listArr[indexPath.row].isCompleted

        if cell.switchView.isOn {
            cell.todoLabel.attributedText = text.strikeThrough()
        }else {
            cell.todoLabel.attributedText = NSMutableAttributedString()
            cell.todoLabel.text = text
        }

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            Todo.listArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

        } else if editingStyle == .none {

        }
    }
}

