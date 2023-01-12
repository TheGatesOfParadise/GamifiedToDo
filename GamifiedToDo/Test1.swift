
import SwiftUI

struct Test1View: View {
    @State var isChecked:Bool = false
    
    var title:String
    var dueDate: String?
    var numberOfCompleteTask: Int?
    var numberOfTotoalTask: Int?
    var checkColor: Color
    
    @State var dLevel: DifficultyLevel = DifficultyLevel.hard
    
    func toggle(){isChecked = !isChecked}
    
    var body: some View {
        Form {
            Section (header: Text("Difficulty Level")){
                
                HStack {
                    ForEach(DifficultyLevel.allCases) { level in
                        DifficultyLevelButton(selectedLevel: $dLevel,
                                              image: level)
                    }
                }
            }
        }
    }
}

struct Test1View_Previews: PreviewProvider {
    static var previews: some View {
        Test1View(title: "give Ashley's book back. brought the wrong book last time \u{1F600}",
                  dueDate: "1/19/23",
                  numberOfCompleteTask:1,
                  numberOfTotoalTask: 4,
                  checkColor: .red)
    }
}

