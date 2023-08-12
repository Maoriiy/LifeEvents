//
//  CreateEventView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/1.
//

import SwiftUI
import UIKit

class CreateEventContext: ObservableObject {
    @Published var selectIndex = 0
    @Published var eventName = ""
    @Published var selectPhoto: Photo = .allPhotos[0]
}

struct CreateEventView: View {
    
    @ObservedObject var context = CreateEventContext()
    
    @Binding var isPresenting: Bool
    
    @State var pushPhotoSelectView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Group {
                    Spacer().frame(height: 29)
                    Text("Adding an event").padding(.leading, 18).frame(height: 18)
                    Spacer().frame(height: 29)
                    HStack {
                        Spacer()
                        eventView
                        Spacer()
                    }
                    Spacer().frame(height: 30)
                    Text("Text setting").font(.system(size: 14)).foregroundColor(Color.textLevel1).padding(.leading, 16)
                    Spacer().frame(height: 22)
                    textField.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                    Spacer().frame(height: 21)
                }
                
                NavigationLink {
                   PhotoSelectView(context: context, push: $pushPhotoSelectView)
                } label: {
                    HStack(alignment: .center) {
                        Spacer().frame(width: 16)
                        Text("Background image")
                            .foregroundColor(.textLevel1)
                            .font(.system(size: 14))
                            .frame(height: 14)
                        Spacer()
                        Image("icon_right_arrow").resizable().frame(width: 24, height: 24)
                        Spacer().frame(width: 16)
                    }.frame(height: 24)
                }.navigationBarBackButtonHidden(true)

                PhotoPickerView(context: context, style: .HStack).frame(height: 150)
                
                Spacer().frame(height: 29)
                HStack(alignment: .center) {
                    Spacer()
                    Button {
                        self.isPresenting = false
                    } label: {
                        Text("Cancel").font(.system(size: 16, weight: .bold)).foregroundColor(.theme2)
                    }
                    .frame(width: 165, height: 44)
                    .background {
                        Color(hex: 0xEEF9D9)
                    }
                    .cornerRadius(22)
                    Spacer()
                    Button {

                    } label: {
                        Text("Save").font(.system(size: 16, weight: .bold)).foregroundColor(.white)
                    }.frame(width: 165, height: 44).background {
                        Color.theme1
                    }.cornerRadius(22)
                    Spacer()
                }.frame(height: 44)
                Spacer()
            }.ignoresSafeArea(.all, edges: .top).navigationBarBackButtonHidden()
        }
    }
    
    var eventView: some View {
        EventView(context: context).frame(width: 163, height: 217, alignment: .center) 
    }
    
    var textField: some View {
        
        Color(hex: 0xF7F9FC).cornerRadius(8).frame(height: 40).overlay {
            TextField(
                text: $context.eventName,
                prompt: Text("Give a name to the event")
                    .font(.system(size: 14))
                    .foregroundColor(.textLevel3),
                label: {
                    Label("", image: "")
                }
            ).font(.system(size: 14)).frame(height: 40).fixedSize(horizontal: false, vertical: false).frame(minHeight: 40).lineLimit(1).padding(.leading.union(.trailing), 16)
        }
    }
}

//struct CreateEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateEventView()
//    }
//}
