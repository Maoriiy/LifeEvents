//
//  Toast.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/6.
//

import Foundation
import SwiftUI

extension View {
    public func toastEventSave(isPresenting: Binding<Bool>) -> some View {
        modifier(ToastModifier(isPresent: isPresenting))
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isPresent: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresent {
                VStack {
                    Spacer().frame(height: 58)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer().frame(width: 12)
                            Image("icon_done").resizable().frame(width: 24, height: 24)
                            Spacer().frame(width: 8)
                            Text("Saved successfully").font(.system(size: 14)).foregroundColor(.textLevel2)
                            Spacer().frame(width: 12)
                           
                            Text("Editor").font(.system(size: 14)).foregroundStyle(
                                LinearGradient(
                                    colors: [.green1, .green2],
                                  startPoint: .leading,
                                  endPoint: .trailing
                                )
                            )
                            .frame(width: 64, height: 28)
                            .overlay {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke( LinearGradient.green, lineWidth: 1)
                            }
                                
                            Spacer().frame(width: 12)
                        }
                        Spacer()
                    }
                    .background {
                        Color.init(hex: 0xF7F9FC).cornerRadius(16).clipped()
                    }
                    .frame(height: 47)
                    Spacer()
                }.transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeOut(duration: 0.1)) {
                                self.isPresent = false
                            }
                        }
                    }
            }
        }
    }
}
