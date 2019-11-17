//
//  StrategyButton.swift
//  ISINChart
//
//  Created by Veaceslav Chirita on 11/17/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit

class StrategyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.render()
    }

    func render() {
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.52)
        layer.masksToBounds = true
        layer.cornerRadius = 20
    }
}
