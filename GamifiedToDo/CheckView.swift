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
    var dueDate: String?
    var numberOfCompleteTask: Int?
    var numberOfTotoalTask: Int?
    var checkColor: Color
    
    func toggle(){isChecked = !isChecked}
    
    var body: some View {
        Button(action: toggle){
            
            HStack (alignment: .center){
                Text(Image(systemName: isChecked ? "checkmark.square.fill": "square"))
                    .frame(maxHeight: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .background(isChecked ? .green : checkColor)
                
                VStack (alignment: .leading){
                    Text(title)
                        .padding(.top, 10)
                        .font(.system(size: 18))
                        .strikethrough(isChecked)
                        .foregroundColor(isChecked ? .gray : .black)
                        .multilineTextAlignment(.leading)
                    
                    //this is an item from ToDo List
                    if dueDate != nil {
                        Label(title: { Text(dueDate!)
                                        .foregroundColor(isChecked ? .gray : .black)
                                        .font(.system(size: 14))
                                        },
                              icon: {Image(systemName: "calendar")
                                .foregroundColor(isChecked ? .gray : .black)
                                .font(.system(size: 14))
                            
                        })
                        .padding(.top, 2)
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.bottom, 10)
                
                Spacer()
                
                //display fraction
                if numberOfCompleteTask != nil && numberOfTotoalTask != nil {
                    FractionView(numberator: numberOfCompleteTask!, denominator: numberOfTotoalTask!)
                        .padding(.trailing, 5)
                }
                
                
            }
            .fixedSize(horizontal: false, vertical: true)
        }
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


struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView(title: "give Ashley's book back. brought the wrong book last time \u{1F600}",
                  dueDate: "1/19/23",
                  numberOfCompleteTask:1,
                  numberOfTotoalTask: 4,
                  checkColor: .red)
    }
}
