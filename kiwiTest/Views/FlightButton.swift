//
//  FlightButton.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 19.4.21..
//

import UIKit

class FlightButton: UIButton {
    
    var color: UIColor? {
        didSet {
            backgroundColor = color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        contentMode = .scaleToFill
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true

        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .selected)
    }
}
