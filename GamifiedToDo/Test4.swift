//
//  ContentView.swift
//  SwiftUIToDo
//
//  Created by Mom macbook air on 7/24/22.
//

import SwiftUI

class ToDoListItem: Identifiable {
    var name: String?
    var createdAt: Date?
    
    init(name: String? = nil, createdAt: Date? = nil) {
        self.name = name
        
        if createdAt == nil {
            self.createdAt = Date.now
        }
        else {
            self.createdAt = createdAt
        }
    }
}

extension ToDoListItem {
    static func getAllToDoListItems() -> [ToDoListItem] {
       // let request: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest() as! NSFetchRequest<ToDoListItem>
        
    //    let sort = NSSortDescriptor(key: "createdAt", ascending: true)
    //    request.sortDescriptors = [sort]
        
   //     return request
        
 /*       customObjects = customObjects.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })  */
        
        return [ToDoListItem(name: "abc", createdAt: Date().addingTimeInterval(-4 * 24 * 60 * 60)),
                ToDoListItem(name: "def", createdAt: Date().addingTimeInterval(-3 * 24 * 60 * 60)),
                ToDoListItem(name: "def", createdAt: Date.now)
            ]
        
    }
}

struct Test4: View {
    var items = ToDoListItem.getAllToDoListItems()
    @State var text: String = ""

    var body: some View {
        NavigationView {
            List{
                Section(header: Text("New Item")){
                    HStack {
                        TextField("Enter new item...", text: $text)
                        
                        Button(action: {
                            if !text.isEmpty {
                                let newItem = ToDoListItem()
                                newItem.name = text
                                newItem.createdAt = Date()
                                
                                do {
                                    //try viewContext.save()
                                    
                                    print("save")
                                }
                                catch {
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                                text = ""
                            }
                        }, label: {
                            Text("Save")
                        })
                    }
                }
                
                Section {
                    ForEach(items) { toDoListItem in
                        VStack(alignment: .leading) {
                            Text(toDoListItem.name!)
                                .font(.headline)
                            Text("\(toDoListItem.createdAt!)")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        guard let index = indexSet.first else {
                            return
                        }
                        let itemToDelete = items[index]
                       // viewContext.delete(itemToDelete)
                        do {
                           // try viewContext.save()
                        }
                        catch {
                            print(error)
                        }
                    })
                }
            }
            .navigationTitle("To Do List")
        }
    }
}

struct Test4_Previews: PreviewProvider {
    static var previews: some View {
        Test4()
    }
}
