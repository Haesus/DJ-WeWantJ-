//
//  TodoListRowView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import SwiftUI

struct TodoListRowView: View {
    @StateObject var todoListTemplateViewModel: TemplateViewModel<TodoTemplateModel>
    @Binding var todoTemplate: TodoTemplateModel?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let todoList = todoTemplate?.todoList {
                List {
                    ForEach(todoList.indices, id: \.self) { index in
                        HStack {
                            Button(action: {
                                todoListTemplateViewModel.template?.todoList[index].isTodo.toggle()
                            }, label: {
                                if todoList[index].isTodo {
                                    Image(systemName: "checkmark.square.fill")
                                } else {
                                    Image(systemName: "checkmark.square")
                                }
                            })
                            Text(" | ")
                            TextField("내용 입력", text: Binding(
                                get: {
                                    todoListTemplateViewModel.template?.todoList[index].todoText ?? ""
                                },
                                set: { newValue in
                                    todoListTemplateViewModel.template?.todoList[index].todoText = newValue
                                }))
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .scrollContentBackground(.hidden)
                .foregroundStyle(Color.ivory)
                .font(.title2)
            }
        }
        .background(Color.clear)
    }
}

#Preview {
    TodoListRowView(todoListTemplateViewModel: TemplateViewModel(), todoTemplate: .constant(TodoTemplateModel(todoList: [Todo(isTodo: false, todoText: "")])))
}
