//
//  MoviesPagingCell.swift
//  Madrid
//
//  Created by Aung Bo Bo on 05/06/2024.
//

import Parchment
import SnapKit
import UIKit

final class MoviesPagingCell: PagingCell {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHierarchy()
    }
    
    override func setPagingItem(_ pagingItem: any PagingItem, selected: Bool, options: PagingOptions) {
        guard let item = pagingItem as? MoviesPagingItem else { return }
        label.text = item.title
        label.font = options.font
    }
    
    private func configureHierarchy() {
        configureView()
        configureLabel()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func configureLabel() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
