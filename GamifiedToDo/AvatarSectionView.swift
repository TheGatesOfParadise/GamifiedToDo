//
//  AvatarSelectionView.swift
//  GamifiedToDos
//
//  Created by Mom macbook air on 1/8/23.
//
///
///
///Images come from https://caravanshoppe.com/products/olliblocks-starter-pack?variant=1027912704
///

import SwiftUI

let iconWidth = 60.0
let body_width = 25.0

struct AvatarSelectionView: View {
    @EnvironmentObject var userModel : UserModel
    @State var selectedCategory: AvatarCategory = AvatarCategory.basic
    @State var selectedPart: AvatarPartType = AvatarPartType.head
    
    var body: some View {
        
        VStack (alignment: .center){
               
                HeaderAvatarView()
                .frame(width: shadeAreaWidth)
                .offset(y:5)

            Form {
                Section(header: Text("Choose"),
                        content: {
                    HStack {
                        Picker("Body Part", selection: $selectedPart) {
                            ForEach(AvatarPartType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        Spacer()
                    }
                    HStack {
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(AvatarCategory.allCases, id: \.self) { category in
                                Text(category.rawValue)
                            }
                        }
                        Spacer()
                    }
                })
                
                //image array
                Section {
                    Grid {
                        ForEach(0..<3) {row in
                            GridRow {
                                ForEach(1..<5) { column in
                                    ZStack{
                                        Image("\(selectedPart)_\(selectedCategory)_\(row * 4 + column)".lowercased())
                                            .resizable()
                                            .frame(width:iconWidth, height:iconWidth)
                                            .padding(.trailing, 15)
                                            .onTapGesture {
                                                calculateAvatar(part: selectedPart,
                                                                category: selectedCategory,
                                                                position: (row * 4 + column))
                                                
                                            }
                                        Text(String(needsAward(userModel: userModel, part: selectedPart,
                                                               category: selectedCategory,
                                                               position: (row * 4 + column)).coin))
                                        .bold()
                                        .offset(x: iconWidth/2-5, y: iconWidth/2 * -1)
                                        
                                        if needsAward(userModel: userModel, part: selectedPart,
                                                      category: selectedCategory,
                                                      position: (row * 4 + column)).coin > userModel.userTotalCoin{
                                            Rectangle()
                                                .frame(width:iconWidth, height:iconWidth)
                                                .padding(.trailing, 15)
                                                .foregroundColor(.gray.opacity(0.8))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    func needsAward (userModel: UserModel, part: AvatarPartType, category: AvatarCategory, position: Int) -> Award {
        return userModel.rules.getAward(avatarPart: AvatarPart(part:part, category: category, index: position))
        
    }
    
    //this func services this view
    func calculateAvatar (part: AvatarPartType, category: AvatarCategory, position: Int) {
        var index = 0
        for i in 0..<userModel.user.avatar.parts.count {
            if userModel.user.avatar.parts[i].part == part {
                index = i
            }
        }
        userModel.user.avatar.parts[index].category = category
        userModel.user.avatar.parts[index].index = position
        
        //force a view to update comes from this post:
        //https://stackoverflow.com/questions/56561630/swiftui-forcing-an-update
        userModel.updateView()
    }
}



//========================================================
//Dispalys an Avatar
//It accepts 1 paramter: Avatar
//This view assembles the avatar from the Avatar object

struct AvatarView: View {
    var avatar: Avatar
    
    var body: some View {
        VStack (spacing: 0){
            Image(avatar.parts[0].imageName)
                .resizable()
                .frame(width:body_width, height: body_width)
            Image(avatar.parts[1].imageName)
                .resizable()
                .frame(width:body_width, height: body_width)
            Image(avatar.parts[2].imageName)
                .resizable()
                .frame(width:body_width, height: body_width)
        }
        .padding()
    }
}

struct HeaderAvatarView: View {
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
    
            Image("Coin")
                .resizable()
                .frame(width: 25, height: 25)
            
            Text(String(format: "%i", userModel.userTotalCoin))
                .bold()
                .font(.system(size:18))
                .padding(.trailing, 10)
                .padding(.leading, 0)
            
            
        }
    }
}


//========================================================

struct AvatarSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarSelectionView().environmentObject(UserModel())
    }
}

