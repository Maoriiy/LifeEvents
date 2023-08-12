//
//  EventView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/4.
//

import SwiftUI


struct EventView: View {
    @ObservedObject var context: CreateEventContext
    
    var body: some View {
        ZStack {
            Image(context.selectPhoto.imageName).resizable().cornerRadius(8)
            
            VStack {
                Spacer()
                Text(context.eventName.isEmpty ? "Give a name to the event" : context.eventName)
                    .font(.system(size: 16))
                    .foregroundColor(.white).shadow(color: .textLevel1, radius: 0)
                    .lineSpacing(0)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading.union(.trailing), 8)
                Spacer().frame(height: 16)
            }
            
        }
    }
}


struct StaticEventView: View {
    let event: Event
    
    var photo: Photo {
        .photo(Int(event.photoIndex))
    }
    
    var body: some View {
        ZStack {
            Image(photo.imageName).resizable().cornerRadius(8)
            
            VStack {
                Spacer()
                Text(event.name ?? "")
                    .font(.system(size: 16))
                    .foregroundColor(.white).shadow(color: .textLevel1, radius: 0)
                    .lineSpacing(0)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading.union(.trailing), 8)
                Spacer().frame(height: 16)
            }
            
        }
    }
}

//struct EventView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventView()
//    }
//}
