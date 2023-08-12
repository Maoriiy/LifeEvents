//
//  PhotoSelectView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/4.
//

import SwiftUI

struct PhotoSelectView: View {
    @ObservedObject var context: CreateEventContext
    
    @Binding var push: Bool
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Spacer().frame(height: 8)
            HStack(alignment: .center) {
                Spacer().frame(width: 16)
                Button {
                    dismiss()
                } label: {
                    Image(decorative: (UIImage(named: "icon_right_arrow")?.cgImage)!, scale: UIScreen.main.scale, orientation: .upMirrored).resizable().renderingMode(.template).foregroundColor(.textLevel1).frame(width: 24, height: 24).transformEffect(CGAffineTransformMakeTranslation(-1, 1))
                }.frame(width: 24, height: 24)
                Spacer()
                Text("Background image").font(.system(size: 18)).foregroundColor(.textLevel1)
                Spacer()
                EmptyView().frame(width: 24, height: 24)
                Spacer().frame(width: 16)
            }.frame(height: 44)
            PhotoPickerView(context: context, style: .VGrid).padding([.leading, .trailing], 16)
        }.navigationBarBackButtonHidden(true).ignoresSafeArea(.all, edges: .top)
    }
}

//struct PhotoSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoSelectView()
//    }
//}
