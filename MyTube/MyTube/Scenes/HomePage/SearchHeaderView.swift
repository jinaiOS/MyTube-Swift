//
//  SearchView.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class SearchHeaderView: UICollectionReusableView {
    
    static let identifier = "SearchHeaderView"
    private var viewModel: HomeViewModel?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어 입력"
        searchBar.delegate = self
        return searchBar
    }()
    
    func configure(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(searchBar)
        
        searchBar.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

extension SearchHeaderView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        viewModel?.refresh = true
        viewModel?.searchText = text
        viewModel?.getThumbnailData()
        endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel?.refresh = true
            viewModel?.searchText = nil
        }
    }
}
