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
        NavigationView {
            
            ZStack {
                VStack (alignment: .center){
                    //show avatar
                    HeaderView(user: user)
                        .frame(width: shadeAreaWidth)
                       //.padding(.bottom, 10)
                    //.border(.red, width: 1)
                        .offset(y:5)
                    
                    //show award
                    MiddleView(user: user)
                        .frame(width: shadeAreaWidth, height: 70)
                        //.padding(.bottom, 10)
                    //.border(.green, width: 1)
                    
                    //list of todos
                    BottomDailiesView(dailiesList: user.DailiesList)
                        .frame(width: shadeAreaWidth)
                    //.border(.blue, width: 1)
                    
                    Spacer()
                }
                
                AddButtonPopup()
                
            }
        }
    }
}

struct BottomDailiesView: View {
    var dailiesList: [Dailies]
    @State private var checked = true
    var body: some View {
        
        ForEach(dailiesList) { daily in
           
            HStack{
                CheckDailiesView(daily: daily)
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
