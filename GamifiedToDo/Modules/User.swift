///
///
///
///
import Foundation

class UserModel:ObservableObject {
    @Published var user: User {
        didSet {
            saveUser()
        }
    }
    @Published var rules: Rules = Rules()  //TODO:  need published??
    
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
    
    //TODO: revisit logic
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
    
    var userTotalCoin: Int {
        var result: Int = 0
            user.toDoList.forEach { toDo in
                result += getFractionCoinsFromAToDo(toDo: toDo)
            }
        return result
    }
    
    //TODO:  no logic to minus coins if not complete within due date
    func getFractionCoinsFromAToDo (toDo: Todo) -> Int {
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

class User : ObservableObject, Codable  {
    @Published var name: String
    @Published var avatar: Avatar
    @Published var award: Award
    @Published var toDoList: [Todo] = [Todo]()
    
    enum CodingKeys: CodingKey {
        case name
        case avatar
        case award
        case toDoList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        avatar = try container.decode(Avatar.self, forKey: .avatar)
        award = try container.decode(Award.self, forKey: .award)
        toDoList = try container.decode([Todo].self, forKey: .toDoList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(award, forKey: .award)
        try container.encode(toDoList, forKey: .toDoList)
    }
    
    init(name: String, avatar: Avatar, award: Award, toDoList: [Todo]) {
        self.name = name
        self.avatar = avatar
        self.award = award
        self.toDoList = toDoList
    }
    
    static func getASampleUser() -> User {
        let currentDate = Date.now
        var dateComponent = DateComponents()
        dateComponent.day = 2
        let twoDaysFromToday = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        dateComponent.day = 6
        let sixDaysFromToday = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        dateComponent.day = 7
        let sevenDaysFromToday = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        dateComponent.day = 10
        let tenDaysFromToday = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        return User(name: "Adams",
                    avatar: Avatar(parts: [AvatarPart(part: .head, category: .basic, index: 1),
                                           AvatarPart(part: .body, category: .basic, index: 1),
                                           AvatarPart(part: .bottom, category: .basic, index: 1)
                                          ]
                                  ),
                    award: Award(coin:2),
                    toDoList: [Todo(title: "Unit5 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tags: [.school,.chores],
                                    due_date: twoDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tags: [.school],
                                                     isComplete: true),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tags: [.school],
                                                     isComplete: false)
                                    ],
                                    reminder: Date.init("2023/01/26 13:35")),
                               Todo(title: "Unit6 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tags: [.school],
                                    due_date: sixDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tags: [.health],
                                                     isComplete: false),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tags: [.school, .health] ,
                                                     isComplete: false)
                                    ],
                                    reminder: Date.init("2023/01/26 13:35")),
                               Todo(title: "Unit7 MVP",
                                    difficulty: .hard,
                                    notes: "Voiceover",
                                    tags: [.school, .chores],
                                    //due_date: Date.init("2023/02/20 14:50"),
                                    due_date: sevenDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tags: [.school],
                                                     isComplete: false),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tags: [.school, .health],
                                                     isComplete: false)
                                    ],
                                    reminder: Date.init("2023/02/12 14:50")),
                               Todo(title: "Unit8 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tags: [],
                                    due_date: tenDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tags: [.school, .health],
                                                     isComplete: false),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tags: [.school, .health],
                                                     isComplete: false)
                                    ],
                                    reminder: Date.init("2023/01/26 13:35")),
                               Todo(title: "Unit9 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tags: [],
                                    due_date: tenDaysFromToday!,
                                    checkList: [],
                                    reminder: Date.init("2023/01/26 13:35"))]
        )
    }
}
