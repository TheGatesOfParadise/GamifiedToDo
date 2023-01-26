
///TODO:  when an avatar is selected, adjust coins. 
///
///Images come from https://caravanshoppe.com/products/olliblocks-starter-pack?variant=1027912704
///

import SwiftUI

let iconWidth = 60.0
let body_width = 25.0

struct AvatarSelectionView: View {
    @EnvironmentObject var dataModel : DataModel
    @State var selectedCategory: AvatarCategory = AvatarCategory.basic
    @State var selectedPart: AvatarPartType = AvatarPartType.head
    @State var selectedIndex: Int = 1
    @State var localAvatar = Avatar.getSampleAvatar()
    @State var selecteAward: Award = Award(coin:5)
    @State var alertPresented = false
    
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
                                                selectedIndex = row * 4 + column
                                                localAvatar = getNewAvatar(part: selectedPart,
                                                                           category: selectedCategory,
                                                                           position: selectedIndex)
                                                selecteAward = needsAward(part: selectedPart,
                                                                          category: selectedCategory,
                                                                          position: selectedIndex)
                                                alertPresented.toggle()
                                            }
                                        Text(String(needsAward(part: selectedPart,
                                                                      category: selectedCategory,
                                                                      position: (row * 4 + column)).coin))
                                        .bold()
                                        .offset(x: iconWidth/2-5, y: iconWidth/2 * -1)
                                        
                                        if needsAward(part: selectedPart,
                                                                category: selectedCategory,
                                                                position: (row * 4 + column)).coin > dataModel.user.award.coin{
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
                .sheet(isPresented:$alertPresented) {
                    CompareAvtarView(newAvatar: localAvatar,
                                     newAvatarAward: selecteAward,
                                     alertPresented: $alertPresented)
                        .presentationDetents([.medium])
                }

            }
        }
    }
    
    func needsAward (part: AvatarPartType, category: AvatarCategory, position: Int) -> Award {
        return dataModel.rules.getAward(avatarPart: AvatarPart(part:part, category: category, index: position))
        
    }
    
    func getNewAvatar (part: AvatarPartType, category: AvatarCategory, position: Int) -> Avatar{
        var newAvatar =  dataModel.user.avatar
        for i in 0..<dataModel.user.avatar.parts.count {
            if dataModel.user.avatar.parts[i].part == part {
                newAvatar.parts[i].category = category
                newAvatar.parts[i].index = position
                break
            }
        }
        return newAvatar
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

struct CompareAvtarView: View {
    @EnvironmentObject var dataModel : DataModel
    var newAvatar: Avatar
    var newAvatarAward: Award
    @Binding var alertPresented: Bool
    
    var body: some View {
        VStack{
            HStack {
                AvatarView(avatar: newAvatar)
                    .frame(width:80, height:80)
                    .background(.yellow.opacity(0.2))
                
                Text("Sure to get this new avatar?")
            }
            
            HStack (spacing: 25){
                Button(action: {alertPresented.toggle()},
                       label: {ButtonText(title: "No")})
                Button(action: {
                    dataModel.user.avatar = newAvatar
                    alertPresented.toggle()
                    dataModel.user.award.minus(award: newAvatarAward)
                    dataModel.user.avatar = newAvatar
                    dataModel.updateView()
                },
                       label: {ButtonText(title: "Yes")})
            }
        }
    }
    
    struct ButtonText: View {
       // let isDisabled: Bool
        let title: String
        var body: some View {
            Text(title)
                .frame(width: 100,
                       height: 50,
                       alignment: .center)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct HeaderAvatarView: View {
    @EnvironmentObject var dataModel : DataModel
    
    var body: some View {
        HStack {
            AvatarView(avatar: dataModel.user.avatar)
                .frame(width:80, height:80)
                .background(.yellow.opacity(0.2))
            
            VStack (alignment: .leading, spacing: 10){
                Text("\(Date().greetings()) \(dataModel.user.name)!")
                Text(Date().today())
                    .font(.system(size: 10))
            }
            
            Spacer()
            
            Image("Coin")
                .resizable()
                .frame(width: 25, height: 25)
            
            Text(String(format: "%i", dataModel.user.award.coin))
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
        AvatarSelectionView().environmentObject(DataModel())
    }
}

