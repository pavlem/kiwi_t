//
//  FlightsImageView.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 18.4.21..
//

import UIKit

class FlightsImageView: UIImageView {
    
    // MARK: - API
    func setImage(withName imageName: String, fail: @escaping (NetworkError) -> Void) {
        
        if let img = self.imageCache.object(forKey: imageName as NSString) {
            self.set(image: img, withTransition: self.imgTransitionDuration)
            return
        }
        
        urlSessionDataTask = flightInfoService.fetchFlightToImage(imageName: imageName) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .failure(let err):
                fail(err)
            case .success(let image):
                self.imageCache.setObject(image, forKey: imageName as NSString)
                self.set(image: image, withTransition: self.imgTransitionDuration)
            }
        }
    }
    
    // MARK: - Properties
    private var urlSessionDataTask: URLSessionDataTask?
    private let flightInfoService = FlightInfoService()
    private let imgPlaceholder = "imgPlaceholder"
    private let imgTransitionDuration = 0.75
    private var imageCache = NSCache<NSString, UIImage>()

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image = UIImage(named: imgPlaceholder)
    }
    
    // MARK: - Helper
    private func set(image: UIImage, withTransition transition: Double) {
        DispatchQueue.main.async {
            UIView.transition(with: self,
                              duration: transition,
                              options: .transitionCrossDissolve,
                              animations: { self.image = image },
                              completion: nil)
        }
    }
}
