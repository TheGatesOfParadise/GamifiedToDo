
import SwiftUI

struct Test1View: View {
    @State var isChecked:Bool = false
    
    var title:String
    var dueDate: String?
    var numberOfCompleteTask: Int?
    var numberOfTotoalTask: Int?
    var checkColor: Color
    
    func toggle(){isChecked = !isChecked}
    
    var body: some View {
        NavigationView {
            
            HStack (alignment: .center){
                Image(systemName: isChecked ? "checkmark.square.fill": "square")
                    .frame(maxHeight: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .background(isChecked ? .green : checkColor)
                    .onTapGesture {
                        toggle()
                    }
                
                VStack (alignment: .leading){
                    NavigationLink(
                        destination: ToDoDetailsView(),
                        label: {
                            Text(title)
                                .padding(.top, 10)
                                .font(.system(size: 18))
                                .strikethrough(isChecked)
                                .foregroundColor(isChecked ? .gray : .black)
                                .multilineTextAlignment(.leading)
                        })
                    
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
            .cornerRadius(cornerRadiusValue)
            .background(.gray.opacity(0.15))
            
        }
        
    }
}

struct Test1View_Previews: PreviewProvider {
    static var previews: some View {
        Test1View(title: "give Ashley's book back. brought the wrong book last time \u{1F600}",
                  dueDate: "1/19/23",
                  numberOfCompleteTask:1,
                  numberOfTotoalTask: 4,
                  checkColor: .red)
    }
}

