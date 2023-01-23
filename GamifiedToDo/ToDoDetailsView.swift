///
///
///
///
import SwiftUI

let checkListSignSize = 12.0

enum DetailsType: String {
    case Edit
    case New
}

struct ToDoDetailsView: View {
    @EnvironmentObject var userModel : UserModel
    @Environment(\.dismiss) private var dismiss
    @Binding var toDo: Todo
    @State private var datePopOverPresented = false
    @State var localToDo: Todo = Todo.getAnEmptyToDo()
    @State var hiddenTrigger = false
    var type: DetailsType
    
    init(toDo: Binding<Todo>, type: DetailsType) {
        self._toDo = toDo
        //self._datePopOverPresented = false
        self.type = type
        
        if type == .Edit {
            self._localToDo = State(initialValue: toDo.wrappedValue)
        }
    }
    
    var body: some View {
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
                
                //Tags
                Section (header: Text("Tags")){
                    VStack (spacing: 0){
                        ForEach(Tag.allCases) {tag in
                            // TagCheckBox(tags:$localToDo.tags, currentTag: tag)
                            HStack (alignment: .center){
                                Image(systemName: localToDo.tags.contains(tag) ? "checkmark.square.fill": "square")
                                    .frame(maxHeight: .infinity)
                                    .padding()
                                    .foregroundColor(.black)
                                    .onTapGesture {
                                        //adjust tags
                                        if localToDo.tags.contains(tag) {
                                            let index = localToDo.tags.firstIndex { $0 == tag }
                                            localToDo.tags.remove(at:index!)
                                        }
                                        else {
                                            localToDo.tags.append(tag)
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
                        if type == .Edit {
                            toDo = localToDo
                        }
                        else {
                            userModel.user.toDoList.append(localToDo)
                        }
                        
                        //force a view to update comes from this post:
                        //https://stackoverflow.com/questions/56561630/swiftui-forcing-an-update
                        userModel.updateView()
                        
                        dismiss()
                        
                    }, label: {
                        Text("SAVE")
                            .bold()
                    })
                    .disabled(!fieldsAreFilled())
                }
                
            })
        }
    }
    
    private func fieldsAreFilled() -> Bool {
        var result = false
        if localToDo.title != "" {
                result = true
            }
        return result
    }
}

struct CheckListView: View {
    @Binding var checkList: [Task]
    @State var localEntry: String = ""
    @Binding var hiddenFlag: Bool
    var body: some View{
        List{
            HStack {
                TextField("Enter new item...", text: $localEntry)
                Button(action: {
                    if !localEntry.isEmpty {
                        let newItem = Task(title: localEntry,
                                           difficulty: .easy,
                                           notes: "",
                                           tags: [],
                                           isComplete: false)
                        checkList.append(newItem)
                        localEntry = ""
                    }
                }, label: {
                    Text("Add")
                })
            }
            
            Section {
                ForEach ($checkList) {checkItem in
                    VStack(alignment: .leading) {
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
                    checkList.remove(at: index)
                })
            }
        }
    }
}

struct ToDoDetailsView_Previews: PreviewProvider {
    @StateObject static var user = User.getASampleUser()
    static var previews: some View {
        ToDoDetailsView(toDo: $user.toDoList[0],type: .Edit)
        //ToDoDetailsView(toDo: $toDo, type: .New)
        
        //TODO:  in new case, todo assumes there is at least one item from array
    }
}
