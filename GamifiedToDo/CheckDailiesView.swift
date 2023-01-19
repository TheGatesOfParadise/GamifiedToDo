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

struct CheckDailiesView: View {
    @State var hiddenFlag:Bool = false
    @Binding var daily: Dailies
    @EnvironmentObject var userModel: UserModel
    
    let checkColor:Color
    
    init(daily: Binding<Dailies>) {
        self._daily = daily
        checkColor = daily.difficulty.wrappedValue == .hard ? .pink : daily.difficulty.wrappedValue == .medium ? .orange : .green
    }
        
    var body: some View {
        HStack (alignment: .center){
            Image(systemName: daily.isComplete ? "checkmark.square.fill": "square")
                .frame(maxHeight: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(checkColor)
                .onTapGesture {
                    daily.isComplete.toggle()
                    
                    //force a view to update comes from this post:
                    //https://stackoverflow.com/questions/56561630/swiftui-forcing-an-update
                    userModel.updateView()
                    hiddenFlag.toggle()
                }
            
            VStack (alignment: .leading){
                NavigationLink(
                    destination:  DailiesDetailsView(daily: $daily, type: .Edit),
                    label: {
                        Text(daily.title)
                            .padding(.top, 10)
                            .font(.system(size: 18))
                            .strikethrough(daily.isComplete)
                            .foregroundColor(daily.isComplete ? .gray : .black)
                            .multilineTextAlignment(.leading)
                    })
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 10)
            
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .cornerRadius(cornerRadiusValue)
        .background(.gray.opacity(0.15))
    }
}

struct CheckDailiesView_Previews: PreviewProvider {
    @State static var user = User.getASampleUser()
    
    static var previews: some View {
        CheckDailiesView(daily: $user.dailiesList[0])
    }
}
