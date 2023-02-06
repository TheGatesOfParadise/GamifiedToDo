///
///DataModel layer for this app
///
///It contains a published variable of User type,  the published variable's content can be updated by the user of this app
///It also contains a variabled of Rules type, it's preset and fixed.
///
///
import Foundation

class DataModel:ObservableObject {
    @Published var user: User {
        didSet {
            saveUser()
        }
    }
  //  var rules: Rules = Rules()
    
    ///initializer
    init() {
        user = User.getASampleUser()
        if let data = UserDefaults.standard.data(forKey: "user") {
            do {
                let decoded = try JSONDecoder().decode(User.self, from: data)
                user = decoded
                print(decoded)
            } catch {
                print(error)
            }
        }
    }

    ///force a view to update comes from this post:
    ///https://stackoverflow.com/questions/56561630/swiftui-forcing-an-update
    func updateView(){
        self.objectWillChange.send()
        saveUser()
    }
    
    ///Persist user to UserDefaults
    func saveUser() {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: "user")
        }
    }
    
    ///Remove a todo from user's todo list
    ///In parameter --`whichIs`: the totdo to be deleted
    func removeToDo(whichIs: Todo) -> Void{
        // guard user.toDoList != nil else { return }
        if let idx = user.toDoList.firstIndex(where: { $0 === whichIs }) {
            user.toDoList.remove(at: idx)
        }
        updateView()
    }
    
    ///Sort todo list based on due date
    func sortToDoListByDueDate() {
        user.toDoList.sort{$0.due_date < $1.due_date}
    }
}
