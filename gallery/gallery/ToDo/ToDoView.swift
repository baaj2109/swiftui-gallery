//
//  ToDoView.swift
//  gallery
//
//  Created by kehwa weng on 2024/1/13.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted :Bool
}

struct ToDoView: View {
    
    @State var shake = false
    @State private var tasks = [TodoItem]()
    @State private var newTaskTitle = ""
    var body: some View {
        VStack {
            ForEach($tasks) { task in
                DaneAnimation(task: task)
                    .onTapGesture {
                        withAnimation {
                            if let index = tasks.firstIndex(where: {$0.id == task.id}) {
                                tasks[index].isCompleted.toggle()
                            }
                        }
                    }
            }
            Spacer()
            TextField("new task", text: $newTaskTitle)
                .padding(.leading)
                .frame(height: 50)
                .background(.white, in: RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.1), radius: 10, x:0,y:0)

            Button(action:{
                addTask()
            }, label: {
                Text("Add Task")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 10))
            })
        }
        .padding()
    }
    
    func addTask() {
        let newTask = TodoItem(title: newTaskTitle, isCompleted: false)
        tasks.append(newTask)
        newTaskTitle = ""
    }
}

struct TextSize : ViewModifier {
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader(content: { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
            })
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: { value in
            self.size = value
        })
    }
    private struct SizePreferenceKey: PreferenceKey {
        static var defaultValue: CGSize = .zero
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
    }
}

#Preview {
    ToDoView()
}


struct TaskCompletionCircle: View {
    @Binding var isCompleted : Bool
    var body: some View {
        Circle()
            .frame(width: isCompleted ? 10: 0, height: isCompleted ? 10: 0)
    }
}

struct DaneAnimation: View {
    @Binding var task : TodoItem
    @State private var textsize: CGSize = .zero
    var body: some View {
        ZStack(alignment: .leading) {
            Text(task.title)
                .font(.title)
                .padding(.leading, 60)
                .foregroundStyle(task.isCompleted ? .gray : .black)
                .modifier(TextSize(size: $textsize))
            
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: task.isCompleted ? 0 : 20, height: 5)
                    .opacity(task.isCompleted ? 0 : 1)
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: task.isCompleted ? max(textsize.width - 40, 0) : 20, height: 5)
                    .offset(x: task.isCompleted ? 50 : -30)
                Spacer()
            }
            .foregroundStyle(task.isCompleted ? .gray : .purple)
            .overlay {
                Group{
                    ZStack {
                        TaskCompletionCircle(isCompleted: $task.isCompleted)
                            .offset(y:task.isCompleted ? -38 : 0)
                        TaskCompletionCircle(isCompleted: $task.isCompleted)
                            .offset(y:task.isCompleted ? 38 : 0)
                        VStack(spacing: task.isCompleted ? 30 :0, content: {
                            HStack(spacing: task.isCompleted ? 50: 0, content: {
                                TaskCompletionCircle(isCompleted: $task.isCompleted)
                                TaskCompletionCircle(isCompleted: $task.isCompleted)
                            })
                            HStack(spacing: task.isCompleted ? 50: 0, content: {
                                TaskCompletionCircle(isCompleted: $task.isCompleted)
                                TaskCompletionCircle(isCompleted: $task.isCompleted)
                            })
                        })
                    }
                    .opacity(task.isCompleted ? 0: 1)
                    .overlay {
                        Image(systemName: "checkmark")
                            .bold()
                            .font(.system(size:20))
                            .scaleEffect(task.isCompleted ? 1 : 0)
                    }
                }
                .offset(x: -165)
                .animation(task.isCompleted ? .default: .none , value: task.isCompleted)
            }
        }
        .padding(.leading, 40)
        .onTapGesture {
            withAnimation {
                task.isCompleted.toggle()
            }
        }
    }
}
