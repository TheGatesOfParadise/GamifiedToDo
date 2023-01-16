//
//  Test3.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/11/23.
//

import SwiftUI

struct Test3: View {
    @State var percent: CGFloat = 0.35
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    Color(UIColor(red:11/255.0,
                                  green: 15/255.0,
                                  blue: 128/255.0,
                                  alpha: 1))
                    
                    ZStack {
                        //track circle
                        Circle()
                            .stroke(.white.opacity(0.3),
                                    style: StrokeStyle(lineWidth: 30))
                            .frame(width: 200, height: 200)
                        
                        //Andimation circle
                        Circle()
                            .trim(from:0, to: percent)
                            .stroke(.yellow,
                                    style: StrokeStyle(lineWidth: 30))
                            .rotationEffect(.init(degrees: -90))
                            .animation(Animation.linear(duration:0.8), value: percent)
                            .frame(width: 200, height: 200)
                        
                        
                        Text("\(Int(self.percent * 100.0))%")
                            .foregroundColor(.white)
                            .font(.system(size:52))
                            
                        
                    }.padding()
                }

                HStack (spacing: 10){
                    Button(action: {
                        guard percent < 1.0 else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(5/15), execute: {
                            self.percent += 10/100
                        })
                    },
                           label: {
                        Text("10")
                            .frame(width: 60, height: 80)
                            .border(.red, width: 5)
                    })
                    
                    Button(action: {
                        guard percent < 1.0 else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(5/15), execute: {
                            self.percent += 20/100
                        })
                        
                    },
                           label: {
                        Text("20")
                            .frame(width: 60, height: 80)
                            .border(.green, width: 5)
                    })
                    
                    Button(action: {
                        guard percent < 1.0 else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(5/15), execute: {
                            self.percent += 15/100
                        })
                    },
                           label: {
                        Text("15")
                            .frame(width: 60, height: 80)
                            .border(.blue, width: 5)
                    })
                }
                Spacer()
            }
        }
    }
}



struct Test3_Previews: PreviewProvider {
    @State static var user = User.getASampleUser()
    static var previews: some View {
        Test3()
    }
}
