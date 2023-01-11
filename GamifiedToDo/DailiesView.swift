//
//  DailiesView.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/10/23.
//

import SwiftUI

struct DailiesView: View {
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
            BottomDailiesView(dailiesList: user.DailiesList)
                .frame(width: shadeAreaWidth)
            //.border(.blue, width: 1)
            
            Spacer()
            
        }
    }
}

struct BottomDailiesView: View {
    var dailiesList: [Dailies]
    @State private var checked = true
    var body: some View {
        
        ForEach(dailiesList) { daily in
           
            HStack{
                
                CheckView(title: daily.title,
                          checkColor: daily.difficulty == .hard ? .pink : daily.difficulty == .medium ? .orange : .green)
                    .cornerRadius(cornerRadiusValue)
            }
        }
    }
}


struct DailiesView_Previews: PreviewProvider {
    @State static var user = User.getASampleUser()
    
    static var previews: some View {
        DailiesView(user:$user)
    }
}
