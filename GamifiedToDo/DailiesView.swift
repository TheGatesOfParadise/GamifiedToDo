//
//  DailiesView.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/10/23.
//

import SwiftUI

struct DailiesView: View {
    @EnvironmentObject var userModel : UserModel
    
    var body: some View {
        NavigationView {
            
            ZStack {
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
                    BottomDailiesView()
                        .frame(width: shadeAreaWidth)
                    //.border(.blue, width: 1)
                    
                    Spacer()
                }
                
               // AddButtonPopup()
                
            }
        }
    }
}

struct BottomDailiesView: View {
    @EnvironmentObject var userModel : UserModel
    @State private var checked = true
    var body: some View {
        
        ForEach($userModel.user.dailiesList) { daily in
           
            HStack{
                CheckDailiesView(daily: daily)
                    .cornerRadius(cornerRadiusValue)
            }
        }
    }
}


struct DailiesView_Previews: PreviewProvider {
    
    static var previews: some View {
        DailiesView().environmentObject(UserModel(user: User.getASampleUser(), rules: Rules()))
    }
}
