//
//  Photo.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/3.
//

import Foundation

class Photo: Decodable, Identifiable {
    typealias ID = Int
    var id: Int { index }
    let index: Int
    let imageName: String
    let isPremium: Bool
    
    private enum CodingKeys: String, CodingKey {
        case index, imageName, isPremium
    }
        
    static var allPhotos: [Photo] = {
        if let path = Bundle.main.path(forResource: "Photos", ofType: "plist"),
           let array =  NSArray(contentsOfFile: path) as? [[String: Any]],
           let photos = parseModel(data: array, type: [Photo].self) {
            return photos
        }
        return []
    }()
    
    static func photo(_ index: Int) -> Photo {
        allPhotos[index]
    }
    
}

public
func parseModel<T: Decodable>(data: Any, type: T.Type) -> T? {
    do {
        let data = try JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
        let model = try JSONDecoder().decode(type, from: data)
        return model
    } catch {
        debugPrint(error.localizedDescription)
        return nil
    }
}
