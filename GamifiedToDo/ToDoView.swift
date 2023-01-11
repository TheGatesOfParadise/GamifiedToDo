//
//  Test1.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/8/23.
//

import SwiftUI

let shadeAreaWidth = UIScreen.main.bounds.width - 20
let shadeAreaBackgroundColor = Color.gray.opacity(0.15)
let cornerRadiusValue = CGFloat(15)
let blueColor = Color(uiColor: UIColor(rgb: 0x638CEB))
let orangeColor = Color(uiColor: UIColor(rgb: 0xFFCC99))
let pinkColor = Color(uiColor: UIColor(rgb: 0xFF6666))

struct ToDoView: View {
    @Binding var user: User
    
    var body: some View {
        VStack (alignment: .center){
            //show avatar
            HeaderView(avatar: user.avatar)
                .frame(width: shadeAreaWidth)
                //.border(.red, width: 1)
                .offset(y:5)
            
            //show award
            MiddleView(award: user.award)
                .frame(width: shadeAreaWidth)
                //.border(.green, width: 1)
            
            //list of todos
            BottomToDoView(toDoList: user.toDoList)
                .frame(width: shadeAreaWidth)
                //.border(.blue, width: 1)
            
            Spacer()
            
        }
    }
}

struct HeaderView: View {
    var avatar: Avatar
    var body: some View {
        HStack {
            AvatarView(avatar: avatar)
                .frame(width:80, height:80)
                .background(.yellow.opacity(0.2))
            
            Spacer()
        }
    }
}

struct MiddleView: View {
    var award: Award
    var body: some View {
        ZStack {
            HStack {
                Text("Coins: \(award.coin)")
                    .frame(width: shadeAreaWidth, height: 70)
                    //.padding(.bottom, 22)
                    .background(shadeAreaBackgroundColor)
                    .cornerRadius(cornerRadiusValue)
                
                Spacer()
            }
            
            Capsule()
                .stroke(blueColor, lineWidth: 3)
                .frame(width: shadeAreaWidth, height: 70)
        }
    }
}

struct BottomToDoView: View {
    var toDoList: [Todo]
    @State private var checked = true
    var body: some View {
        
        ForEach(toDoList) { toDo in
           
            HStack{
                
                CheckView(title: toDo.title,
                          checkColor: toDo.isWithinDays(interval: 3) ? pinkColor : toDo.isWithinDays(interval: 7) ? orangeColor : blueColor)
                    .cornerRadius(cornerRadiusValue)
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

struct ToDoView_Previews: PreviewProvider {
    @State static var user = User.getASampleUser()
    
    static var previews: some View {
        ToDoView(user:$user)
    }
}

