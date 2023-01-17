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

struct ToDoView: View {
    @EnvironmentObject var userModel : UserModel
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack (alignment: .center){
                    //show avatar
                    HeaderView()
                        .frame(width: shadeAreaWidth)
                        //.padding(.bottom, 10)
                    //.border(.red, width: 1)
                        .offset(y:5)
                    
                    //show award
                    MiddleView()
                        .frame(width: shadeAreaWidth, height: 70)
                        //.padding(.bottom, 10)
                    //.border(.green, width: 1)
                    
                    //list of todos
                    BottomToDoView()
                        .frame(width: shadeAreaWidth)
                    //.border(.blue, width: 1)
                    
                    Spacer()
                }
                
                AddButtonPopup()
                
            }
        }
    }
}

struct HeaderView: View {
    @EnvironmentObject var userModel : UserModel
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
                        Text("Daily tasks completion")
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
                                .trim(from:0, to: userModel.userDailiesCompletionStatus)
                                .stroke(.yellow,
                                        style: StrokeStyle(lineWidth: 10))
                                .rotationEffect(.init(degrees: -90))
                                .animation(Animation.linear(duration:0.8), value: userModel.userDailiesCompletionStatus)
                                .frame(width: statusCircleHeight, height: statusCircleHeight)
                            
                           
                            Text( String(format: "%.1f", userModel.userDailiesCompletionStatus * 100))
                                .foregroundColor(.white)
                                .font(.system(size:14))
                            
                        }
                        //.padding()
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
               
        }
    }
}

struct BottomToDoView: View {
    @EnvironmentObject var userModel : UserModel
    @State private var checked = true
    var body: some View {
        ForEach($userModel.user.toDoList) { toDo in
            HStack{
                CheckToDoView(toDo: toDo)
                    .cornerRadius(cornerRadiusValue)
                    .padding(.bottom, 5)
            }
        }
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

//TODO: status is not calculated
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
        ToDoView().environmentObject(UserModel(user: User.getASampleUser(), rules: Rules()))
    }
}
//////////////////////////////////////////////////////////////////////////////////////////
//beging of floating add  button
struct AddButtonPopup: View {
    @State var isPopup: Bool = false
    var body: some View {
        
        ///this portion display a blurred view when PopupView is presented
        ///the idea comes from youttube video:
        ///https://www.youtube.com/watch?v=Ik8WmcERros&list=PL5PR3UyfTWvfgx9W8WJ9orQf6N1tx0oxN&index=63
        GeometryReader { proxy in
            /* BlurView(style: viewMode == .original ? .systemThinMaterialLight : .systemThinMaterialDark )
             .opacity(isPopup ? 1 : 0) */
            BlurView(style: .systemThinMaterialDark)
                .opacity(isPopup ? 1 : 0)
        }
        
        ///this portion displays a popup view when user clicks on "+" button
        PopupView(isPopup: $isPopup)
        
        ///display a "+" button if there is no popup, or
        ///dispaly a "x" button when popup is presented
        floatButton(isPopup: $isPopup,
                    textSign: isPopup ? "x" : "+")
    }
}



///
///Blurs entries screen
///
///This comes from a yourtube video:
///https://www.youtube.com/watch?v=Ik8WmcERros&list=PL5PR3UyfTWvfgx9W8WJ9orQf6N1tx0oxN&index=63
///
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        //do nothing
    }
    
    func makeUIView(context: Context) ->  UIVisualEffectView {
        let view = UIVisualEffectView(effect:  UIBlurEffect(style: style))
        return view
    }
}

///
///It shows a popup view which allow users to enter new to-do item
///
struct PopupView: View {
    @Binding var isPopup: Bool
    
    var body: some View {
        ZStack{
            VStack{
                Text("this is a popup view")
            }
        }
        .opacity(isPopup ? 1 : 0)
        .frame(width: 300, height: 400)
        
    }
}


///
///float button at the bottom right corner
///
///it's referenced from this article:
///https://medium.com/programming-with-swift/create-a-floating-action-button-with-swiftui-4d05dcddc365
///
struct floatButton: View {
    @Binding var isPopup: Bool
    var textSign: String
    
    var body: some View {
        VStack{
            //Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isPopup.toggle()
                }, label: {
                    Text(textSign)
                        .font(.system(.largeTitle))
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.white)
                        //.padding(.trailing, 7)
                })
                .background( Color.yellow.opacity(0.6))
                .cornerRadius(30)
                //.padding(.bottom, 10)
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
            }
            Spacer()
            Spacer()
        }
    }
}
//end of floating add button
//////////////////////////////////////////////////////////////////////////////////////////
