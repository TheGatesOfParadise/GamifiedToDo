///TODO:
///1. sort list based on due date

import SwiftUI

let shadeAreaWidth = UIScreen.main.bounds.width - 20
let shadeAreaBackgroundColor = Color.gray.opacity(0.15)
let cornerRadiusValue = CGFloat(15)
let blueColor = Color(uiColor: UIColor(rgb: 0x638CEB))
let orangeColor = Color(uiColor: UIColor(rgb: 0xFFCC99))
let pinkColor = Color(uiColor: UIColor(rgb: 0xFF6666))
let statusCircleHeight = 45.0
let middleViewBackgroundColor = UIColor(red:11/255.0, green: 15/255.0, blue: 128/255.0, alpha: 1)
let roundButtonWidth = 35.0

struct ToDoView: View {
    @EnvironmentObject var userModel : UserModel
    @State var selectedCategory = ToDoCategory.All
    @State var selectedTags = [Tag.work, Tag.school, Tag.health, Tag.chores]
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center){
                //show avatar
                HeaderToDoView(selectedCategory: $selectedCategory, selectedTags: $selectedTags)
                    .frame(width: shadeAreaWidth)
                    .offset(y:5)
                
                //show award
                MiddleView()
                    .frame(width: shadeAreaWidth, height: 70)
                
                //list of todos
                BottomToDoView(selectedCategory: selectedCategory, selectedTags: selectedTags)
                    .frame(width: shadeAreaWidth)
           
                Spacer()
            }
        }
    }
}

struct HeaderToDoView: View {
    @EnvironmentObject var userModel : UserModel
    @State private var showingSheet = false
    @Binding var selectedCategory: ToDoCategory
    @Binding var selectedTags: [Tag]
    
    var body: some View {
        HStack {
            AvatarView(avatar: userModel.user.avatar)
                .frame(width:80, height:80)
                .background(.yellow.opacity(0.2))
            
            VStack (alignment: .leading, spacing: 10){
                Text("\(Date().greetings()) \(userModel.user.name)!")
                Text(Date().today())
                    .font(.system(size: 10))
            }
            
            Spacer()
            
            //sort button
            Button(action: {
                showingSheet.toggle()
            }, label: {
                Image("sort_down")
                    .resizable()
                    .font(.system(.largeTitle))
                    .frame(width: roundButtonWidth, height: roundButtonWidth)
                    .foregroundColor(Color.white)
            })
            .background( Color.yellow.opacity(0.6))
            .cornerRadius(roundButtonWidth/2)
            .shadow(color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3)
            .sheet(isPresented: $showingSheet) {
                FilterSheet(showingSheet: $showingSheet, selectedCategory: $selectedCategory, selectedTags: $selectedTags)
                    .presentationDetents([.medium])
              }
            
            //add button TODO:can resue same code
            NavigationLink(destination: {
                ToDoDetailsView(toDo: $userModel.user.toDoList[0], type: .New)
            }, label: {
                Text("+")
                    .font(.system(.largeTitle))
                    .frame(width: roundButtonWidth, height: roundButtonWidth)
                    //.foregroundColor(Color.white)
                    .foregroundColor(Color(middleViewBackgroundColor))
            })
            .background( Color.yellow.opacity(0.6))
            .cornerRadius(roundButtonWidth/2)
            .shadow(color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3)
        }
    }
}

struct MiddleView: View {
    @EnvironmentObject var userModel : UserModel
    var body: some View {
        ZStack {
            Color(middleViewBackgroundColor)
            HStack {
                HStack (spacing:0){
                    Text("Today's completion")
                        .foregroundColor(.white)
                        .font(.system(size:12))
                        .padding()
                    ZStack {
                        //track circle
                        Circle()
                            .stroke(.white.opacity(0.3),
                                    style: StrokeStyle(lineWidth: 10))
                            .frame(width: statusCircleHeight, height: statusCircleHeight)
                        
                        //Andimation circle
                        Circle()
                            .trim(from:0, to: userModel.userToDoCompletionStatus)
                            .stroke(.yellow,
                                    style: StrokeStyle(lineWidth: 10))
                            .rotationEffect(.init(degrees: -90))
                            .animation(Animation.linear(duration:0.8), value: userModel.userToDoCompletionStatus)
                            .frame(width: statusCircleHeight, height: statusCircleHeight)
                        
                        
                        Text( String(format: "%.1f", userModel.userToDoCompletionStatus * 100))
                            .foregroundColor(.white)
                            .font(.system(size:14))
                    }
                }
                Spacer()
                HStack (spacing: 0) {
                    Image("Coin")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    
                    Text(String(format: "coin %i", userModel.userTotalCoin))
                        .foregroundColor(.white)
                        .font(.system(size:18))
                        .padding(.trailing, 10)
                        .padding(.leading, 5)
                }
            }
            
            //fireworks animation
            if userModel.userToDoCompletionStatus == 1.0 {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: -100, y : -50)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: 60, y : 70)
            }
        }
    }
}

struct BottomToDoView: View {
    @EnvironmentObject var userModel : UserModel
    var selectedCategory: ToDoCategory
    var selectedTags: [Tag]
    var body: some View {
        List {
            ForEach($userModel.user.toDoList) { toDo in
                if shouldShowToDo(toDo: toDo.wrappedValue, selectedCategory: selectedCategory, selectedTags: selectedTags){
                    HStack{
                        CheckToDoView(toDo: toDo)
                            .cornerRadius(cornerRadiusValue)
                    }
                }
            }
            .onDelete(perform: { indexSet in
                guard let index = indexSet.first else {
                    return
                }
                userModel.user.toDoList.remove(at: index)
                userModel.updateView()
            })
            .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            .listRowSeparator(.hidden)
        }
        // remove space at the top of List comes from this post:
        //https://developer.apple.com/forums/thread/662544
        .listStyle(PlainListStyle())
    }
    
    func shouldShowToDo(toDo: Todo, selectedCategory: ToDoCategory, selectedTags: [Tag] ) -> Bool {
        var shouldDisplay = false
        
        switch selectedCategory {
        case .Active:
            if toDo.due_date > Date.now.endOfDay && !toDo.isComplete {
                shouldDisplay = true
            }
        case .All :
            shouldDisplay = true
            
        case .Completed :
            shouldDisplay = toDo.isComplete
        }
        
        if !shouldDisplay {
            return false
        }
        
        guard selectedTags.count > 0
        else {
            return shouldDisplay
        }
        
        for tag in selectedTags {
            if toDo.tags.contains(tag) {
                shouldDisplay = true
                break
            }
        }
     
        return shouldDisplay
    }
}

//use rgb to represent a UIColor
//https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


struct StatusCircle : View {
    @State var percent: CGFloat
    var body: some View {
        VStack{
            ZStack {
                Color(UIColor(red:11/255.0,
                              green: 15/255.0,
                              blue: 128/255.0,
                              alpha: 1))
                
                ZStack {
                    //track circle
                    Circle()
                        .stroke(.white.opacity(0.3),
                                style: StrokeStyle(lineWidth: 30))
                    
                    //Andimation circle
                    Circle()
                        .trim(from:0, to: percent)
                        .stroke(.yellow,
                                style: StrokeStyle(lineWidth: 30))
                        .rotationEffect(.init(degrees: -90))
                        .animation(Animation.linear(duration:0.8), value: percent)
                    
                    
                    Text("\(Int(self.percent * 100.0))%")
                        .foregroundColor(.white)
                        .font(.system(size:52))
                    
                }.padding()
            }
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    
    static var previews: some View {
        ToDoView().environmentObject(UserModel())
    }
}
