//
//  CheckView.swift
//  unit 4 proj
//
//  Created by Scarlett Ruan on 11/7/22.
//
///This view display a check next to a text in one line
///
///Parameter name: title is a String type, it's get displayed next to the checkbox
///
///The code is referenced from this article:
///https://makeapppie.com/2019/10/16/checkboxes-in-swiftui/
///
import SwiftUI

struct CheckToDoView: View {
    @EnvironmentObject var userModel : UserModel
    @State var hiddenFlag:Bool = false
    @Binding var toDo: Todo
    
    func checkColor() -> Color {
      /*  return  toDo.isWithinDays(interval: 3) ? pinkColor : toDo.isWithinDays(interval: 7) ? orangeColor : blueColor
       */
        return toDo.difficulty == .easy ? .green : toDo.difficulty == .medium ? .orange : pinkColor
    }
    
    var body: some View {
        HStack (alignment: .center){
            Image(systemName: toDo.isComplete ? "checkmark.circle.fill": "circle")
                .frame(maxHeight: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(checkColor())
                .onTapGesture {
                    toDo.isComplete.toggle()
                    
                    //force a view to update comes from this post:
                    //https://stackoverflow.com/questions/56561630/swiftui-forcing-an-update
                    userModel.updateView()
                    hiddenFlag.toggle()
                }
            
            VStack (alignment: .leading){
                NavigationLink(
                    destination: ToDoDetailsView(toDo: $toDo, type: .Edit),
                    label: {
                        Text(toDo.title)
                            //.padding(.top, 10)
                            .font(.system(size: 18))
                            .strikethrough(toDo.isComplete )
                            .foregroundColor(toDo.isComplete  ? .gray : .black)
                            .multilineTextAlignment(.leading)
                    })
                
                Label(title: { Text(toDo.dueDateString())
                        .foregroundColor(toDo.isComplete  ? .gray : .black)
                        .font(.system(size: 14))
                            },
                      icon: {Image(systemName: "calendar")
                        .foregroundColor(toDo.isComplete ? .gray : .black)
                        .font(.system(size: 14))
                    
                })
                //.padding(.top, 2)
            }
            .frame(maxHeight: .infinity)
            //.padding(.bottom, 10)
            
            Spacer()
            
            //display fraction
            if toDo.numberOfCheckList != 0 {
                FractionView(numberator: toDo.numberofCompletedCheckList(), denominator: toDo.numberOfCheckList)
                    .padding(.trailing, 5)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .cornerRadius(cornerRadiusValue)
        .background(.gray.opacity(0.15))
    }
}

struct FractionView: View {
    var numberator: Int
    var denominator: Int
    var body: some View {
        VStack (alignment: .center, spacing: 0){
            Text(String(numberator))
            Text("--")
            Text(String(denominator))
        }
        .font(.system(size: 10))
        .bold()
        
    }
}


struct CheckToDoView_Previews: PreviewProvider {
    @StateObject static var user = User.getASampleUser()
    
    static var previews: some View {
        CheckToDoView(toDo: $user.toDoList[4])
    }
}
