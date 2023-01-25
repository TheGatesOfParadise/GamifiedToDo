///
///DataModel layer for this app
///
///It contains a published variable of User type,  the published variable's content can be updated by the user of this app
///Another variabled is of Rules type, it's preset and fixed.
///
///
import Foundation

class DataModel:ObservableObject {
    @Published var user: User {
        didSet {
            saveUser()
        }
    }
    var rules: Rules = Rules()
    
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

    var userToDoCompletionStatus: CGFloat {
        var total: Int = 0
        var completed: Int = 0
        
        user.toDoList.forEach{ toDo in
            //look for due_date is today's to do item, only calculate those
            if toDo.due_date.isWithInToday() {
                total += rules.getAward(taskLevel: toDo.difficulty).coin
                completed += getFractionCoinsFromAToDo(toDo: toDo)
            }
        }
        
        if total == 0 {
            return 0.0
        }
        else {
            return Double(completed) / Double(total)
        }
    }
 /*
    var userTotalCoin: Int {
        var result: Int = 0
        user.toDoList.forEach { toDo in
            result += getFractionCoinsFromAToDo(toDo: toDo)
        }
        return result - userAvatarCoin
    }
    
    private var userAvatarCoin: Int {
        var result: Int = 0
        for avatarPart in user.avatar.parts {
            result += rules.getAward(avatarPart: avatarPart).coin
        }
        return result
    }
  */
    
    //if it's overdue todo, no coin regardless it's complete or not
    func getFractionCoinsFromAToDo (toDo: Todo) -> Int {
        guard !toDo.due_date.isOverDue()
        else {
            return 0
        }
        
        var result = 0;
        if toDo.isComplete {
            result += rules.getAward(taskLevel: toDo.difficulty).coin
        }
        else {
            let toDoItemCoin = rules.getAward(taskLevel: toDo.difficulty).coin
            if toDo.checkList.count > 0  {
                let toDoItemCheckItemCoin = toDoItemCoin/toDo.checkList.count
                toDo.checkList.forEach{ checkItem in
                    if checkItem.isComplete {
                        result += toDoItemCheckItemCoin
                    }
                }
            }
        }
        
        return result
    }
    
    //force a view to update comes from this post:
    //https://stackoverflow.com/questions/56561630/swiftui-forcing-an-update
    func updateView(){
        self.objectWillChange.send()
        saveUser()
    }
    
    func saveUser() {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: "user")
        }
    }
    
    func removeToDo(whichIs: Todo) -> Void{
        // guard user.toDoList != nil else { return }
        if let idx = user.toDoList.firstIndex(where: { $0 === whichIs }) {
            user.toDoList.remove(at: idx)
        }
        updateView()
    }
    
    func sortToDoListByDueDate() {
        user.toDoList.sort{$0.due_date < $1.due_date}
    }
}
