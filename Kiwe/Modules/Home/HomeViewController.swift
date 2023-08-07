//
//  HomeViewController.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 07/08/2023.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel: HomeViewModel
    let customView: HomeView
    
    // State
    private var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - Methods
    
    init(view: HomeView, viewModel: HomeViewModel) {
        self.customView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
