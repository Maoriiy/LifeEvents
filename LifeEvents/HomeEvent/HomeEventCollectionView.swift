//
//  HomeEventCollectionView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/6/30.
//

import Foundation
import UIKit
import SwiftUI

//struct HomeEventCollectionView: UIViewRepresentable {
//    typealias UIViewType = UICollectionView
//    
//    var collectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = .init(width: 163, height: 217)
//        flowLayout.scrollDirection = .vertical
//        flowLayout.minimumInteritemSpacing = 17
//        flowLayout.minimumLineSpacing = 17
//        flowLayout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
//        
//        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        
//        view.showsVerticalScrollIndicator = false
//        view.alwaysBounceVertical = true
//        
//        view.contentInset = .init(top: 0, left: 0, bottom: 74, right: 0)
//        view.backgroundColor = .clear
//        return view
//    }()
//    
//    private let eventCollectionViewModel: EventCollectionViewModel
//    
//    func makeUIView(context: Context) -> UICollectionView {
//        collectionView
//    }
//    
//    func updateUIView(_ uiView: UICollectionView, context: Context) {
//        
//    }
//    
//    init() {
//        eventCollectionViewModel = .init(collectionView)
//    }
//}
//
//private class EventCollectionViewModel: NSObject {
//    var dataSource = EventDataSource()
//    var collectionView: UICollectionView
//    
//    init(_ collectionView: UICollectionView) {
//        self.collectionView  = collectionView
//        super.init()
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(HomeEventCell.self, forCellWithReuseIdentifier: String(describing: HomeEventCell.self))
//    }
//    
//}
//
//extension EventCollectionViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeEventCell.self), for: indexPath) as? HomeEventCell else {
//            return .init()
//        }
//        return cell
//    }
//    
//    
//}
