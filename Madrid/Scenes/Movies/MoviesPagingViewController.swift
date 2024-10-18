//
//  MoviesPagingViewController.swift
//  Madrid
//
//  Created by Aung Bo Bo on 05/06/2024.
//

import Parchment
import SnapKit
import UIKit

final class MoviesPagingViewController: UIViewController {
    private var pagingViewController: PagingViewController!
    
    private let viewControllers: [UIViewController]
    
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
    }
    
    private func configureHierarchy() {
        configureView()
        configurePagingViewController()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configurePagingViewController() {
        pagingViewController = PagingViewController(viewControllers: viewControllers)
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.dataSource = self
        pagingViewController.select(pagingItem: MoviesPagingItem(title: viewControllers[0].title, index: 0))
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 120, height: 48)
        pagingViewController.font = .preferredFont(forTextStyle: .subheadline)
        pagingViewController.indicatorColor = .systemBrown
        pagingViewController.borderColor = .clear
        pagingViewController.register(MoviesPagingCell.self, for: MoviesPagingItem.self)
        pagingViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pagingViewController.didMove(toParent: self)
    }
}

// MARK: - PagingViewControllerDataSource
extension MoviesPagingViewController: PagingViewControllerDataSource {
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return viewControllers.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return viewControllers[index]
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> any PagingItem {
        return MoviesPagingItem(title: viewControllers[index].title, index: index)
    }
}
