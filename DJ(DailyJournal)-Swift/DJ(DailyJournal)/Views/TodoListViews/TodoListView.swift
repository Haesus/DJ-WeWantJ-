//
//  TodoListView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/4/24.
//

import SwiftUI

struct TodoListView: View {
    @StateObject var todoListTemplateViewModel = TemplateViewModel<TodoTemplateModel>()
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.ivory]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    TodoListRowView(todoListTemplateViewModel: todoListTemplateViewModel, todoTemplate: $todoListTemplateViewModel.template)
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.lightYellow)
                                    .frame(width: 70, height: 70)
                                Image(systemName: "plus")
                                    .foregroundColor(.ivory)
                                    .font(.system(size: 35, weight: .bold))
                            }
                        })
                        .padding(.bottom, 23)
                        .padding(.trailing, 23)
                    }
                }
            }
            .navigationTitle("TodoList")
            .toolbar {
                Button(action: {
                    todoListTemplateViewModel.saveToJSON(fileName: "TodoTemplate.json")
                }, label: {
                    Text("수정")
                        .foregroundStyle(Color.lightYellow)
                })
            }
        }
        .onAppear(perform: { todoListTemplateViewModel.loadTemplate(templateName: "TodoTemplate.json")
        })
    }
}

#Preview {
    TodoListView()
}
