//
//  PremiumPurchaseView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/2.
//

import SwiftUI

struct PremiumPurchaseView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("icon_right_arrow").resizable().renderingMode(.template).foregroundColor(.textLevel1).frame(width: 24, height: 24).transformEffect(.init(rotationAngle: .pi))
                }

            }.padding([.leading, .trailing], 16)
        }.navigationBarBackButtonHidden(true)
        
//        HStack {
//            Spacer()
//        }.background {
//            
//        }.background(ignoresSafeArea(.all, edges: .all))
    }
}

//struct PremiumPurchaseView_Previews: PreviewProvider {
//    @State static var push = true
//
//    static var previews: some View {
//        PremiumPurchaseView(push: $push)
//    }
//}
