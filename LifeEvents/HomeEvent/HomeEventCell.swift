//
//  HomeEventCell.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/6/29.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

struct HomeEventView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    var view = HomeEventCell()
    
    func makeUIView(context: Context) -> UIView {
        view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

class HomeEventCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textLevel1
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "TTTTTTTTT"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoView)
        addSubview(titleLabel)
        
        photoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
            make.bottom.equalTo(-8)
            make.height.equalTo(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
