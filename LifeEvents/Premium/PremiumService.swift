//
//  PremiumService.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/2.
//

import UIKit
import SwiftUI

class PremiumService {
    static let shared = PremiumService()
    
    enum PremiumType {
        case none
        case month
        case year
        case lifetime
        
        var cost: Double {
            switch self {
            case .month:
                return 1.99
            case .year:
                return 9.99
            case .lifetime:
                return 19.99
            default:
                return 0
            }
        }
    }
    
    /// 是否会员
    var isPremium: Bool = false
    
    var premiumType: PremiumType = .none
    
    static func routeToPremium() {

    }
    
    func getPremiumInfo() {
        
    }
    
    func restore() {
        
    }
    
    func purchase() {
        
    }
    
    
}
