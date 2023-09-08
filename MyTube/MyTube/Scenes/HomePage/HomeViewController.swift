//
//  HomeViewController.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit
import Combine
import SwiftUI

final class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
        collectionView.refreshControl = refresh
        collectionView.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.identifier)
        collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "YouTube"
        view.backgroundColor = .systemBackground
        setLayout()
        bindViewModel()
        viewModel.getThumbnailData()
    }
    
    deinit {
        print("deinit - HomeVC")
    }
}

private extension HomeViewController {
    func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindViewModel() {
        viewModel.$ThumbnailList.sink { [weak self] thumbnails in
            guard let self = self else { return }
            print("thumbnails: \(thumbnails)")
            DispatchQueue.main.async {
                self.collectionView.refreshControl?.endRefreshing()
                self.collectionView.reloadData()
            }
        }.store(in: &subscriptions)
    }
    
    @objc func refreshCollection() {
        collectionView.refreshControl?.beginRefreshing()
        viewModel.refresh = true
        viewModel.getThumbnailData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ThumbnailList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier,
                                                            for: indexPath) as? ThumbnailCell else { return UICollectionViewCell() }
        let item = viewModel.ThumbnailList[indexPath.item]
        cell.configure(data: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 24
        return CGSize(width: view.bounds.width - inset * 2, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snippet = viewModel.ThumbnailList[indexPath.item].snippet
        let data = viewModel.ThumbnailList[indexPath.item]
        guard let videoID = snippet.thumbnails.high.url.getVideoID() else { return }
        let url = "https://youtu.be/" + videoID
        let detailVC = DetailPageController()
        detailVC.configureData(url: url, data: data)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.identifier, for: indexPath) as? SearchHeaderView else { return UICollectionReusableView() }
        header.configure(viewModel: viewModel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        if (currentRow % viewModel.display) == viewModel.display - 5
            && (currentRow / viewModel.display) == (viewModel.getRequestPage - 1) {
            viewModel.getThumbnailData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// SwiftUI를 활용한 미리보기
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct HomeVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let homeViewController = HomeViewController()
        return UINavigationController(rootViewController: homeViewController)
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
