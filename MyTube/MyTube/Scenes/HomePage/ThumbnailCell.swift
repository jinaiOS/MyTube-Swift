//
//  ThumbnailCell.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class ThumbnailCell: UICollectionViewCell {
    static let identifier = "ThumbnailCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var channelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        label.snp.makeConstraints {
            $0.width.height.equalTo(34)
        }
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        [titleLabel, subTitleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var subStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        [channelTitle, titleStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 9
        stackView.alignment = .fill
        stackView.distribution = .fill
        [imageView, subStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private func setLayout() {
        contentView.addSubview(mainStackView)

        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    func configure(data: Thumbnails.Item) {
        let url = data.snippet.thumbnails.high.url
        Task {
            let image = await ImageCacheManager.shared.loadImage(url: url)
            imageView.image = image
        }
        channelTitle.text = data.snippet.channelTitle
        titleLabel.text = data.snippet.title
        subTitleLabel.text = data.snippet.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
