//
//  Todo.swift
//  TodoList
//
//  Created by 서수영 on 3/21/24.
//

import Foundation

struct Todo {
    static var listArr = [Todo]()

    let todoText: String
    let isCompleted: Bool
    private let uuid: UUID

    static func addList(todo: Todo) {
        Self.listArr.append(todo)
    }

    init(todoText: String, isCompleted: Bool) {
        self.todoText = todoText
        self.isCompleted = isCompleted
        self.uuid = UUID()
    }
}
