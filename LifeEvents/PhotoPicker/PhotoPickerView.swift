//
//  PhotoPickerView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/1.
//

import SwiftUI

struct PhotoPickerView: View {
    @ObservedObject var context: CreateEventContext
    
    enum Style {
        case HStack
        case VGrid
    }
    
    let style: Style
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        if style == .HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: 12) {
                    ForEach(Photo.allPhotos) { photo in
                        PhotoView(context: context, photo: photo).frame(width: 106, height: 141)
                            .tag(photo.index).onTapGesture {
                                self.context.selectIndex = photo.index
                                self.context.selectPhoto = photo
                            }
                    }
                }.padding(.init(top: 9, leading: 16, bottom: 0, trailing: 16))
            }
        } else if style == .VGrid {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [.init(), .init(), .init()], spacing: 8) {
                    ForEach(Photo.allPhotos) { photo in
                        
                        PhotoView(context: context, photo: photo)
                            .tag(photo.index).onTapGesture {
                                self.context.selectIndex = photo.index
                                self.context.selectPhoto = photo
                            }
                            .frame(height: (screenWidth - 16 * 4) / 3 * 1.33)
                    }
                }
            }
        }
    }
    
}

//struct PhotoPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoPickerView()
//    }
//}
