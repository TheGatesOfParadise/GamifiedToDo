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

struct AvatarSelectionView: View {
    @EnvironmentObject var userModel : UserModel
    @State var selectedCategory: AvatarCategory = AvatarCategory.basic
    @State var selectedPart: AvatarPartType = AvatarPartType.head
    @State var currentAvatar =  Avatar(parts: [AvatarPart(part: .head, category: .basic, index: 1),
                                               AvatarPart(part: .body, category: .basic, index: 1),
                                               AvatarPart(part: .bottom, category: .basic, index: 1)
                                              ]
                                        )

    var body: some View {
        Form {
            Section {
                AvatarView(avatar:currentAvatar)
            }
            
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
                                
                                Image("\(selectedPart)_\(selectedCategory)_\(row * 4 + column)".lowercased())
                                    .resizable()
                                    .frame(width:60, height:60)
                                    .padding()
                                    .onTapGesture {
                                        calculateAvatar(part: selectedPart,
                                                        category: selectedCategory,
                                                        position: (row * 4 + column))
                                        
                                    }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    //this func services this view
    func calculateAvatar (part: AvatarPartType, category: AvatarCategory, position: Int) {
        var index = 0
        for i in 0..<currentAvatar.parts.count {
            if currentAvatar.parts[i].part == part {
                index = i
            }
        }
        currentAvatar.parts[index].category = category
        currentAvatar.parts[index].index = position
    }
}



//========================================================
//Dispalys an Avatar
//It accepts 1 paramter: Avatar
//This view assembles the avatar from the Avatar object
let body_width = 25.0
struct AvatarView: View {
    @EnvironmentObject var userModel : UserModel
    var avatar: Avatar
    
    var body: some View {
        HStack{
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
            .padding(.leading, 30)
            
            Spacer()
            
            Image("Coin")
                .resizable()
                .frame(width: 25, height: 25)
            
            Text(String(format: "coin %i", userModel.userTotalCoin))
                .bold()
                .font(.system(size:18))
                .padding(.trailing, 10)
                .padding(.leading, 5)
        }
    }
}


//========================================================

struct AvatarSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarSelectionView().environmentObject(UserModel(user: User.getASampleUser(), rules: Rules()))
    }
}

