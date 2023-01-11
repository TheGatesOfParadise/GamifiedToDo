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

struct CheckView: View {
    @State var isChecked:Bool = false
    
    var title:String
    var checkColor: Color
    
    func toggle(){isChecked = !isChecked}
    
    var body: some View {
        Button(action: toggle){
            
            HStack (alignment: .center){
                Text(Image(systemName: isChecked ? "checkmark.square.fill": "square"))
                    .padding()
                    .foregroundColor(.black)
                    .background(isChecked ? .green : checkColor)
                
                Text(title)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .font(.system(size: 18))
                    .strikethrough(isChecked)
                    .foregroundColor(isChecked ? .gray : .black)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
        }
        .cornerRadius(cornerRadiusValue)
        .background(.gray.opacity(0.15))
    }
}


struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView(title: "give Ashley's book back. brought the wrong book last time \u{1F600}", checkColor: .red)
    }
}
