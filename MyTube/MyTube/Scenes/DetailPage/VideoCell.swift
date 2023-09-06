//
//  VideoCell.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/06.
//

import UIKit

class VideoCell: UICollectionViewCell {
    static let identifier = "VideoCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private lazy var profileView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        [titleLabel, profileLabel].forEach { stackView.addArrangedSubview($0)}
        return stackView
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        [profileView, titleStackView].forEach { stackView.addArrangedSubview($0)}
        return stackView
    }()
    
    private lazy var collectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 9
        [profileStackView, profileView].forEach{ stackView.addArrangedSubview($0)}
        return stackView
    }()
    
    private func setLayout() {
        contentView.addSubview(collectionStackView)
        collectionStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
