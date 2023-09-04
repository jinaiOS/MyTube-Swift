//
//  HomeViewController.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

    }
 
    deinit {
        print("deinit - HomeVC")
    }
}