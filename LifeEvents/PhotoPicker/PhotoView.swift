//
//  PhotoView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/1.
//

import SwiftUI

struct PhotoView: View {
    @ObservedObject var context: CreateEventContext
    let photo: Photo
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(photo.imageName).resizable().cornerRadius(8)
            Image(context.selectIndex == photo.index ? "icon_selected" : "icon_unselected")
                .resizable().frame(width: 16, height: 16)
                .padding(.top.union(.trailing), 8)
            if photo.isPremium {
                Image("icon_preimium").resizable().frame(width: 36, height: 36).padding([.top, .trailing], -18)
            }
        }
    }
}

//struct PhotoPickView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoPickView(index: 0, $true)
//    }
//}
