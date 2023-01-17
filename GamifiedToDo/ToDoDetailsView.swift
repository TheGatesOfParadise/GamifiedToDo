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
    @State var hiddenTrigger = false
    
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
                        CheckListView(checkList: $localToDo.checkList, hiddenFlag: $hiddenTrigger)
                    }
                    
                    
                    //difficulty
                    Section (header: Text("Difficulty Level")){
                        HStack {
                            ForEach(DifficultyLevel.allCases) { level in
                                /*DifficultyLevelButton(selectedLevel: $localToDo.difficulty,
                                 image: level)  */
                                
                                Button(action: {
                                    
                                }) {
                                    Image(localToDo.difficulty == level ? "\(level.rawValue)_filled": level.rawValue)
                                        .resizable()
                                        .frame(width: 60,
                                               height: 50)
                                }
                                .padding()
                                .onTapGesture {
                                    localToDo.difficulty = level
                                    hiddenTrigger.toggle()
                                }
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
                               // TagCheckBox(tags:$localToDo.tags, currentTag: tag)
                                HStack (alignment: .center){
                                    Image(systemName: (localToDo.tags != nil) && localToDo.tags!.contains(tag) ? "checkmark.square.fill": "square")
                                        .frame(maxHeight: .infinity)
                                        .padding()
                                        .foregroundColor(.black)
                                        .onTapGesture {
                                            //adjust tags
                                            if  (localToDo.tags != nil) && localToDo.tags!.contains(tag) {
                                                let index = localToDo.tags!.firstIndex { $0 == tag }
                                                localToDo.tags!.remove(at:index!)
                                            }
                                            else {
                                                localToDo.tags?.append(tag)
                                            }
                                            
                                            hiddenTrigger.toggle()
                                        }
                                    Text(tag.rawValue)
                                        .padding(.top, 10)
                                        .font(.system(size: 18))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                .fixedSize(horizontal: false, vertical: true)
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


struct CheckListView: View {
    @Binding var checkList: [Task]
    @State var localEntry: String = ""
   @Binding var hiddenFlag: Bool
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
                        //Text(checkItem.title.wrappedValue)
                        Label(title: {Text(checkItem.title.wrappedValue)},
                              icon: { Image(systemName: checkItem.isComplete.wrappedValue ? "checkmark.square.fill" : "square")
                            
                        })
                        .onTapGesture {
                           checkItem.isComplete.wrappedValue.toggle()
                            hiddenFlag.toggle()
                        }
                        
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
