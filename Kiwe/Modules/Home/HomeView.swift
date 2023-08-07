//
//  HomeView.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 07/08/2023.
//

import UIKit

class HomeView: UIView {

    init() {
        super.init(frame: .zero)
        styleView()
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
   
    private func styleView() {
        backgroundColor = .white
    }
}
