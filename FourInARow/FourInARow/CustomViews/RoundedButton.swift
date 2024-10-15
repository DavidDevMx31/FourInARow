//
//  RoundedButton.swift
//  FourInARow
//
//  Created by David Ali on 15/10/24.
//

import UIKit

class RoundedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("Default", for: .normal)
        backgroundColor = .white
        tintColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        configuration = UIButton.Configuration.filled()
        configuration?.title = title
        configuration?.baseBackgroundColor = backgroundColor
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        configuration?.cornerStyle = UIButton.Configuration.CornerStyle.medium
    }
    
}
