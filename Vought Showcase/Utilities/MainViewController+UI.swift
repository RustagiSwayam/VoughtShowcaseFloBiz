//
//  MainViewController+UI.swift
//  Vought Showcase
//
//  Created by Swayam Rustagi on 14/09/24.
//

import Foundation
import UIKit

extension MainViewController {
    
    func setupOpenCarouselButton() {
        openCarouselButton = UIButton(type: .custom)
        openCarouselButton.setImage(UIImage(named: "theBoys"), for: .normal)
        openCarouselButton.translatesAutoresizingMaskIntoConstraints = false
        openCarouselButton.layer.cornerRadius = 100
        openCarouselButton.clipsToBounds = true
        openCarouselButton.layer.borderWidth = 4
        openCarouselButton.layer.borderColor = UIColor.green.cgColor
        openCarouselButton.addTarget(self, action: #selector(openCarousel), for: .touchUpInside)
        view.addSubview(openCarouselButton)
        
        NSLayoutConstraint.activate([
            openCarouselButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openCarouselButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            openCarouselButton.widthAnchor.constraint(equalToConstant: 200),
            openCarouselButton.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupInfoLabel() {
        infoLabel = UILabel()
        infoLabel.text = "Tap above to see the team who beat The Seven"
        infoLabel.textColor = .black
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: openCarouselButton.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: openCarouselButton.bottomAnchor, constant: 20),
            infoLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -40),
            infoLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
    }
    
    @objc func openCarousel() {
        buttonTapped = true
        openCarouselButton.layer.borderColor = UIColor.gray.cgColor
        
        let carouselItemProvider = CarouselItemDataSourceProvider()
        let carouselViewController = CarouselViewController(items: carouselItemProvider.items())
        carouselViewController.modalPresentationStyle = .overFullScreen
        carouselViewController.modalTransitionStyle = .coverVertical
        present(carouselViewController, animated: true, completion: nil)
    }
}
