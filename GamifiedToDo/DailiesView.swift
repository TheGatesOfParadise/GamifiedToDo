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
                    HeaderDailiesView()
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

struct HeaderDailiesView: View {
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
            
            //add button
            NavigationLink(destination: {
                DailiesDetailsView(daily: $userModel.user.dailiesList[0], type: .New)
            }, label: {
                Text("+")
                    .font(.system(.largeTitle))
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color.white)
            })
            .background( Color.yellow.opacity(0.6))
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3)
            
            
        }
    }
}

struct BottomDailiesView: View {
    @EnvironmentObject var userModel : UserModel
    @State private var checked = true
    var body: some View {
        List {
            ForEach($userModel.user.dailiesList) { daily in
                HStack{
                    CheckDailiesView(daily: daily)
                        .cornerRadius(cornerRadiusValue)
                }
            }
            .onDelete(perform: { indexSet in
                guard let index = indexSet.first else {
                    return
                }
                userModel.user.dailiesList.remove(at: index)
                userModel.updateView()
            })
            .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            .listRowSeparator(.hidden)
        }
        // remove space at the top of List comes from this post:
        //https://developer.apple.com/forums/thread/662544
        .listStyle(PlainListStyle())
    }
}


struct DailiesView_Previews: PreviewProvider {
    
    static var previews: some View {
        DailiesView().environmentObject(UserModel())
    }
}
