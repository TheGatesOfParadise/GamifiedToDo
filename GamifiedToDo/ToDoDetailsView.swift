//
//  ToDoDetailsView.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/11/23.
//

import SwiftUI

let checkListSignSize = 12.0

struct ToDoDetailsView: View {
    @Binding var toDo: Todo
    @State private var datePopOverPresented = false
    @State var localToDo: Todo
    
    init(toDo: Binding<Todo>) {
        self._toDo = toDo
        self.datePopOverPresented = false
        self.localToDo = toDo.wrappedValue
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    
                    //notes
                    Section (header: Text("Task Title")){
                        TextField("",
                                  text: $localToDo.title)
                    }
                    
                    Section (header: Text("Notes")){
                        TextField("",
                                  text:$localToDo.notes)
                    }
                    
                    //checklist TODO
                    Section (header: Text("Checklist (Swipe to delete an existing item)")){
                        CheckListView(checkList: $localToDo.checkList)
                    }
                    
                    
                    //difficulty
                    Section (header: Text("Difficulty Level")){
                        HStack {
                            ForEach(DifficultyLevel.allCases) { level in
                                DifficultyLevelButton(selectedLevel: $localToDo.difficulty,
                                                      image: level)
                            }
                        }
                    }
                    
                    
                    //scheduling -  due date
                    Section (header: Text("Due Date")){
                        HStack{
                            Text(localToDo.dueDateString())
                            Spacer()
                            
                            //date
                            Button(action: {
                                datePopOverPresented = true
                            },
                                   label: {
                                Image(systemName: "calendar")
                                    .foregroundColor(.black)
                            })
                            //date selection popover
                            .popover(isPresented: $datePopOverPresented) {
                                DateSelectionView(dateIn: $localToDo.due_date,
                                                  isShowing: $datePopOverPresented,
                                                  localDate: localToDo.due_date)
                            }
                        }
                    }
                    
                    //reminder???  necessary
                    
                    //Tags
                    Section (header: Text("Tags")){
                        VStack (spacing: 0){
                            ForEach(Tag.allCases) {tag in
                                TagCheckBox(tags:$localToDo.tags, currentTag: tag)
                            }
                        }
                    }
                }//end of form
            }//end of vstack
            .toolbar{
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing,
                                 content: {
                    HStack{
                        Button(action: {
                            //delete this todo
                            //TODO: how to delete this todo without knowing user object
                        }, label: {
                            Text("DELETE")
                                .bold()
                        })
                        
                        Button(action: {
                            toDo = localToDo
                        }, label: {
                            Text("SAVE")
                                .bold()
                        })
                    }
                    
                })
            }
        }  //end of navigationview
    }//end of view
}//end of struct



struct TagCheckBox: View {
    @Binding var tags: [Tag]?
    var currentTag: Tag
    var body: some View {
        HStack (alignment: .center){
            Image(systemName: (tags != nil) && tags!.contains(currentTag) ? "checkmark.square.fill": "square")
                .frame(maxHeight: .infinity)
                .padding()
                .foregroundColor(.black)
                .onTapGesture {
                    //adjust tags
                    if  (tags != nil) && tags!.contains(currentTag) {
                        let index = tags!.firstIndex { $0 == currentTag }
                        tags!.remove(at:index!)
                    }
                    else {
                        tags?.append(currentTag)
                    }
                }
            Text(currentTag.rawValue)
                .padding(.top, 10)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        //.cornerRadius(cornerRadiusValue)
        //.background(.gray.opacity(0.15))
    }
}

//IVY here

struct CheckListView: View {
    @Binding var checkList: [Task]
    @State var localEntry: String = ""
    var body: some View{        
        List{
           // Section(header: Text("New check item")){
                HStack {
                    TextField("Enter new item...", text: $localEntry)
                    
                    Button(action: {
                        if !localEntry.isEmpty {
                            let newItem = Task(title: localEntry,
                                               difficulty: .easy,
                                               notes: "",
                                               tags: [],
                                               isComplete: false)
                            //newItem.name = localEntry
                            //newItem.createdAt = Date()
                            
                            do {
                                //try viewContext.save()
                                
                                checkList.append(newItem)
                                
                                print("Add")
                            }
                            catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                            localEntry = ""
                        }
                    }, label: {
                        Text("Add")
                    })
                }
          //  }
            
            Section {
               // ForEach(items) { toDoListItem in
                ForEach ($checkList) {checkItem in
                    VStack(alignment: .leading) {
                        Text(checkItem.title.wrappedValue)
                    }
                }
                .onDelete(perform: { indexSet in
                    guard let index = indexSet.first else {
                        return
                    }
                    let itemToDelete = $checkList[index]
                   // viewContext.delete(itemToDelete)
                    do {
                       // try viewContext.save()
                        checkList.remove(at: index)
                    }
                    catch {
                        print(error)
                    }
                })
            }
        }
    }
}

struct ToDoDetailsView_Previews: PreviewProvider {
    @StateObject static var user = User.getASampleUser()
    static var previews: some View {
        ToDoDetailsView(toDo: $user.toDoList[0])
    }
}
