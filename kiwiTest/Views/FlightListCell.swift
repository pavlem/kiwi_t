//
//  FlightListCell.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 16.4.21..
//

import UIKit

class FlightListCell: UITableViewCell {
    
    // MARK: - API    
    static let id = "FlightListCellID"

    var vm: FlightVM? {
        didSet {
            updateUI()
        }
    }
    
    var buyFlight: ((String) -> Void)?
    
    // MARK: - Properties
    @IBOutlet weak var destinationLbl: UILabel!
    @IBOutlet weak var buyBtn: FlightButton!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var onDateLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    // MARK: - Actions
    @IBAction func buy(_ sender: UIButton) {
        if let urlString = vm?.destionationUrlString {
            buyFlight?(urlString)
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    // MARK: - Helper
    private func setUI() {
        buyBtn.setTitle(FlightVM.buyBtnTitle, for: .normal)
    }
    
    private func updateUI() {
        backgroundColor = vm?.backGroundColor
        destinationLbl.text = vm?.destionationName
        fromLbl.text = vm?.from
        onDateLbl.text = vm?.date
        distanceLbl.text = vm?.distance
    }
}
